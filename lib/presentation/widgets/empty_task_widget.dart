import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text("No Task Available",
                    style: Theme.of(context).textTheme.titleLarge)),
          ],
        ),
        Lottie.asset('assets/animations/empty.json', height: 200, width: 200),
      ],
    );
  }
}
