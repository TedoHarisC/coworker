import 'package:appwrite/appwrite.dart';
import 'package:coworker/config/app_log.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:dartz/dartz.dart';

class UserDatasource {
  static Future<Either<String, Map>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final resultAuth = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );

      final response = await Appwrite.databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionUsers,
        documentId: resultAuth.$id,
        data: {
          'name': name,
          'email': email,
        },
      );

      Map data = response.data;
      AppLog.success(
        body: data.toString(),
        title: 'User - SignUp',
      );

      return Right(data);
    } catch (e) {
      AppLog.error(
        body: e.toString(),
        title: 'User - SignUp',
      );

      String defaultMessage = 'Terjadi suatu masalah';
      String message = defaultMessage;

      if (e is AppwriteException) {
        if (e.code == 409) {
          message = 'Email sudah terdaftar';
        } else {
          message = e.message ?? defaultMessage;
        }
      }
      return Left(message);
    }
  }
}