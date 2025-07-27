import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '66adb088000663a86244';
  static const endPoint = 'https://cloud.appwrite.io/v1';

  static const databaseId = '66add20e0019646f00a1';
  static const collectionUsers = '66add24d00001cf8797f';
  static const collectionWorkers = '66add28b0035927fad51';
  static const collectionBooking = '66add2b0002746464651';

  static const bucketWorker = '66adddc7000e2007c3d2';

  static Client client = Client();
  static late Account account;
  static late Databases databases;

  static void init() {
    client
        .setEndpoint(endPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    // For self signed certificates, only use for development
    account = Account(client);
    databases = Databases(client);
  }

  static String imageURL(String fileId) {
    return '$endPoint/storage/buckets/$bucketWorker/files/$fileId/view?project=$projectId';
  }
}
