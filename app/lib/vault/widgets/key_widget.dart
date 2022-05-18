import 'package:flutter/material.dart';
import 'package:lockie_app/key_viewer/key_viewer.dart';
import 'package:lockie_theme/lockie_theme.dart';

class KeyWidget extends StatelessWidget {

  final String id;
  final String value;

  const KeyWidget(this.id, this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(LockiePageRoute(builder: (_) => KeyViewerPage(id: id, value: value))),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.grey[700]!
            )
          )
        ),
        child: Row(
          children: [
            Icon(Icons.key_rounded),
            SizedBox(width: 20),
            Text(id,
              style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18)
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[600])
          ]
        ),
      ),
    );
  }
}