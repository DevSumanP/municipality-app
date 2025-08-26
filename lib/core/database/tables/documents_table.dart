import 'package:drift/drift.dart';

@DataClassName('DocumentsTable')
class Documents extends Table {
  IntColumn get id => integer()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get type => text()(); // 'notice', 'scrolling_news', 'video'
  TextColumn get imageUrl => text().nullable()();
  TextColumn get fileUrl => text().nullable()();
  BoolColumn get isDownloaded => boolean().withDefault(const Constant(false))();
  TextColumn get status => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get isUpdated => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'CHECK (type IN (\'notice\', \'scrolling_news\', \'video\'))',
      ];
}
