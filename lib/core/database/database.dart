import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get email => text()();
  DateTimeColumn get birthday => dateTime().nullable()();
  TextColumn get country => text().nullable()();
}

class Settings extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get currency => text()();
  TextColumn get currencySymbol => text().nullable()();
  BoolColumn get security => boolean()();
  BoolColumn get hideBalance => boolean().nullable()();
}

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().references(Profiles, #id)();
  TextColumn get name => text().nullable()();
  IntColumn get amount => integer()();
  TextColumn get type => text()();
  TextColumn get color => text()();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().references(Profiles, #id)();
  IntColumn get accountId => integer().references(Accounts, #id)();
  IntColumn get budgetId => integer().nullable().references(Budgets, #id)();
  TextColumn get receiptPath => text().nullable()();
  IntColumn get amount => integer()();
  TextColumn get type => text()();
  TextColumn get note => text()();
  DateTimeColumn get date => dateTime()();
}

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().references(Profiles, #id)();
  TextColumn get name => text().nullable()();
  TextColumn get symbol => text()();
  IntColumn get budget => integer()();
  TextColumn get color => text()();
}

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get profileId => integer().references(Profiles, #id)();
  TextColumn get name => text().nullable()();
  TextColumn get symbol => text()();
  IntColumn get goal => integer()();
  TextColumn get color => text()();
  DateTimeColumn get dateLimit => dateTime()();
}

@DriftDatabase(
  tables: [Profiles, Settings, Accounts, Transactions, Budgets, Goals],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(budgets);
          await m.createTable(goals);
          await m.addColumn(transactions, transactions.budgetId);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
