import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState {
  final int selectedIndex;
  const NavigationState(this.selectedIndex);
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(const NavigationState(0));

  void setTab(int index) {
    if (state.selectedIndex != index) {
      state = NavigationState(index);
    }
  }
}

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});
