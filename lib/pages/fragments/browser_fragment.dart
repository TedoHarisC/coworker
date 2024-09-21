import 'package:coworker/controllers/fragments/browser_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowserFragment extends StatefulWidget {
  const BrowserFragment({super.key});

  @override
  State<BrowserFragment> createState() => _BrowserFragmentState();
}

class _BrowserFragmentState extends State<BrowserFragment> {
  final browseController = Get.put(BrowserController());

  @override
  void dispose() {
    browseController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
