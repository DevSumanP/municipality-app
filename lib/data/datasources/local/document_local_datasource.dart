import '../../../core/database/app_database.dart';
import '../../../core/database/tables/documents_table.dart';
import '../../models/document_model.dart';

class DocumentLocalDataSource {
  final AppDatabase database;

  DocumentLocalDataSource({required this.database});

  Future<List<DocumentsTable>> getAllDocuments() async {
    return await database.documentsDao.getAllDocuments();
  }

  Future<DocumentsTable?> getDocumentById(int id) async {
    return await database.documentsDao.getDocumentById(id);
  }

  Future<List<DocumentsTable>> getDocumentsByType(String type) async {
    return await database.documentsDao.getDocumentsByType(type);
  }

  Future<List<DocumentsTable>> getDownloadedDocuments() async {
    return await database.documentsDao.getDownloadedDocuments();
  }

  Future<void> saveNotices(List<Notice> notices) async {
    // Delete existing notices
    final existingNotices = await getDocumentsByType('notice');
    for (final notice in existingNotices) {
      await database.documentsDao.deleteDocument(notice.id);
    }
    
    // Convert and insert new notices
    final noticeTables = notices.map((notice) => DocumentsTable(
      id: notice.id,
      userId: notice.userId,
      title: notice.title,
      description: notice.description,
      type: 'notice',
      imageUrl: notice.imageUrl.isNotEmpty ? notice.imageUrl : null,
      fileUrl: notice.fileUrl.isNotEmpty ? notice.fileUrl : null,
      isDownloaded: false,
      status: notice.status,
      createdAt: notice.createdAt,
      updatedAt: notice.updatedAt,
      isUpdated: notice.isUpdated,
    )).toList();

    await database.documentsDao.insertAllDocuments(noticeTables);
  }

  Future<void> saveScrollingNews(List<ScrollingNews> scrollingNews) async {
    // Delete existing scrolling news
    final existingNews = await getDocumentsByType('scrolling_news');
    for (final news in existingNews) {
      await database.documentsDao.deleteDocument(news.id);
    }
    
    // Convert and insert new scrolling news
    final newsTables = scrollingNews.map((news) => DocumentsTable(
      id: news.id,
      userId: news.userId,
      title: news.title,
      description: '', // Scrolling news doesn't have description
      type: 'scrolling_news',
      isDownloaded: false,
      status: news.status,
      createdAt: news.createdAt,
      updatedAt: news.updatedAt,
      isUpdated: '0', // Scrolling news doesn't have isUpdated field
    )).toList();

    await database.documentsDao.insertAllDocuments(newsTables);
  }

  Future<void> saveDocument(DocumentsTable document) async {
    await database.documentsDao.insertDocument(document);
  }

  Future<void> updateDocument(DocumentsTable document) async {
    await database.documentsDao.updateDocument(document);
  }

  Future<void> deleteDocument(int id) async {
    await database.documentsDao.deleteDocument(id);
  }

  Future<void> deleteAllDocuments() async {
    await database.documentsDao.deleteAllDocuments();
  }
}
