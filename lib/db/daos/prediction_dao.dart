import 'package:drift/drift.dart';
import '../database.dart';

part 'prediction_dao.g.dart';

@DriftAccessor(tables: [PredictionHistories])
class PredictionDao extends DatabaseAccessor<AppDatabase> with _$PredictionDaoMixin {
  PredictionDao(AppDatabase db) : super(db);

  //Thêm bản ghi mới
  Future<int> insertPrediction(PredictionHistoriesCompanion entry) {
    return into(predictionHistories).insert(entry);
  }

  //Lấy tất cả lịch sử dự đoán theo user
  Future<List<PredictionHistory>> getPredictionsByUser(int userId) {
    return (select(predictionHistories)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .get();
  }

  //Lấy chi tiết 1 dự đoán
  Future<PredictionHistory?> getPredictionById(int id) {
    return (select(predictionHistories)..where((tbl) => tbl.predictionId.equals(id))).getSingleOrNull();
  }

  //Xóa 1 lịch sử dự đoán
  Future<bool> deletePrediction(int id) {
    return (delete(predictionHistories)..where((tbl) => tbl.predictionId.equals(id))).go().then((rows) => rows > 0);
  }
}
