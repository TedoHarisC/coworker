import 'package:flutter/material.dart';

class HeaderWorkerLeft extends StatelessWidget {
  const HeaderWorkerLeft({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconLeft,
    required this.functionLeft,
  });

  final String title;
  final String subTitle;
  final String iconLeft;
  final VoidCallback functionLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton.filled(
            onPressed: functionLeft,
            icon: ImageIcon(AssetImage(iconLeft)),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: WidgetStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
