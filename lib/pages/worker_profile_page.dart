import 'package:coworker/controllers/worker_profile_controller.dart';
import 'package:coworker/models/worker_model.dart';
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

  @override
  void initState() {
    super.initState();
    workerProfileController = Get.put(WorkerProfileController());
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
      appBar: DView.appBarCenter(widget.worker.name),
    );
  }
}
