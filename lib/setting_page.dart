import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_center/manage_customes_page.dart';
import 'package:game_center/utils/empty_space.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool expande_one = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  expande_one = !expande_one;
                });
              },
              elevation: 8,
              children: [
                ExpansionPanel(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    canTapOnHeader: true,
                    isExpanded: expande_one,
                    headerBuilder: (context, isExpanded) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: const Text('Game Store'),
                          ),
                        ),
                    body: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile.adaptive(
                                value: false,
                                title: Text('Steam'),
                                onChanged: (value) {},
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile.adaptive(
                                value: true,
                                title: Text('Epic'),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile.adaptive(
                                value: false,
                                title: Text('Xbox'),
                                onChanged: (value) {},
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile.adaptive(
                                value: true,
                                title: Text('Ubisoft'),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile.adaptive(
                                value: false,
                                title: Text('Custome Games'),
                                onChanged: (value) {},
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) =>
                                          ManageCustomesPage(),
                                    ));
                                  },
                                  child: Text('Manage Custome')),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.add),
                              label: Text('Add Custome Category')),
                        ),
                      ],
                    ))
              ],
            ),
            16.h,
          ],
        ),
      ),
    );
  }
}
