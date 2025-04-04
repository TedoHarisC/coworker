import 'package:appwrite/appwrite.dart';
import 'package:coworker/config/app_log.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:coworker/models/booking_model.dart';
import 'package:dartz/dartz.dart';

class BookingDatasource {
  static Future<Either<String, BookingModel>> checkHireBy(
      String workerId) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionBooking,
        queries: [
          Query.equal('worker_id', workerId),
          Query.equal('status', 'In Progress'),
          Query.orderDesc('\$updatedAt'),
        ],
      );

      if (response.total < 1) {
        //available
        AppLog.error(
          body: 'Not Found',
          title: 'Booking - CheckhireBy',
        );
        return const Left('Tidak Ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Booking - CheckhireBy',
      );

      BookingModel booking =
          BookingModel.fromJson(response.documents.first.data);
      return Right(booking);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'Booking - CheckhireBy',
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
