import 'package:coworker/config/app_color.dart';
import 'package:coworker/config/app_format.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:coworker/widgets/header_worker.dart';
import 'package:coworker/widgets/section_title.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/list_worker_controller.dart';

class ListWorkerPage extends StatefulWidget {
  final String category;
  const ListWorkerPage({super.key, required this.category});

  @override
  State<ListWorkerPage> createState() => _ListWorkerPageState();
}

class _ListWorkerPageState extends State<ListWorkerPage> {
  final listWorkerController = Get.put(ListWorkerController());

  @override
  void initState() {
    // Showing list worker based on category from controller named fetchAvailable
    listWorkerController.fetchAvailable(widget.category);
    super.initState();
  }

  @override
  void dispose() {
    listWorkerController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          header(),
          DView.height(50),
          topRatedCategory(),
          DView.height(30),
          availableWorkerCategory(),
        ],
      ),
    );
  }

  Widget header() {
    return SizedBox(
      height: 172,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.bgHeader,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(80),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DView.nothing(),
                HeaderWorker(
                  title: widget.category,
                  subTitle: '13,492 workers',
                  iconLeft: 'assets/ic_back.png',
                  functionLeft: () => Navigator.pop(context),
                  iconRight: 'assets/ic_filter.png',
                  functionRight: () {},
                ),
                searchBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            //color: const Color(0xffe5e7ec).withValues(alpha: 0.5),
            color: const Color(0xffe5e7ec).withAlpha(5),
            blurRadius: 30,
            offset: const Offset(0, 6),
          )
        ],
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 20, right: 8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name',
                hintStyle: TextStyle(
                  color: Color(0xffA7A8B3),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage(
                'assets/ic_search.png',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget topRatedCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'Top Rated ${widget.category}',
          autoPadding: true,
        ),
        DView.height(),
        SizedBox(
          height: 120,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: listWorkerController.topRated.length,
            itemBuilder: (context, index) {
              Map worker = listWorkerController.topRated[index];
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffeaeaea),
                  ),
                ),
                margin: EdgeInsets.only(
                  left: index == 0 ? 20 : 8,
                  right: index == listWorkerController.topRated.length - 1
                      ? 20
                      : 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      worker['image'],
                      width: 46,
                      height: 46,
                    ),
                    DView.height(6),
                    Text(
                      worker['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    DView.height(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/ic_star_small.png',
                          height: 16,
                          width: 16,
                        ),
                        DView.width(2),
                        Text(
                          '${worker['rate']}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget availableWorkerCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          text: 'Available Workers',
          autoPadding: true,
        ),
        DView.height(),
        Obx(() {
          String statusFetch = listWorkerController.statusFetch;
          if (statusFetch == '') return DView.nothing();
          if (statusFetch == 'Loading') return DView.loadingCircle();
          if (statusFetch != 'Success') return DView.error(data: statusFetch);
          List<WorkerModel> list = listWorkerController.availableWorkers;
          return ListView.builder(
            itemCount: list.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              WorkerModel item = list[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffeaeaea)),
                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Image.network(
                        Appwrite.imageURL(item.image),
                        width: 60,
                        height: 60,
                      ),
                      DView.width(12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            DView.height(2),
                            Text(
                              '${item.location} . ${item.experience}yrs',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppFormat.price(item.hourRate),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const Text('/hr'),
                            ],
                          ),
                          DView.height(2),
                          Row(
                            children: [
                              Image.asset(
                                'assets/ic_star_small.png',
                                width: 16,
                                height: 16,
                              ),
                              DView.width(2),
                              Text(
                                item.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
