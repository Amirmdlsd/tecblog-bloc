import 'package:flutter/material.dart';

class TryAgainButtonWidget extends StatelessWidget {
  const TryAgainButtonWidget({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'خطایی رخ داده است',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                onTap();
              },
              child: const Text(
                "تلاش مجدد",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}