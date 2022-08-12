import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isActive;
  final double height;
  final String title;

  const SimpleButton({
    super.key,
    required this.isLoading,
    required this.isActive,
    required this.onPressed,
    this.height = 50,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: !isLoading && isActive ? () => onPressed() : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
