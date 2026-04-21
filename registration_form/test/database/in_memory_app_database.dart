import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:registration_form/core/data/database/app_database.dart';
import 'package:registration_form/core/data/database/database_query_executor.dart';

class InMemoryAppDatabase extends AppDatabase {
  InMemoryAppDatabase() : super(_InMemoryQueryExecutor());
}

class _InMemoryQueryExecutor extends LazyDatabase implements DatabaseQueryExecutor {
  _InMemoryQueryExecutor() : super(NativeDatabase.memory);
}
