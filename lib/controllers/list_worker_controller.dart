import 'package:coworker/datasources/worker_datasource.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:get/get.dart';

class ListWorkerController extends GetxController {
  void clear() {
    Get.delete<ListWorkerController>(force: true);
  }

  List topRated = [
    {
      'image': 'assets/shian.png',
      'name': 'Shian',
      'rate': 4.8,
    },
    {
      'image': 'assets/cindinan.png',
      'name': 'Cindian',
      'rate': 4.9,
    },
    {
      'image': 'assets/ajinomo.png',
      'name': 'Ajinomo',
      'rate': 4.8,
    },
    {
      'image': 'assets/sajima.png',
      'name': 'Sajima',
      'rate': 4.8,
    }
  ];

  final _availableWorkers = <WorkerModel>[].obs;
  List<WorkerModel> get availableWorkers => _availableWorkers;
  set availableWorkers(List<WorkerModel> n) => _availableWorkers.value = n;

  final _statusFetch = ''.obs;
  String get statusFetch => _statusFetch.value;
  set statusFetch(String n) => _statusFetch.value = n;

  void fetchAvailable(String category) {
    statusFetch = 'Loading';
    WorkerDatasource.fetchAvailable(category).then((value) {
      value.fold(
        (message) {
          statusFetch = message;
        },
        (workers) {
          statusFetch = 'Success';
          availableWorkers = workers;
        },
      );
    });
  }
}
