import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/datasources/remote/auth_remote_datasource.dart';
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/models/user_model.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/local_storage.dart';
import '../../core/exceptions/app_exceptions.dart';

// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final localStorage = LocalStorage();

  return AuthRepository(
    remoteDataSource: AuthRemoteDataSource(dioClient: dioClient),
    localDataSource: AuthLocalDataSource(localStorage: localStorage),
  );
});

// Auth state
class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final User? user;
  final String? error;
  final String? accessToken;

  const AuthState({
    this.isLoading = true,
    this.isLoggedIn = false,
    this.user,
    this.error,
    this.accessToken,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    User? user,
    String? error,
    String? accessToken,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      error: error,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  bool get hasError => error != null;
  bool get isAuthenticated => isLoggedIn && user != null && accessToken != null;
}

// Auth notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    try {
      state = state.copyWith(isLoading: true);

      final isLoggedInResult = await _authRepository.isLoggedIn();

      await isLoggedInResult.fold(
        (error) {
          state = state.copyWith(
            isLoading: false,
            error: error.message,
            isLoggedIn: false,
          );
        },
        (isLoggedIn) async {
          if (isLoggedIn) {
            final authDataResult = await _authRepository.getLocalAuthData();
            final accessTokenResult = await _authRepository.getAccessToken();

            authDataResult.fold(
              (error) => state = state.copyWith(
                isLoading: false,
                error: error.message,
                isLoggedIn: false,
              ),
              (authData) async {
                await accessTokenResult.fold(
                  (error) => state = state.copyWith(
                    isLoading: false,
                    error: error.message,
                    isLoggedIn: false,
                  ),
                  (accessToken) => state = state.copyWith(
                    isLoading: false,
                    isLoggedIn: true,
                    user: authData?.data.user,
                    accessToken: accessToken,
                    error: null,
                  ),
                );
              },
            );
          } else {
            state = state.copyWith(
              isLoading: false,
              isLoggedIn: false,
              error: null,
            );
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to initialize authentication: $e',
        isLoggedIn: false,
      );
    }
  }

  Future<void> login(String email, String password) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final result = await _authRepository.login(email, password);

      result.fold(
        (error) {
          print('Login failed with error: ${error.message}');
          state = state.copyWith(
            isLoading: false,
            isLoggedIn: false,
            error: error.message,
          );
        },
        (authModel) {
          state = state.copyWith(
            isLoading: false,
            isLoggedIn: true,
            user: authModel.data.user,
            accessToken: authModel.data.accessToken,
            error: null,
          );
        },
      );
    } on AppException catch (e) {
      print('Login AppException: ${e.message}');
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: false,
        error: e.message,
      );
    } catch (e) {
      print('Unexpected error during login: $e');
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: false,
        error: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final result = await _authRepository.logout();

      result.fold(
        (error) {
          // Even if logout fails on server, clear local data
          state = const AuthState();
        },
        (success) {
          state = const AuthState();
        },
      );
    } catch (e) {
      // Clear state even on error
      state = const AuthState();
    }
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  Future<void> refreshAuthState() async {
    await _initializeAuth();
  }
}

// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

// Convenience providers
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoggedIn;
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).error;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

// Access token provider for API calls
final accessTokenProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).accessToken;
});
