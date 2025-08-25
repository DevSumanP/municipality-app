import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/data/datasources/local/document_local_datasource.dart';
import '../../data/repositories/document_repository.dart';
import '../../data/datasources/remote/document_remote_datasource.dart';
import '../../core/network/dio_client.dart';
import 'database_provider.dart';

// Document repository provider
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  final database = ref.watch(appDatabaseProvider);
  
  return DocumentRepository(
    remoteDataSource: DocumentRemoteDataSource(dioClient: dioClient),
    localDataSource: DocumentLocalDataSource(database: database),
  );
});
