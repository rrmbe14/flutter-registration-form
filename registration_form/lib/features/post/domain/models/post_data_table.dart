// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:registration_form/core/data/database/app_database.dart';
import 'package:registration_form/core/domain/models/data_table.dart';
import 'package:registration_form/features/post/domain/models/post_entity.dart';
import 'package:uuid/uuid.dart';

@DataClassName('PostDataObject')
class PostDataTable extends DataTable {
  @override
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  IntColumn get postId => integer()();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();
}

extension PostDataObjectX on PostDataObject {
  PostEntity toEntity() {
    return PostEntity(
      userId: userId,
      id: postId,
      title: title,
      body: body,
    );
  }
}
