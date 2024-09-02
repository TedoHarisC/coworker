import 'package:coworker/widgets/input_auth.dart';
import 'package:coworker/widgets/input_auth_password.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/signin_background.png',
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Image.asset(
                    'assets/applogo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Transform.translate(
                    offset: const Offset(0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'New Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        DView.height(8),
                        const Text("Let's grow your business today"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          DView.height(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                InputAuth(
                  editingController: TextEditingController(),
                  hint: 'Write your name',
                  title: 'Complete Name',
                ),
                DView.height(),
                InputAuth(
                  editingController: TextEditingController(),
                  hint: 'Write your email',
                  title: 'Email Address',
                ),
                DView.height(),
                InputAuthPassword(
                  editingController: TextEditingController(),
                  hint: 'Write your password',
                  title: 'Password',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
