import 'package:coworker/config/app_color.dart';
import 'package:coworker/config/appwrite.dart';
import 'package:coworker/config/enums.dart';
import 'package:coworker/config/session.dart';
import 'package:coworker/models/worker_model.dart';
import 'package:coworker/pages/booking_page.dart';
import 'package:coworker/pages/dashboard_page.dart';
import 'package:coworker/pages/get_started_page.dart';
import 'package:coworker/pages/sign_in_page.dart';
import 'package:coworker/pages/sign_up_page.dart';
import 'package:coworker/pages/worker_profile_page.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/list_worker_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Appwrite.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coworkers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: AppColor.text,
          displayColor: AppColor.text,
        ),
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
        ),
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(
              Size.fromHeight(52),
            ),
            textStyle: WidgetStatePropertyAll(
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      initialRoute: AppRoute.dashboard.name,
      routes: {
        AppRoute.getStarted.name: (context) => const GetStartedPage(),
        AppRoute.signUp.name: (context) => const SignUpPage(),
        AppRoute.signIn.name: (context) => const SignInPage(),
        AppRoute.dashboard.name: (context) {
          return FutureBuilder(
              future: AppSession.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DView.loadingCircle();
                }
                if (snapshot.data == null) {
                  return const GetStartedPage();
                }
                return const DashboardPage();
              });
        },
        AppRoute.listWorker.name: (context) {
          String category =
              ModalRoute.of(context)!.settings.arguments as String;
          return ListWorkerPage(category: category);
        },
        AppRoute.workerProfile.name: (context) {
          WorkerModel worker =
              ModalRoute.of(context)!.settings.arguments as WorkerModel;
          return WorkerProfilePage(worker: worker);
        },
        AppRoute.booking.name: (context) {
          WorkerModel worker =
              ModalRoute.of(context)!.settings.arguments as WorkerModel;
          return BookingPage(worker: worker);
        }
      },
    );
  }
}
