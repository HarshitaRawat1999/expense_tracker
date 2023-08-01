import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

class ExpenseTable extends Table {
  // autoincrement sets this to the primary key
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 2, max: 50)();

  TextColumn get amount => text()();

  TextColumn get category => text()();
}


@DriftDatabase(tables: [ExpenseTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<ExpenseTableData>> getAllData() =>
      select(expenseTable).get();

  Future insertData(ExpenseTableCompanion record) =>
      into(expenseTable).insert(record);

  Future updateData(ExpenseTableData record) =>
      update(expenseTable).replace(record);

  Future deleteData(ExpenseTableData record) =>
      delete(expenseTable).delete(record);

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}
