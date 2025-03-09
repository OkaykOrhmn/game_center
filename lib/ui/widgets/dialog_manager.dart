
import 'package:flutter/material.dart';
import 'package:game_center/ui/screens/add_game_screen.dart';

class DialogManager {
  final BuildContext context;
  DialogManager(this.context);

  void _show(
      {required final Widget Function(BuildContext context) builder}) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Container(
          width: MediaQuery.of(context).size.height * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(32),
          child: builder(context),
        ),
      ),
    );
  }

  void addGameLayout() {
    _show(
      builder: (context) => AddGameScreen(),
    );
  }
}
