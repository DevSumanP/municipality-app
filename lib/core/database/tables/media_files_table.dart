import 'package:drift/drift.dart';

@DataClassName('MediaFilesTable')
class MediaFiles extends Table {
  IntColumn get id => integer()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get type => text()(); // 'image', 'video', 'document', 'audio'
  TextColumn get url => text()();
  TextColumn get localPath => text().nullable()();
  BoolColumn get isDownloaded => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'CHECK (type IN (\'image\', \'video\', \'document\', \'audio\'))',
  ];
}