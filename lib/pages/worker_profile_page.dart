import 'package:coworker/config/app_color.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:coworker/controllers/user_controller.dart';
import 'package:coworker/controllers/worker_profile_controller.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:coworker/widgets/header_worker.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerProfilePage extends StatefulWidget {
  final WorkerModel worker;
  const WorkerProfilePage({super.key, required this.worker});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  late final WorkerProfileController workerProfileController;
  late final UserController userController;

  @override
  void initState() {
    super.initState();
    workerProfileController = Get.put(WorkerProfileController());
    userController = Get.put(UserController());
    workerProfileController.checkHiredBy(widget.worker.$id);
  }

  @override
  void dispose() {
    // More proper clean up controller
    Get.delete<WorkerProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          header(),
        ],
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        Container(
          height: 172,
          decoration: const BoxDecoration(
            color: AppColor.bgHeader,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(80),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DView.nothing(),
              HeaderWorker(
                title: 'Worker Profile',
                subTitle: 'Details are matters',
                iconLeft: 'assets/ic_back.png',
                functionLeft: () => Navigator.pop(context),
                iconRight: 'assets/ic_other.png',
                functionRight: () {},
              ),
              DView.height(24),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      Appwrite.imageURL(widget.worker.image),
                      width: 136,
                      height: 136,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Obx(() {
                    String recruiterId = workerProfileController.recruiterId;
                    if (recruiterId == '' || recruiterId == 'Available') {
                      return DView.nothing();
                    }
                    if (recruiterId == userController.data.$id) {
                      return const Text('Hired by You');
                    }
                    return const Text('Hired by Other');
                  }),
                ],
              ),
              DView.height(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.worker.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  DView.width(4),
                  Image.asset(
                    'assets/ic_verified.png',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              Obx(() {
                String recruiterId = workerProfileController.recruiterId;
                String txtAvailable =
                    recruiterId == 'Available' ? ' . Available' : '';
                return Text(
                  '${widget.worker.location} . ${widget.worker.experience}yrs$txtAvailable',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
