import 'package:coworker/controllers/fragments/browser_controller.dart';
import 'package:coworker/controllers/user_controller.dart';
import 'package:coworker/widgets/section_title.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowserFragment extends StatefulWidget {
  const BrowserFragment({super.key});

  @override
  State<BrowserFragment> createState() => _BrowserFragmentState();
}

class _BrowserFragmentState extends State<BrowserFragment> {
  final browseController = Get.put(BrowserController());
  final userController = Get.put(UserController());

  @override
  void dispose() {
    browseController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 414,
          child: Stack(
            children: [
              Image.asset(
                'assets/bg_discover_page.png',
                width: MediaQuery.of(context).size.width,
              ),
              Transform.translate(
                offset: const Offset(0, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    header(),
                    DView.height(30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Anda butuh pekerja\napa untuk hari ini ?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DView.height(30),
                    categories(),
                    DView.height(10),
                    searchBox(),
                  ],
                ),
              )
            ],
          ),
        ),
        DView.height(50),
        latestStats(),
        DView.height(30),
      ],
    );
  }

  Widget latestStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Latest Stats'),
          DView.height(),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/ic_hired_stats.png',
                      width: 46,
                      height: 46,
                    ),
                    DView.width(12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12,882',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Hired',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/ic_money_spend.png',
                      width: 46,
                      height: 46,
                    ),
                    DView.width(12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '89,390',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Expense',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
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
            color: const Color(0xffe5e7ec).withValues(alpha: 0.5),
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
                hintText: 'Search your dream worker',
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

  Widget categories() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: browseController.categories.length,
        itemBuilder: (context, index) {
          Map category = browseController.categories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 20 : 8,
                right: index == browseController.categories.length - 1 ? 20 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    category['icon'],
                    width: 46,
                    height: 46,
                  ),
                  DView.height(8),
                  Text(
                    category['label'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffBFA8FF),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Obx(() {
              return Text(
                userController.data.name?[0] ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              );
            }),
          ),
          DView.width(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Text(
                    'Hi ${userController.data.name ?? ''}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  );
                }),
                const Text(
                  'Recruiter',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: const Badge(
              smallSize: 10,
              backgroundColor: Colors.red,
              child: ImageIcon(
                AssetImage('assets/ic_notification.png'),
              ),
            ),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              foregroundColor: WidgetStatePropertyAll(Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
