import 'package:coworker/models/booking_model.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  static BookingController get to => Get.find();

  void clear() {
    Get.delete<BookingController>(force: true);
  }

  // Untuk melakukan setting atau pemberian nilai default dari hourduration yang ada pilihan nya
  final hourDuration = [5, 10, 15, 25, 40, 100];
  final _duration = 10.obs;
  int get duration => _duration.value;
  void setDuration(int n, double hourRate) {
    _duration.value = n;
  }

  // Untuk melakukan set dan get dari booking detail
  final _bookingDetail = BookingModel(
    userId: '',
    workerId: '',
    date: DateTime.now(),
    hiringDuration: 0,
    subtotal: 0,
    insurance: 0,
    tax: 0,
    platformFee: 0,
    grandTotal: 0,
    payWith: '',
    status: 'In Progress',
    $id: '',
    $createdAt: '',
    $updatedAt: '',
  ).obs;

  BookingModel get bookingDetail => _bookingDetail.value;

  void initBookingDetail(String userId, WorkerModel worker) {
    _bookingDetail.value = BookingModel(
      userId: userId,
      workerId: worker.$id,
      date: DateTime.now(),
      hiringDuration: duration,
      subtotal: duration * worker.hourRate,
      insurance: 599,
      tax: 934,
      platformFee: 344,
      grandTotal: (duration * worker.hourRate) + 599 + 934 + 344,
      payWith: 'Wallet',
      status: 'In Progress',
      $id: '',
      $createdAt: '',
      $updatedAt: '',
      worker: worker,
    );
  }
}
