import 'package:dynamic_assets/dynamic_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_app/password_viewer/password_viewer.dart';
import 'package:lockie_app/passwords/passwords.dart';
import 'package:lockie_locker/lockie_locker.dart';

import 'package:flutter/services.dart';
import 'package:lockie_theme/lockie_theme.dart';

class PasswordWidget extends StatelessWidget {
  
  final Password password;
  final bool selected;
  final bool errored;

  const PasswordWidget(this.password, { 
    Key? key,
    this.selected = false,
    this.errored = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = DynamicAssets.containedFile(password.service);
    return InkWell(
      onTap: () async {
        if(!selected) {
          final value = await context.read<PasswordsCubit>().decrypt(password);
          if(value.isNotEmpty) {
            await Clipboard.setData(ClipboardData(text: value));
            context.read<PasswordsCubit>().copied();
          }
          context.read<PasswordsCubit>().select(password);
        }
        else {
          context.read<PasswordsCubit>().deselect();
          Navigator.of(context).push(LockiePageRoute(builder: (_) => PasswordViewerPage(password)));
        }
      },
      child: Material(
        color: !selected ? Colors.transparent : (!errored ? Colors.white10 : Color.fromARGB(255, 63, 0, 0)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              image != null
              ?ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('assets/logo/$image.png',
                  height: 30,
                ),
              )
              :Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[800],
                ),
                child: Icon(Icons.public)
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(password.service,
                  style: Theme.of(context).textTheme.headline6!
                  .copyWith(
                    fontSize: 16,
                    shadows: [Shadow(
                      color: Colors.grey[300]!,
                      offset: Offset(0, -8)
                    )],
                    decorationColor: Colors.grey[300]
                  )
                ),
              ),
              Spacer(),
              !selected 
              ? Icon(Icons.copy, color: Colors.grey[600])
              : (!errored 
                ? Icon(Icons.visibility_rounded, color: Colors.grey[600])
                : Icon(Icons.error_outline_rounded, color: Colors.redAccent)
              )
            ]
          ),
        ),
      ),
    );
  }
}