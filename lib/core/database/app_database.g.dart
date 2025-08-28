// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, DocumentsTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileUrlMeta =
      const VerificationMeta('fileUrl');
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
      'file_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDownloadedMeta =
      const VerificationMeta('isDownloaded');
  @override
  late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>(
      'is_downloaded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_downloaded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isUpdatedMeta =
      const VerificationMeta('isUpdated');
  @override
  late final GeneratedColumn<String> isUpdated = GeneratedColumn<String>(
      'is_updated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        title,
        description,
        type,
        imageUrl,
        fileUrl,
        isDownloaded,
        status,
        createdAt,
        updatedAt,
        isUpdated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(Insertable<DocumentsTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('file_url')) {
      context.handle(_fileUrlMeta,
          fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta));
    }
    if (data.containsKey('is_downloaded')) {
      context.handle(
          _isDownloadedMeta,
          isDownloaded.isAcceptableOrUnknown(
              data['is_downloaded']!, _isDownloadedMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_updated')) {
      context.handle(_isUpdatedMeta,
          isUpdated.isAcceptableOrUnknown(data['is_updated']!, _isUpdatedMeta));
    } else if (isInserting) {
      context.missing(_isUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentsTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentsTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      fileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_url']),
      isDownloaded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_downloaded'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      isUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}is_updated'])!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class DocumentsTable extends DataClass implements Insertable<DocumentsTable> {
  final int id;
  final String userId;
  final String title;
  final String description;
  final String type;
  final String? imageUrl;
  final String? fileUrl;
  final bool isDownloaded;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;
  const DocumentsTable(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.type,
      this.imageUrl,
      this.fileUrl,
      required this.isDownloaded,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.isUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    map['is_downloaded'] = Variable<bool>(isDownloaded);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['is_updated'] = Variable<String>(isUpdated);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      description: Value(description),
      type: Value(type),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
      isDownloaded: Value(isDownloaded),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isUpdated: Value(isUpdated),
    );
  }

  factory DocumentsTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentsTable(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
      isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      isUpdated: serializer.fromJson<String>(json['isUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<String>(type),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'fileUrl': serializer.toJson<String?>(fileUrl),
      'isDownloaded': serializer.toJson<bool>(isDownloaded),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'isUpdated': serializer.toJson<String>(isUpdated),
    };
  }

  DocumentsTable copyWith(
          {int? id,
          String? userId,
          String? title,
          String? description,
          String? type,
          Value<String?> imageUrl = const Value.absent(),
          Value<String?> fileUrl = const Value.absent(),
          bool? isDownloaded,
          String? status,
          String? createdAt,
          String? updatedAt,
          String? isUpdated}) =>
      DocumentsTable(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description ?? this.description,
        type: type ?? this.type,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
        isDownloaded: isDownloaded ?? this.isDownloaded,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isUpdated: isUpdated ?? this.isUpdated,
      );
  DocumentsTable copyWithCompanion(DocumentsCompanion data) {
    return DocumentsTable(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      isDownloaded: data.isDownloaded.present
          ? data.isDownloaded.value
          : this.isDownloaded,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isUpdated: data.isUpdated.present ? data.isUpdated.value : this.isUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsTable(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isUpdated: $isUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, description, type,
      imageUrl, fileUrl, isDownloaded, status, createdAt, updatedAt, isUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentsTable &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.imageUrl == this.imageUrl &&
          other.fileUrl == this.fileUrl &&
          other.isDownloaded == this.isDownloaded &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isUpdated == this.isUpdated);
}

class DocumentsCompanion extends UpdateCompanion<DocumentsTable> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> description;
  final Value<String> type;
  final Value<String?> imageUrl;
  final Value<String?> fileUrl;
  final Value<bool> isDownloaded;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> isUpdated;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isUpdated = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String title,
    required String description,
    required String type,
    this.imageUrl = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    required String status,
    required String createdAt,
    required String updatedAt,
    required String isUpdated,
  })  : userId = Value(userId),
        title = Value(title),
        description = Value(description),
        type = Value(type),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        isUpdated = Value(isUpdated);
  static Insertable<DocumentsTable> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? imageUrl,
    Expression<String>? fileUrl,
    Expression<bool>? isDownloaded,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? isUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (imageUrl != null) 'image_url': imageUrl,
      if (fileUrl != null) 'file_url': fileUrl,
      if (isDownloaded != null) 'is_downloaded': isDownloaded,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isUpdated != null) 'is_updated': isUpdated,
    });
  }

  DocumentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? title,
      Value<String>? description,
      Value<String>? type,
      Value<String?>? imageUrl,
      Value<String?>? fileUrl,
      Value<bool>? isDownloaded,
      Value<String>? status,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String>? isUpdated}) {
    return DocumentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (isDownloaded.present) {
      map['is_downloaded'] = Variable<bool>(isDownloaded.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (isUpdated.present) {
      map['is_updated'] = Variable<String>(isUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isUpdated: $isUpdated')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, EmployeesTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _designationIdMeta =
      const VerificationMeta('designationId');
  @override
  late final GeneratedColumn<String> designationId = GeneratedColumn<String>(
      'designation_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _departmentIdMeta =
      const VerificationMeta('departmentId');
  @override
  late final GeneratedColumn<String> departmentId = GeneratedColumn<String>(
      'department_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roomNumberMeta =
      const VerificationMeta('roomNumber');
  @override
  late final GeneratedColumn<String> roomNumber = GeneratedColumn<String>(
      'room_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
      'order', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isUpdatedMeta =
      const VerificationMeta('isUpdated');
  @override
  late final GeneratedColumn<String> isUpdated = GeneratedColumn<String>(
      'is_updated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        designationId,
        categoryId,
        departmentId,
        name,
        phone,
        email,
        roomNumber,
        image,
        order,
        status,
        createdAt,
        updatedAt,
        isUpdated,
        imageUrl
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<EmployeesTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('designation_id')) {
      context.handle(
          _designationIdMeta,
          designationId.isAcceptableOrUnknown(
              data['designation_id']!, _designationIdMeta));
    } else if (isInserting) {
      context.missing(_designationIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('department_id')) {
      context.handle(
          _departmentIdMeta,
          departmentId.isAcceptableOrUnknown(
              data['department_id']!, _departmentIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('room_number')) {
      context.handle(
          _roomNumberMeta,
          roomNumber.isAcceptableOrUnknown(
              data['room_number']!, _roomNumberMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_updated')) {
      context.handle(_isUpdatedMeta,
          isUpdated.isAcceptableOrUnknown(data['is_updated']!, _isUpdatedMeta));
    } else if (isInserting) {
      context.missing(_isUpdatedMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmployeesTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeesTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      designationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}designation_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      departmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}department_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      roomNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}room_number']),
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      isUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}is_updated'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class EmployeesTable extends DataClass implements Insertable<EmployeesTable> {
  final int id;
  final String userId;
  final String designationId;
  final String categoryId;
  final String? departmentId;
  final String name;
  final String? phone;
  final String? email;
  final String? roomNumber;
  final String? image;
  final String order;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;
  final String? imageUrl;
  const EmployeesTable(
      {required this.id,
      required this.userId,
      required this.designationId,
      required this.categoryId,
      this.departmentId,
      required this.name,
      this.phone,
      this.email,
      this.roomNumber,
      this.image,
      required this.order,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.isUpdated,
      this.imageUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['designation_id'] = Variable<String>(designationId);
    map['category_id'] = Variable<String>(categoryId);
    if (!nullToAbsent || departmentId != null) {
      map['department_id'] = Variable<String>(departmentId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || roomNumber != null) {
      map['room_number'] = Variable<String>(roomNumber);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    map['order'] = Variable<String>(order);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['is_updated'] = Variable<String>(isUpdated);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      userId: Value(userId),
      designationId: Value(designationId),
      categoryId: Value(categoryId),
      departmentId: departmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(departmentId),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      roomNumber: roomNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(roomNumber),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      order: Value(order),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isUpdated: Value(isUpdated),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
    );
  }

  factory EmployeesTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeesTable(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      designationId: serializer.fromJson<String>(json['designationId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      departmentId: serializer.fromJson<String?>(json['departmentId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      roomNumber: serializer.fromJson<String?>(json['roomNumber']),
      image: serializer.fromJson<String?>(json['image']),
      order: serializer.fromJson<String>(json['order']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      isUpdated: serializer.fromJson<String>(json['isUpdated']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'designationId': serializer.toJson<String>(designationId),
      'categoryId': serializer.toJson<String>(categoryId),
      'departmentId': serializer.toJson<String?>(departmentId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'roomNumber': serializer.toJson<String?>(roomNumber),
      'image': serializer.toJson<String?>(image),
      'order': serializer.toJson<String>(order),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'isUpdated': serializer.toJson<String>(isUpdated),
      'imageUrl': serializer.toJson<String?>(imageUrl),
    };
  }

  EmployeesTable copyWith(
          {int? id,
          String? userId,
          String? designationId,
          String? categoryId,
          Value<String?> departmentId = const Value.absent(),
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> roomNumber = const Value.absent(),
          Value<String?> image = const Value.absent(),
          String? order,
          String? status,
          String? createdAt,
          String? updatedAt,
          String? isUpdated,
          Value<String?> imageUrl = const Value.absent()}) =>
      EmployeesTable(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        designationId: designationId ?? this.designationId,
        categoryId: categoryId ?? this.categoryId,
        departmentId:
            departmentId.present ? departmentId.value : this.departmentId,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        roomNumber: roomNumber.present ? roomNumber.value : this.roomNumber,
        image: image.present ? image.value : this.image,
        order: order ?? this.order,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isUpdated: isUpdated ?? this.isUpdated,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
      );
  EmployeesTable copyWithCompanion(EmployeesCompanion data) {
    return EmployeesTable(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      designationId: data.designationId.present
          ? data.designationId.value
          : this.designationId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      departmentId: data.departmentId.present
          ? data.departmentId.value
          : this.departmentId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      roomNumber:
          data.roomNumber.present ? data.roomNumber.value : this.roomNumber,
      image: data.image.present ? data.image.value : this.image,
      order: data.order.present ? data.order.value : this.order,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isUpdated: data.isUpdated.present ? data.isUpdated.value : this.isUpdated,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesTable(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('designationId: $designationId, ')
          ..write('categoryId: $categoryId, ')
          ..write('departmentId: $departmentId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('image: $image, ')
          ..write('order: $order, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isUpdated: $isUpdated, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      designationId,
      categoryId,
      departmentId,
      name,
      phone,
      email,
      roomNumber,
      image,
      order,
      status,
      createdAt,
      updatedAt,
      isUpdated,
      imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeesTable &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.designationId == this.designationId &&
          other.categoryId == this.categoryId &&
          other.departmentId == this.departmentId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.roomNumber == this.roomNumber &&
          other.image == this.image &&
          other.order == this.order &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isUpdated == this.isUpdated &&
          other.imageUrl == this.imageUrl);
}

class EmployeesCompanion extends UpdateCompanion<EmployeesTable> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> designationId;
  final Value<String> categoryId;
  final Value<String?> departmentId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> roomNumber;
  final Value<String?> image;
  final Value<String> order;
  final Value<String> status;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> isUpdated;
  final Value<String?> imageUrl;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.designationId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.departmentId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.roomNumber = const Value.absent(),
    this.image = const Value.absent(),
    this.order = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isUpdated = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String designationId,
    required String categoryId,
    this.departmentId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.roomNumber = const Value.absent(),
    this.image = const Value.absent(),
    required String order,
    required String status,
    required String createdAt,
    required String updatedAt,
    required String isUpdated,
    this.imageUrl = const Value.absent(),
  })  : userId = Value(userId),
        designationId = Value(designationId),
        categoryId = Value(categoryId),
        name = Value(name),
        order = Value(order),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        isUpdated = Value(isUpdated);
  static Insertable<EmployeesTable> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? designationId,
    Expression<String>? categoryId,
    Expression<String>? departmentId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? roomNumber,
    Expression<String>? image,
    Expression<String>? order,
    Expression<String>? status,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? isUpdated,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (designationId != null) 'designation_id': designationId,
      if (categoryId != null) 'category_id': categoryId,
      if (departmentId != null) 'department_id': departmentId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (roomNumber != null) 'room_number': roomNumber,
      if (image != null) 'image': image,
      if (order != null) 'order': order,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isUpdated != null) 'is_updated': isUpdated,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  EmployeesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? designationId,
      Value<String>? categoryId,
      Value<String?>? departmentId,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? roomNumber,
      Value<String?>? image,
      Value<String>? order,
      Value<String>? status,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String>? isUpdated,
      Value<String?>? imageUrl}) {
    return EmployeesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      designationId: designationId ?? this.designationId,
      categoryId: categoryId ?? this.categoryId,
      departmentId: departmentId ?? this.departmentId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      roomNumber: roomNumber ?? this.roomNumber,
      image: image ?? this.image,
      order: order ?? this.order,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isUpdated: isUpdated ?? this.isUpdated,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (designationId.present) {
      map['designation_id'] = Variable<String>(designationId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (departmentId.present) {
      map['department_id'] = Variable<String>(departmentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (roomNumber.present) {
      map['room_number'] = Variable<String>(roomNumber.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (isUpdated.present) {
      map['is_updated'] = Variable<String>(isUpdated.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('designationId: $designationId, ')
          ..write('categoryId: $categoryId, ')
          ..write('departmentId: $departmentId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('roomNumber: $roomNumber, ')
          ..write('image: $image, ')
          ..write('order: $order, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isUpdated: $isUpdated, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $ServicesTable extends Services
    with TableInfo<$ServicesTable, ServicesTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _departmentIdMeta =
      const VerificationMeta('departmentId');
  @override
  late final GeneratedColumn<String> departmentId = GeneratedColumn<String>(
      'department_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _proposalSampleMeta =
      const VerificationMeta('proposalSample');
  @override
  late final GeneratedColumn<String> proposalSample = GeneratedColumn<String>(
      'proposal_sample', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _videoMeta = const VerificationMeta('video');
  @override
  late final GeneratedColumn<String> video = GeneratedColumn<String>(
      'video', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraDocumentMeta =
      const VerificationMeta('extraDocument');
  @override
  late final GeneratedColumn<String> extraDocument = GeneratedColumn<String>(
      'extra_document', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
      'order', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isUpdatedMeta =
      const VerificationMeta('isUpdated');
  @override
  late final GeneratedColumn<String> isUpdated = GeneratedColumn<String>(
      'is_updated', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _videoUrlMeta =
      const VerificationMeta('videoUrl');
  @override
  late final GeneratedColumn<String> videoUrl = GeneratedColumn<String>(
      'video_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileUrlMeta =
      const VerificationMeta('fileUrl');
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
      'file_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraFileUrlMeta =
      const VerificationMeta('extraFileUrl');
  @override
  late final GeneratedColumn<String> extraFileUrl = GeneratedColumn<String>(
      'extra_file_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        departmentId,
        title,
        description,
        proposalSample,
        video,
        extraDocument,
        status,
        order,
        createdAt,
        updatedAt,
        isUpdated,
        videoUrl,
        fileUrl,
        extraFileUrl
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(Insertable<ServicesTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('department_id')) {
      context.handle(
          _departmentIdMeta,
          departmentId.isAcceptableOrUnknown(
              data['department_id']!, _departmentIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('proposal_sample')) {
      context.handle(
          _proposalSampleMeta,
          proposalSample.isAcceptableOrUnknown(
              data['proposal_sample']!, _proposalSampleMeta));
    }
    if (data.containsKey('video')) {
      context.handle(
          _videoMeta, video.isAcceptableOrUnknown(data['video']!, _videoMeta));
    }
    if (data.containsKey('extra_document')) {
      context.handle(
          _extraDocumentMeta,
          extraDocument.isAcceptableOrUnknown(
              data['extra_document']!, _extraDocumentMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_updated')) {
      context.handle(_isUpdatedMeta,
          isUpdated.isAcceptableOrUnknown(data['is_updated']!, _isUpdatedMeta));
    } else if (isInserting) {
      context.missing(_isUpdatedMeta);
    }
    if (data.containsKey('video_url')) {
      context.handle(_videoUrlMeta,
          videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta));
    }
    if (data.containsKey('file_url')) {
      context.handle(_fileUrlMeta,
          fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta));
    }
    if (data.containsKey('extra_file_url')) {
      context.handle(
          _extraFileUrlMeta,
          extraFileUrl.isAcceptableOrUnknown(
              data['extra_file_url']!, _extraFileUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServicesTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServicesTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      departmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}department_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      proposalSample: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}proposal_sample']),
      video: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video']),
      extraDocument: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra_document']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      isUpdated: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}is_updated'])!,
      videoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video_url']),
      fileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_url']),
      extraFileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra_file_url']),
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }
}

class ServicesTable extends DataClass implements Insertable<ServicesTable> {
  final int id;
  final String userId;
  final String? departmentId;
  final String title;
  final String description;
  final String? proposalSample;
  final String? video;
  final String? extraDocument;
  final String status;
  final String order;
  final String createdAt;
  final String updatedAt;
  final String isUpdated;
  final String? videoUrl;
  final String? fileUrl;
  final String? extraFileUrl;
  const ServicesTable(
      {required this.id,
      required this.userId,
      this.departmentId,
      required this.title,
      required this.description,
      this.proposalSample,
      this.video,
      this.extraDocument,
      required this.status,
      required this.order,
      required this.createdAt,
      required this.updatedAt,
      required this.isUpdated,
      this.videoUrl,
      this.fileUrl,
      this.extraFileUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || departmentId != null) {
      map['department_id'] = Variable<String>(departmentId);
    }
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || proposalSample != null) {
      map['proposal_sample'] = Variable<String>(proposalSample);
    }
    if (!nullToAbsent || video != null) {
      map['video'] = Variable<String>(video);
    }
    if (!nullToAbsent || extraDocument != null) {
      map['extra_document'] = Variable<String>(extraDocument);
    }
    map['status'] = Variable<String>(status);
    map['order'] = Variable<String>(order);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['is_updated'] = Variable<String>(isUpdated);
    if (!nullToAbsent || videoUrl != null) {
      map['video_url'] = Variable<String>(videoUrl);
    }
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    if (!nullToAbsent || extraFileUrl != null) {
      map['extra_file_url'] = Variable<String>(extraFileUrl);
    }
    return map;
  }

  ServicesCompanion toCompanion(bool nullToAbsent) {
    return ServicesCompanion(
      id: Value(id),
      userId: Value(userId),
      departmentId: departmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(departmentId),
      title: Value(title),
      description: Value(description),
      proposalSample: proposalSample == null && nullToAbsent
          ? const Value.absent()
          : Value(proposalSample),
      video:
          video == null && nullToAbsent ? const Value.absent() : Value(video),
      extraDocument: extraDocument == null && nullToAbsent
          ? const Value.absent()
          : Value(extraDocument),
      status: Value(status),
      order: Value(order),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isUpdated: Value(isUpdated),
      videoUrl: videoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(videoUrl),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
      extraFileUrl: extraFileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(extraFileUrl),
    );
  }

  factory ServicesTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServicesTable(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      departmentId: serializer.fromJson<String?>(json['departmentId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      proposalSample: serializer.fromJson<String?>(json['proposalSample']),
      video: serializer.fromJson<String?>(json['video']),
      extraDocument: serializer.fromJson<String?>(json['extraDocument']),
      status: serializer.fromJson<String>(json['status']),
      order: serializer.fromJson<String>(json['order']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      isUpdated: serializer.fromJson<String>(json['isUpdated']),
      videoUrl: serializer.fromJson<String?>(json['videoUrl']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
      extraFileUrl: serializer.fromJson<String?>(json['extraFileUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'departmentId': serializer.toJson<String?>(departmentId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'proposalSample': serializer.toJson<String?>(proposalSample),
      'video': serializer.toJson<String?>(video),
      'extraDocument': serializer.toJson<String?>(extraDocument),
      'status': serializer.toJson<String>(status),
      'order': serializer.toJson<String>(order),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'isUpdated': serializer.toJson<String>(isUpdated),
      'videoUrl': serializer.toJson<String?>(videoUrl),
      'fileUrl': serializer.toJson<String?>(fileUrl),
      'extraFileUrl': serializer.toJson<String?>(extraFileUrl),
    };
  }

  ServicesTable copyWith(
          {int? id,
          String? userId,
          Value<String?> departmentId = const Value.absent(),
          String? title,
          String? description,
          Value<String?> proposalSample = const Value.absent(),
          Value<String?> video = const Value.absent(),
          Value<String?> extraDocument = const Value.absent(),
          String? status,
          String? order,
          String? createdAt,
          String? updatedAt,
          String? isUpdated,
          Value<String?> videoUrl = const Value.absent(),
          Value<String?> fileUrl = const Value.absent(),
          Value<String?> extraFileUrl = const Value.absent()}) =>
      ServicesTable(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        departmentId:
            departmentId.present ? departmentId.value : this.departmentId,
        title: title ?? this.title,
        description: description ?? this.description,
        proposalSample:
            proposalSample.present ? proposalSample.value : this.proposalSample,
        video: video.present ? video.value : this.video,
        extraDocument:
            extraDocument.present ? extraDocument.value : this.extraDocument,
        status: status ?? this.status,
        order: order ?? this.order,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isUpdated: isUpdated ?? this.isUpdated,
        videoUrl: videoUrl.present ? videoUrl.value : this.videoUrl,
        fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
        extraFileUrl:
            extraFileUrl.present ? extraFileUrl.value : this.extraFileUrl,
      );
  ServicesTable copyWithCompanion(ServicesCompanion data) {
    return ServicesTable(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      departmentId: data.departmentId.present
          ? data.departmentId.value
          : this.departmentId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      proposalSample: data.proposalSample.present
          ? data.proposalSample.value
          : this.proposalSample,
      video: data.video.present ? data.video.value : this.video,
      extraDocument: data.extraDocument.present
          ? data.extraDocument.value
          : this.extraDocument,
      status: data.status.present ? data.status.value : this.status,
      order: data.order.present ? data.order.value : this.order,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isUpdated: data.isUpdated.present ? data.isUpdated.value : this.isUpdated,
      videoUrl: data.videoUrl.present ? data.videoUrl.value : this.videoUrl,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      extraFileUrl: data.extraFileUrl.present
          ? data.extraFileUrl.value
          : this.extraFileUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServicesTable(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('departmentId: $departmentId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('proposalSample: $proposalSample, ')
          ..write('video: $video, ')
          ..write('extraDocument: $extraDocument, ')
          ..write('status: $status, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isUpdated: $isUpdated, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('extraFileUrl: $extraFileUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      departmentId,
      title,
      description,
      proposalSample,
      video,
      extraDocument,
      status,
      order,
      createdAt,
      updatedAt,
      isUpdated,
      videoUrl,
      fileUrl,
      extraFileUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServicesTable &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.departmentId == this.departmentId &&
          other.title == this.title &&
          other.description == this.description &&
          other.proposalSample == this.proposalSample &&
          other.video == this.video &&
          other.extraDocument == this.extraDocument &&
          other.status == this.status &&
          other.order == this.order &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isUpdated == this.isUpdated &&
          other.videoUrl == this.videoUrl &&
          other.fileUrl == this.fileUrl &&
          other.extraFileUrl == this.extraFileUrl);
}

class ServicesCompanion extends UpdateCompanion<ServicesTable> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String?> departmentId;
  final Value<String> title;
  final Value<String> description;
  final Value<String?> proposalSample;
  final Value<String?> video;
  final Value<String?> extraDocument;
  final Value<String> status;
  final Value<String> order;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> isUpdated;
  final Value<String?> videoUrl;
  final Value<String?> fileUrl;
  final Value<String?> extraFileUrl;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.departmentId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.proposalSample = const Value.absent(),
    this.video = const Value.absent(),
    this.extraDocument = const Value.absent(),
    this.status = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isUpdated = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.extraFileUrl = const Value.absent(),
  });
  ServicesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.departmentId = const Value.absent(),
    required String title,
    required String description,
    this.proposalSample = const Value.absent(),
    this.video = const Value.absent(),
    this.extraDocument = const Value.absent(),
    required String status,
    required String order,
    required String createdAt,
    required String updatedAt,
    required String isUpdated,
    this.videoUrl = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.extraFileUrl = const Value.absent(),
  })  : userId = Value(userId),
        title = Value(title),
        description = Value(description),
        status = Value(status),
        order = Value(order),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        isUpdated = Value(isUpdated);
  static Insertable<ServicesTable> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? departmentId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? proposalSample,
    Expression<String>? video,
    Expression<String>? extraDocument,
    Expression<String>? status,
    Expression<String>? order,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? isUpdated,
    Expression<String>? videoUrl,
    Expression<String>? fileUrl,
    Expression<String>? extraFileUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (departmentId != null) 'department_id': departmentId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (proposalSample != null) 'proposal_sample': proposalSample,
      if (video != null) 'video': video,
      if (extraDocument != null) 'extra_document': extraDocument,
      if (status != null) 'status': status,
      if (order != null) 'order': order,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isUpdated != null) 'is_updated': isUpdated,
      if (videoUrl != null) 'video_url': videoUrl,
      if (fileUrl != null) 'file_url': fileUrl,
      if (extraFileUrl != null) 'extra_file_url': extraFileUrl,
    });
  }

  ServicesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String?>? departmentId,
      Value<String>? title,
      Value<String>? description,
      Value<String?>? proposalSample,
      Value<String?>? video,
      Value<String?>? extraDocument,
      Value<String>? status,
      Value<String>? order,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String>? isUpdated,
      Value<String?>? videoUrl,
      Value<String?>? fileUrl,
      Value<String?>? extraFileUrl}) {
    return ServicesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      departmentId: departmentId ?? this.departmentId,
      title: title ?? this.title,
      description: description ?? this.description,
      proposalSample: proposalSample ?? this.proposalSample,
      video: video ?? this.video,
      extraDocument: extraDocument ?? this.extraDocument,
      status: status ?? this.status,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isUpdated: isUpdated ?? this.isUpdated,
      videoUrl: videoUrl ?? this.videoUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      extraFileUrl: extraFileUrl ?? this.extraFileUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (departmentId.present) {
      map['department_id'] = Variable<String>(departmentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (proposalSample.present) {
      map['proposal_sample'] = Variable<String>(proposalSample.value);
    }
    if (video.present) {
      map['video'] = Variable<String>(video.value);
    }
    if (extraDocument.present) {
      map['extra_document'] = Variable<String>(extraDocument.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (isUpdated.present) {
      map['is_updated'] = Variable<String>(isUpdated.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (extraFileUrl.present) {
      map['extra_file_url'] = Variable<String>(extraFileUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('departmentId: $departmentId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('proposalSample: $proposalSample, ')
          ..write('video: $video, ')
          ..write('extraDocument: $extraDocument, ')
          ..write('status: $status, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isUpdated: $isUpdated, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('extraFileUrl: $extraFileUrl')
          ..write(')'))
        .toString();
  }
}

class $MediaFilesTable extends MediaFiles
    with TableInfo<$MediaFilesTable, MediaFilesTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaFilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDownloadedMeta =
      const VerificationMeta('isDownloaded');
  @override
  late final GeneratedColumn<bool> isDownloaded = GeneratedColumn<bool>(
      'is_downloaded', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_downloaded" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        title,
        type,
        url,
        localPath,
        isDownloaded,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_files';
  @override
  VerificationContext validateIntegrity(Insertable<MediaFilesTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('is_downloaded')) {
      context.handle(
          _isDownloadedMeta,
          isDownloaded.isAcceptableOrUnknown(
              data['is_downloaded']!, _isDownloadedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaFilesTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaFilesTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      isDownloaded: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_downloaded'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MediaFilesTable createAlias(String alias) {
    return $MediaFilesTable(attachedDatabase, alias);
  }
}

class MediaFilesTable extends DataClass implements Insertable<MediaFilesTable> {
  final int id;
  final String userId;
  final String title;
  final String type;
  final String url;
  final String? localPath;
  final bool isDownloaded;
  final String createdAt;
  final String updatedAt;
  const MediaFilesTable(
      {required this.id,
      required this.userId,
      required this.title,
      required this.type,
      required this.url,
      this.localPath,
      required this.isDownloaded,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    map['is_downloaded'] = Variable<bool>(isDownloaded);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  MediaFilesCompanion toCompanion(bool nullToAbsent) {
    return MediaFilesCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      type: Value(type),
      url: Value(url),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      isDownloaded: Value(isDownloaded),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaFilesTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaFilesTable(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      url: serializer.fromJson<String>(json['url']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      isDownloaded: serializer.fromJson<bool>(json['isDownloaded']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'url': serializer.toJson<String>(url),
      'localPath': serializer.toJson<String?>(localPath),
      'isDownloaded': serializer.toJson<bool>(isDownloaded),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  MediaFilesTable copyWith(
          {int? id,
          String? userId,
          String? title,
          String? type,
          String? url,
          Value<String?> localPath = const Value.absent(),
          bool? isDownloaded,
          String? createdAt,
          String? updatedAt}) =>
      MediaFilesTable(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        type: type ?? this.type,
        url: url ?? this.url,
        localPath: localPath.present ? localPath.value : this.localPath,
        isDownloaded: isDownloaded ?? this.isDownloaded,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MediaFilesTable copyWithCompanion(MediaFilesCompanion data) {
    return MediaFilesTable(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      url: data.url.present ? data.url.value : this.url,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      isDownloaded: data.isDownloaded.present
          ? data.isDownloaded.value
          : this.isDownloaded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaFilesTable(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('url: $url, ')
          ..write('localPath: $localPath, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, type, url, localPath,
      isDownloaded, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaFilesTable &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.type == this.type &&
          other.url == this.url &&
          other.localPath == this.localPath &&
          other.isDownloaded == this.isDownloaded &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MediaFilesCompanion extends UpdateCompanion<MediaFilesTable> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> type;
  final Value<String> url;
  final Value<String?> localPath;
  final Value<bool> isDownloaded;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const MediaFilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.url = const Value.absent(),
    this.localPath = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MediaFilesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String title,
    required String type,
    required String url,
    this.localPath = const Value.absent(),
    this.isDownloaded = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  })  : userId = Value(userId),
        title = Value(title),
        type = Value(type),
        url = Value(url),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MediaFilesTable> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? type,
    Expression<String>? url,
    Expression<String>? localPath,
    Expression<bool>? isDownloaded,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (url != null) 'url': url,
      if (localPath != null) 'local_path': localPath,
      if (isDownloaded != null) 'is_downloaded': isDownloaded,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MediaFilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? title,
      Value<String>? type,
      Value<String>? url,
      Value<String?>? localPath,
      Value<bool>? isDownloaded,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return MediaFilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      type: type ?? this.type,
      url: url ?? this.url,
      localPath: localPath ?? this.localPath,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (isDownloaded.present) {
      map['is_downloaded'] = Variable<bool>(isDownloaded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaFilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('url: $url, ')
          ..write('localPath: $localPath, ')
          ..write('isDownloaded: $isDownloaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $ServicesTable services = $ServicesTable(this);
  late final $MediaFilesTable mediaFiles = $MediaFilesTable(this);
  late final DocumentsDao documentsDao = DocumentsDao(this as AppDatabase);
  late final EmployeesDao employeesDao = EmployeesDao(this as AppDatabase);
  late final ServicesDao servicesDao = ServicesDao(this as AppDatabase);
  late final MediaFilesDao mediaFilesDao = MediaFilesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [documents, employees, services, mediaFiles];
}

typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  required String userId,
  required String title,
  required String description,
  required String type,
  Value<String?> imageUrl,
  Value<String?> fileUrl,
  Value<bool> isDownloaded,
  required String status,
  required String createdAt,
  required String updatedAt,
  required String isUpdated,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> title,
  Value<String> description,
  Value<String> type,
  Value<String?> imageUrl,
  Value<String?> fileUrl,
  Value<bool> isDownloaded,
  Value<String> status,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> isUpdated,
});

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isUpdated => $composableBuilder(
      column: $table.isUpdated, builder: (column) => ColumnFilters(column));
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isUpdated => $composableBuilder(
      column: $table.isUpdated, builder: (column) => ColumnOrderings(column));
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get isUpdated =>
      $composableBuilder(column: $table.isUpdated, builder: (column) => column);
}

class $$DocumentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocumentsTable,
    DocumentsTable,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (
      DocumentsTable,
      BaseReferences<_$AppDatabase, $DocumentsTable, DocumentsTable>
    ),
    DocumentsTable,
    PrefetchHooks Function()> {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<bool> isDownloaded = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String> isUpdated = const Value.absent(),
          }) =>
              DocumentsCompanion(
            id: id,
            userId: userId,
            title: title,
            description: description,
            type: type,
            imageUrl: imageUrl,
            fileUrl: fileUrl,
            isDownloaded: isDownloaded,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isUpdated: isUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String title,
            required String description,
            required String type,
            Value<String?> imageUrl = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<bool> isDownloaded = const Value.absent(),
            required String status,
            required String createdAt,
            required String updatedAt,
            required String isUpdated,
          }) =>
              DocumentsCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            description: description,
            type: type,
            imageUrl: imageUrl,
            fileUrl: fileUrl,
            isDownloaded: isDownloaded,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isUpdated: isUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DocumentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DocumentsTable,
    DocumentsTable,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (
      DocumentsTable,
      BaseReferences<_$AppDatabase, $DocumentsTable, DocumentsTable>
    ),
    DocumentsTable,
    PrefetchHooks Function()>;
typedef $$EmployeesTableCreateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  required String userId,
  required String designationId,
  required String categoryId,
  Value<String?> departmentId,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> roomNumber,
  Value<String?> image,
  required String order,
  required String status,
  required String createdAt,
  required String updatedAt,
  required String isUpdated,
  Value<String?> imageUrl,
});
typedef $$EmployeesTableUpdateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> designationId,
  Value<String> categoryId,
  Value<String?> departmentId,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> roomNumber,
  Value<String?> image,
  Value<String> order,
  Value<String> status,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> isUpdated,
  Value<String?> imageUrl,
});

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get designationId => $composableBuilder(
      column: $table.designationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get departmentId => $composableBuilder(
      column: $table.departmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get roomNumber => $composableBuilder(
      column: $table.roomNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isUpdated => $composableBuilder(
      column: $table.isUpdated, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get designationId => $composableBuilder(
      column: $table.designationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get departmentId => $composableBuilder(
      column: $table.departmentId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get roomNumber => $composableBuilder(
      column: $table.roomNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get image => $composableBuilder(
      column: $table.image, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isUpdated => $composableBuilder(
      column: $table.isUpdated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get designationId => $composableBuilder(
      column: $table.designationId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get departmentId => $composableBuilder(
      column: $table.departmentId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get roomNumber => $composableBuilder(
      column: $table.roomNumber, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get isUpdated =>
      $composableBuilder(column: $table.isUpdated, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$EmployeesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmployeesTable,
    EmployeesTable,
    $$EmployeesTableFilterComposer,
    $$EmployeesTableOrderingComposer,
    $$EmployeesTableAnnotationComposer,
    $$EmployeesTableCreateCompanionBuilder,
    $$EmployeesTableUpdateCompanionBuilder,
    (
      EmployeesTable,
      BaseReferences<_$AppDatabase, $EmployeesTable, EmployeesTable>
    ),
    EmployeesTable,
    PrefetchHooks Function()> {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> designationId = const Value.absent(),
            Value<String> categoryId = const Value.absent(),
            Value<String?> departmentId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> roomNumber = const Value.absent(),
            Value<String?> image = const Value.absent(),
            Value<String> order = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String> isUpdated = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
          }) =>
              EmployeesCompanion(
            id: id,
            userId: userId,
            designationId: designationId,
            categoryId: categoryId,
            departmentId: departmentId,
            name: name,
            phone: phone,
            email: email,
            roomNumber: roomNumber,
            image: image,
            order: order,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isUpdated: isUpdated,
            imageUrl: imageUrl,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String designationId,
            required String categoryId,
            Value<String?> departmentId = const Value.absent(),
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> roomNumber = const Value.absent(),
            Value<String?> image = const Value.absent(),
            required String order,
            required String status,
            required String createdAt,
            required String updatedAt,
            required String isUpdated,
            Value<String?> imageUrl = const Value.absent(),
          }) =>
              EmployeesCompanion.insert(
            id: id,
            userId: userId,
            designationId: designationId,
            categoryId: categoryId,
            departmentId: departmentId,
            name: name,
            phone: phone,
            email: email,
            roomNumber: roomNumber,
            image: image,
            order: order,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isUpdated: isUpdated,
            imageUrl: imageUrl,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EmployeesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EmployeesTable,
    EmployeesTable,
    $$EmployeesTableFilterComposer,
    $$EmployeesTableOrderingComposer,
    $$EmployeesTableAnnotationComposer,
    $$EmployeesTableCreateCompanionBuilder,
    $$EmployeesTableUpdateCompanionBuilder,
    (
      EmployeesTable,
      BaseReferences<_$AppDatabase, $EmployeesTable, EmployeesTable>
    ),
    EmployeesTable,
    PrefetchHooks Function()>;
typedef $$ServicesTableCreateCompanionBuilder = ServicesCompanion Function({
  Value<int> id,
  required String userId,
  Value<String?> departmentId,
  required String title,
  required String description,
  Value<String?> proposalSample,
  Value<String?> video,
  Value<String?> extraDocument,
  required String status,
  required String order,
  required String createdAt,
  required String updatedAt,
  required String isUpdated,
  Value<String?> videoUrl,
  Value<String?> fileUrl,
  Value<String?> extraFileUrl,
});
typedef $$ServicesTableUpdateCompanionBuilder = ServicesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String?> departmentId,
  Value<String> title,
  Value<String> description,
  Value<String?> proposalSample,
  Value<String?> video,
  Value<String?> extraDocument,
  Value<String> status,
  Value<String> order,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> isUpdated,
  Value<String?> videoUrl,
  Value<String?> fileUrl,
  Value<String?> extraFileUrl,
});

class $$ServicesTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get departmentId => $composableBuilder(
      column: $table.departmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get proposalSample => $composableBuilder(
      column: $table.proposalSample,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get video => $composableBuilder(
      column: $table.video, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extraDocument => $composableBuilder(
      column: $table.extraDocument, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get isUpdated => $composableBuilder(
      column: $table.isUpdated, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get videoUrl => $composableBuilder(
      column: $table.videoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extraFileUrl => $composableBuilder(
      column: $table.extraFileUrl, builder: (column) => ColumnFilters(column));
}

class $$ServicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get departmentId => $composableBuilder(
      column: $table.departmentId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get proposalSample => $composableBuilder(
      column: $table.proposalSample,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get video => $composableBuilder(
      column: $table.video, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extraDocument => $composableBuilder(
      column: $table.extraDocument,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get isUpdated => $composableBuilder(
      column: $table.isUpdated, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get videoUrl => $composableBuilder(
      column: $table.videoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extraFileUrl => $composableBuilder(
      column: $table.extraFileUrl,
      builder: (column) => ColumnOrderings(column));
}

class $$ServicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get departmentId => $composableBuilder(
      column: $table.departmentId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get proposalSample => $composableBuilder(
      column: $table.proposalSample, builder: (column) => column);

  GeneratedColumn<String> get video =>
      $composableBuilder(column: $table.video, builder: (column) => column);

  GeneratedColumn<String> get extraDocument => $composableBuilder(
      column: $table.extraDocument, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get isUpdated =>
      $composableBuilder(column: $table.isUpdated, builder: (column) => column);

  GeneratedColumn<String> get videoUrl =>
      $composableBuilder(column: $table.videoUrl, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<String> get extraFileUrl => $composableBuilder(
      column: $table.extraFileUrl, builder: (column) => column);
}

class $$ServicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServicesTable,
    ServicesTable,
    $$ServicesTableFilterComposer,
    $$ServicesTableOrderingComposer,
    $$ServicesTableAnnotationComposer,
    $$ServicesTableCreateCompanionBuilder,
    $$ServicesTableUpdateCompanionBuilder,
    (
      ServicesTable,
      BaseReferences<_$AppDatabase, $ServicesTable, ServicesTable>
    ),
    ServicesTable,
    PrefetchHooks Function()> {
  $$ServicesTableTableManager(_$AppDatabase db, $ServicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> departmentId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> proposalSample = const Value.absent(),
            Value<String?> video = const Value.absent(),
            Value<String?> extraDocument = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> order = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String> isUpdated = const Value.absent(),
            Value<String?> videoUrl = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<String?> extraFileUrl = const Value.absent(),
          }) =>
              ServicesCompanion(
            id: id,
            userId: userId,
            departmentId: departmentId,
            title: title,
            description: description,
            proposalSample: proposalSample,
            video: video,
            extraDocument: extraDocument,
            status: status,
            order: order,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isUpdated: isUpdated,
            videoUrl: videoUrl,
            fileUrl: fileUrl,
            extraFileUrl: extraFileUrl,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            Value<String?> departmentId = const Value.absent(),
            required String title,
            required String description,
            Value<String?> proposalSample = const Value.absent(),
            Value<String?> video = const Value.absent(),
            Value<String?> extraDocument = const Value.absent(),
            required String status,
            required String order,
            required String createdAt,
            required String updatedAt,
            required String isUpdated,
            Value<String?> videoUrl = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<String?> extraFileUrl = const Value.absent(),
          }) =>
              ServicesCompanion.insert(
            id: id,
            userId: userId,
            departmentId: departmentId,
            title: title,
            description: description,
            proposalSample: proposalSample,
            video: video,
            extraDocument: extraDocument,
            status: status,
            order: order,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isUpdated: isUpdated,
            videoUrl: videoUrl,
            fileUrl: fileUrl,
            extraFileUrl: extraFileUrl,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ServicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServicesTable,
    ServicesTable,
    $$ServicesTableFilterComposer,
    $$ServicesTableOrderingComposer,
    $$ServicesTableAnnotationComposer,
    $$ServicesTableCreateCompanionBuilder,
    $$ServicesTableUpdateCompanionBuilder,
    (
      ServicesTable,
      BaseReferences<_$AppDatabase, $ServicesTable, ServicesTable>
    ),
    ServicesTable,
    PrefetchHooks Function()>;
typedef $$MediaFilesTableCreateCompanionBuilder = MediaFilesCompanion Function({
  Value<int> id,
  required String userId,
  required String title,
  required String type,
  required String url,
  Value<String?> localPath,
  Value<bool> isDownloaded,
  required String createdAt,
  required String updatedAt,
});
typedef $$MediaFilesTableUpdateCompanionBuilder = MediaFilesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> title,
  Value<String> type,
  Value<String> url,
  Value<String?> localPath,
  Value<bool> isDownloaded,
  Value<String> createdAt,
  Value<String> updatedAt,
});

class $$MediaFilesTableFilterComposer
    extends Composer<_$AppDatabase, $MediaFilesTable> {
  $$MediaFilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$MediaFilesTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaFilesTable> {
  $$MediaFilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MediaFilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaFilesTable> {
  $$MediaFilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<bool> get isDownloaded => $composableBuilder(
      column: $table.isDownloaded, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MediaFilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediaFilesTable,
    MediaFilesTable,
    $$MediaFilesTableFilterComposer,
    $$MediaFilesTableOrderingComposer,
    $$MediaFilesTableAnnotationComposer,
    $$MediaFilesTableCreateCompanionBuilder,
    $$MediaFilesTableUpdateCompanionBuilder,
    (
      MediaFilesTable,
      BaseReferences<_$AppDatabase, $MediaFilesTable, MediaFilesTable>
    ),
    MediaFilesTable,
    PrefetchHooks Function()> {
  $$MediaFilesTableTableManager(_$AppDatabase db, $MediaFilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaFilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaFilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaFilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<bool> isDownloaded = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              MediaFilesCompanion(
            id: id,
            userId: userId,
            title: title,
            type: type,
            url: url,
            localPath: localPath,
            isDownloaded: isDownloaded,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String title,
            required String type,
            required String url,
            Value<String?> localPath = const Value.absent(),
            Value<bool> isDownloaded = const Value.absent(),
            required String createdAt,
            required String updatedAt,
          }) =>
              MediaFilesCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            type: type,
            url: url,
            localPath: localPath,
            isDownloaded: isDownloaded,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MediaFilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MediaFilesTable,
    MediaFilesTable,
    $$MediaFilesTableFilterComposer,
    $$MediaFilesTableOrderingComposer,
    $$MediaFilesTableAnnotationComposer,
    $$MediaFilesTableCreateCompanionBuilder,
    $$MediaFilesTableUpdateCompanionBuilder,
    (
      MediaFilesTable,
      BaseReferences<_$AppDatabase, $MediaFilesTable, MediaFilesTable>
    ),
    MediaFilesTable,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db, _db.services);
  $$MediaFilesTableTableManager get mediaFiles =>
      $$MediaFilesTableTableManager(_db, _db.mediaFiles);
}
