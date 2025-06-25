import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import './daos/user_dao.dart';
import './daos/prediction_dao.dart';

part 'database.g.dart'; // chạy build_runner để sinh file này //chạy flutter pub run build_runner build

// ==========================
// Bảng Users
// ==========================
class Users extends Table {
  IntColumn get userId => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text().customConstraint('UNIQUE')();
  TextColumn get password => text()(); // Hash nếu muốn
}

// ==========================
// Bảng PredictionHistories
// ==========================
class PredictionHistories extends Table {
  IntColumn get predictionId => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #userId)();
  TextColumn get gender => text()();
  IntColumn get age => integer()();
  IntColumn get hypertension => integer()();
  IntColumn get heartDisease => integer()();
  TextColumn get everMarried => text()();
  TextColumn get workType => text()();
  TextColumn get residenceType => text()();
  RealColumn get avgGlucoseLevel => real()();
  RealColumn get bmi => real()();
  TextColumn get smokingStatus => text()();
  BoolColumn get stroke => boolean()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// ==========================
// Bảng Hospitals
// ==========================
class Hospitals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get phone => text()();
  TextColumn get type => text()();
}

// ==========================
// Khởi tạo database
// ==========================
@DriftDatabase(
  tables: [Users, PredictionHistories, Hospitals],
  daos: [UserDao, PredictionDao]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'stroke_prediction_app.db'));
    return NativeDatabase(file);
  });
}
