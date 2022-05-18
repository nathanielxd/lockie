import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lockie_app/add_key/add_key.dart';
import 'package:lockie_app/vault/vault.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockie_theme/lockie_theme.dart';

class VaultView extends StatelessWidget {

  const VaultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VaultCubit, VaultState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return LoadingBackground(
            loading: state.status == VaultStatus.loading,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: state.keys.isNotEmpty
                ?ScrollConfiguration(
                  behavior: NoScrollBehavior(),
                  child: ListView.builder(
                    itemCount: state.keys.entries.length + 1,
                    itemBuilder: (context, index) {
                      if(index == state.keys.entries.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(AddKeyPage.route),
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
                                  Icon(Icons.add),
                                  SizedBox(width: 20),
                                  Text('Create a new Key',
                                    style: Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 18,
                                      color: Colors.grey[400]
                                    )
                                  )
                                ]
                              )
                            )
                          )
                        );
                      }

                      final key = state.keys.entries.elementAt(index);
                      return Padding(
                        key: ValueKey(state.keys[index]),
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: KeyWidget(key.key, key.value),
                      );
                    }
                  )
                )
                :Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: _buildUnlockedEmpty(context),
                )
            ),
          );
        }
      )
    );
  }

  Widget _buildUnlockedEmpty(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 16
          ),
          children: [
            TextSpan(
              text: 'You do not have currently any key. You must create one to be able to store passwords. ',
            ),
            TextSpan(
              style: TextStyle(
                color: Theme.of(context).textTheme.headline5!.color,
                decoration: TextDecoration.underline
              ),
              text: 'Create your first key.',
              recognizer: TapGestureRecognizer()..onTap = () 
              => Navigator.of(context).push(AddKeyPage.route)
            ),
          ]
        )
      )
    );
  }
}