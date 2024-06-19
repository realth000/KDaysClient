import 'package:drift/drift.dart';
import 'package:kdays_client/features/storage/database/connection/native.dart';
import 'package:kdays_client/features/storage/database/schema/schema.dart';

part 'database.g.dart';

/// 数据库定义
@DriftDatabase(
  tables: [
    User,
  ],
)
final class AppDatabase extends _$AppDatabase {
  /// Constructor.
  AppDatabase() : super(connect());

  @override
  int get schemaVersion => 1;
}
