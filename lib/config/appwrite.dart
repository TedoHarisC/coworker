import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '66adb088000663a86244';
  static const endPoint = 'https://cloud.appwrite.io/v1';

  static Client client = Client();
  static late Account account;

  static init() {
    Account account = Account(client);
    client
        .setEndpoint(endPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    // For self signed certificates, only use for development
  }
}
