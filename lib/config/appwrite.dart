import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '66adb088000663a86244';
  static const endPoint = 'https://cloud.appwrite.io/v1';

  init() {
    Client client = Client();
    client
        .setEndpoint(endPoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    // For self signed certificates, only use for development
  }
}
