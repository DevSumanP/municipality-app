import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/documents_table.dart';

part 'documents_dao.g.dart';

@DriftAccessor(tables: [Documents])
class DocumentsDao extends DatabaseAccessor<AppDatabase> with _$DocumentsDaoMixin {
  DocumentsDao(AppDatabase db) : super(db);

  // Get all documents
  Future<List<DocumentsTable>> getAllDocuments() async {
    return await select(documents).get();
  }

  // Get document by ID
  Future<DocumentsTable?> getDocumentById(int id) async {
    return await (select(documents)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Get documents by type
  Future<List<DocumentsTable>> getDocumentsByType(String type) async {
    return await (select(documents)
      ..where((tbl) => tbl.type.equals(type))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get downloaded documents
  Future<List<DocumentsTable>> getDownloadedDocuments() async {
    return await (select(documents)..where((tbl) => tbl.isDownloaded.equals(true))).get();
  }

  // Get documents count
  Future<int> getDocumentsCount() async {
    final query = selectOnly(documents)..addColumns([documents.id.count()]);
    final result = await query.getSingle();
    return result.read(documents.id.count()) ?? 0;
  }

  // Get documents count by type
  Future<int> getDocumentsCountByType(String type) async {
    final query = selectOnly(documents)
      ..addColumns([documents.id.count()])
      ..where(documents.type.equals(type));
    final result = await query.getSingle();
    return result.read(documents.id.count()) ?? 0;
  }

  // Insert single document
  Future<int> insertDocument(DocumentsTable document) async {
    return await into(documents).insert(document, mode: InsertMode.insertOrReplace);
  }

  // Insert multiple documents
  Future<void> insertAllDocuments(List<DocumentsTable> documentsList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(documents, documentsList);
    });
  }

  // Update document
  Future<bool> updateDocument(DocumentsTable document) async {
    return await update(documents).replace(document);
  }

  // Update download status
  Future<int> updateDownloadStatus(int id, bool isDownloaded, String? localPath) async {
    return await (update(documents)..where((tbl) => tbl.id.equals(id)))
        .write(DocumentsCompanion(
          isDownloaded: Value(isDownloaded),
        ));
  }

  // Delete document
  Future<int> deleteDocument(int id) async {
    return await (delete(documents)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Delete documents by type
  Future<int> deleteDocumentsByType(String type) async {
    return await (delete(documents)..where((tbl) => tbl.type.equals(type))).go();
  }

  // Delete all documents
  Future<int> deleteAllDocuments() async {
    return await delete(documents).go();
  }

  // Search documents
  Future<List<DocumentsTable>> searchDocuments(String query) async {
    return await (select(documents)
      ..where((tbl) => 
        tbl.title.contains(query) | 
        tbl.description.contains(query))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get recent documents (last 30 days)
  Future<List<DocumentsTable>> getRecentDocuments({int limit = 10}) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30)).toIso8601String();
    
    return await (select(documents)
      ..where((tbl) => tbl.createdAt.isBiggerThanValue(thirtyDaysAgo))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
      ..limit(limit)
    ).get();
  }

  // Get updated documents
  Future<List<DocumentsTable>> getUpdatedDocuments() async {
    return await (select(documents)
      ..where((tbl) => tbl.isUpdated.equals('1'))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.updatedAt, mode: OrderingMode.desc)])
    ).get();
  }
}