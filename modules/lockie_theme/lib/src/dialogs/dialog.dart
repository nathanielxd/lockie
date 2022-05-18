import 'package:flutter/material.dart';

class LockieDialog extends StatelessWidget {

  final Widget? content;
  final List<Widget>? options;

  const LockieDialog({ 
    Key? key,
    this.content,
    this.options
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[800]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(content != null) Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: content!,
            ),
            if(options != null) ...options!
          ],
        )
      )
    );
  }
}