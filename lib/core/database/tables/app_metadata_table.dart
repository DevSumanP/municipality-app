import 'package:floor/floor.dart';

@entity
class AppMetadataTable {
  @primaryKey
  final String key;
  final String value;
  final String updatedAt;

  const AppMetadataTable({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
}