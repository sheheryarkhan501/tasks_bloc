import 'package:flutter/material.dart';
import 'package:tasks_demo/utils/app_enums.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton(
      {super.key,
      this.status = ButtonStatus.idle,
      // this.autoReset = true,
      required this.text,
      this.loadingText,
      this.onPressed});
  ButtonStatus status;
  final String text;
  final String? loadingText;
  final Function()? onPressed;
  // final bool autoReset;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    // autoReset();
    return Row(
      children: [
        Expanded(
          child: Center(
            child: InkWell(
              onTap: widget.onPressed,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: buttonWidth,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: child),
            ),
          ),
        ),
      ],
    );
  }

  Widget get child {
    switch (widget.status) {
      case ButtonStatus.idle:
        return Text(widget.text, style: const TextStyle(color: Colors.white));
      case ButtonStatus.loading:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.loadingText != null) ...[
              Text(widget.loadingText ?? '',
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 8)
            ],
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        );
      case ButtonStatus.success:
        return const Icon(Icons.check, color: Colors.green);
      case ButtonStatus.error:
        return const Icon(Icons.error, color: Colors.red);
      default:
        return Text(widget.text, style: const TextStyle(color: Colors.white));
    }
  }

  double get buttonWidth {
    switch (widget.status) {
      case ButtonStatus.idle:
        return MediaQuery.of(context).size.width - 16;
      case ButtonStatus.loading:
        return widget.loadingText != null
            ? MediaQuery.of(context).size.width - 16
            : 100;
      case ButtonStatus.success:
        return 100;
      case ButtonStatus.error:
        return 100;
      default:
        return 100;
    }
  }

  // void autoReset() {
  //   if (widget.status == ButtonStatus.error && widget.autoReset && mounted) {
  //     Future.delayed(const Duration(seconds: 2), () {
  //       setState(() {
  //         widget.status = ButtonStatus.idle;
  //       });
  //     });
  //   }
  // }
}
