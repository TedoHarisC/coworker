import 'package:coworker/config/app_color.dart';
import 'package:coworker/config/app_format.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:coworker/config/enums.dart';
import 'package:coworker/controllers/user_controller.dart';
import 'package:coworker/controllers/worker_profile_controller.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:coworker/widgets/header_worker.dart';
import 'package:coworker/widgets/secondary_button.dart';
import 'package:coworker/widgets/section_title.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      bottomNavigationBar: Obx(() {
        String recruiterId = workerProfileController.recruiterId;
        if (recruiterId == '') {
          return DView.loadingCircle();
        }
        if (recruiterId == 'Available') {
          return hireNow();
        }
        if (recruiterId == userController.data.$id) {
          return hireByYou();
        }
        return hireByOther();
      }),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          header(),
          DView.height(90),
          about(),
          DView.height(30),
          const SectionTitle(text: 'My Strength', autoPadding: true),
          DView.height(8),
          strength(context),
        ],
      ),
    );
  }

  Widget hireNow() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormat.price(widget.worker.hourRate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('per hour'),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.booking.name,
                  arguments: widget.worker,
                );
              },
              child: const Text('Hire Now'),
            ),
          ),
        ],
      ),
    );
  }

  Widget hireByYou() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SecondaryButton(
              onPressed: () {},
              child: const Text('Message'),
            ),
          ),
          DView.width(),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text('Give Rating'),
            ),
          ),
        ],
      ),
    );
  }

  Widget hireByOther() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppFormat.price(widget.worker.hourRate),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('per hour'),
              ],
            ),
          ),
          SizedBox(
            width: 160,
            child: SecondaryButton(
              onPressed: () {},
              child: const Text('Not Available'),
            ),
          ),
        ],
      ),
    );
  }

  Column strength(BuildContext context) {
    return Column(
      children: widget.worker.strengths.map((e) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 20,
          ),
          child: Row(
            children: [
              Radio(
                visualDensity: const VisualDensity(
                  vertical: -3,
                  horizontal: -4,
                ),
                value: true,
                groupValue: true,
                onChanged: (value) {},
                activeColor: Theme.of(context).primaryColor,
              ),
              Text(
                e,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Column about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          text: 'About',
          autoPadding: true,
        ),
        DView.height(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.worker.about,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        DView.height(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              RatingBar.builder(
                initialRating: widget.worker.rating,
                minRating: 1,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.all(0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
                ignoreGestures: true,
              ),
              DView.width(8),
              Text(
                '(${AppFormat.number(widget.worker.ratingCount)})',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
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
                      return hiredByYouText();
                    }
                    return hiredByOtherText();
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

  Positioned hiredByYouText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, 6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffBFA8FF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: const Text(
              'HIRED BY YOU',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned hiredByOtherText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, 6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffFF7179),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            child: const Text(
              'HIRED BY OTHER',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
