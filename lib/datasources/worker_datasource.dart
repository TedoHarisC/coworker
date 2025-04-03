import 'package:appwrite/appwrite.dart';
import 'package:coworker/config/app_log.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:dartz/dartz.dart';

class WorkerDatasource {
  static Future<Either<String, List<WorkerModel>>> fetchAvailable(
      String category) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.equal('category', category),
          Query.equal('status', 'Available'),
        ],
      );

      if (response.total < 1) {
        AppLog.error(
          body: 'Not Found',
          title: 'Worker - fetch Available',
        );

        return const Left("Tidak Ditemukan");
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: "Worker - fetchAvailable",
      );

      List<WorkerModel> workers = response.documents.map((e) {
        return WorkerModel.fromJson(e.data);
      }).toList();

      return Right(workers);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Worker - fetchAvailable',
      );

      String defaultMessage = 'Terjadi suatu masalah';
      String message = defaultMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaultMessage;
      }
      return Left(message);
    }
  }
}
