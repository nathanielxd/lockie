import 'package:flutter/material.dart';
import 'package:lockie_app/account/account.dart';
import 'package:lockie_app/vault/vault.dart';
import 'package:lockie_theme/lockie_theme.dart';

class MenuView extends StatefulWidget {

  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      vsync: this,
      length: 3
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
              child: LockieIconButton(
                icon: Icons.arrow_back_ios_rounded, 
                onPressed: () => Navigator.of(context).pop()
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: [
                  ...{
                    0: 'Keys',
                    1: 'Account',
                    2: 'Settings'
                  }.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () => tabController.animateTo(e.key),
                        child: AnimatedBuilder(
                          animation: tabController,
                          builder: (context, widget) {
                            return Text(e.value,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(tabController.animation!.value == e.key ? 1 : 0.5)
                              )
                            );
                          }
                        )
                      )
                    ),
                  ).toList()
                ]
              )
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  VaultPage(),
                  AccountPage(),
                  Text('C')
                ],
              ),
            )
          ]
        )
      )
    );
  }
}