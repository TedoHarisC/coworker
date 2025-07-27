import 'package:coworker/datasources/booking_datasource.dart';
import 'package:get/get.dart';

class WorkerProfileController extends GetxController {
  void clear() {
    Get.delete<WorkerProfileController>(force: true);
  }

  // Buat Get Set untuk mendapatkan recruiter id dari situ kita bisa asumsi
  // apakah recruiter id itu kita atau bukan
  final _recruiterId = ''.obs;
  String get recruiterId => _recruiterId.value;
  set recruiterId(String n) => _recruiterId.value = n;

  void checkHiredBy(String workerId) {
    BookingDatasource.checkHireBy(workerId).then((value) {
      value.fold(
        (message) => recruiterId = 'Available',
        (booking) {
          recruiterId = booking.userId;
        },
      );
    });
  }
}
