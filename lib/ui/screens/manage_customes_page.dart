// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_center/bloc/game_bloc.dart';
import 'package:game_center/core/utils/empty_space.dart';
import 'package:game_center/ui/widgets/dialog_manager.dart';

class ManageCustomesPage extends StatefulWidget {
  const ManageCustomesPage({super.key});

  @override
  State<ManageCustomesPage> createState() => _ManageCustomesPageState();
}

class _ManageCustomesPageState extends State<ManageCustomesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Customers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_rounded)),
                IconButton(onPressed: () {}, icon: Icon(Icons.save)),
                IconButton(
                    onPressed: () async {
                      DialogManager(context).addGameLayout();
                    },
                    icon: Icon(Icons.add)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.delete_outline_rounded)),
                IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.question_mark_rounded)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_horiz_rounded)),
              ],
            ),
            32.h,
            BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return Table(
                  columnWidths: {
                    0: const FlexColumnWidth(1),
                    1: const FlexColumnWidth(1),
                    2: const FlexColumnWidth(2),
                    3: const FlexColumnWidth(2),
                    4: const FlexColumnWidth(2),
                    5: const FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 0.5),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                      ),
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Title'),
                          ),
                        ),
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Category'),
                          ),
                        ),
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Launch Path or URL'),
                          ),
                        ),
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Cover Art Path or Url'),
                          ),
                        ),
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Background Image Path or URL'),
                          ),
                        ),
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Description'),
                          ),
                        ),
                      ],
                    ),
                    ...List.generate(
                      state.games.length,
                      (index) {
                        final game = state.games[index];

                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(game.title),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Category'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(game.exePath),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(game.image),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(game.backgroundImage),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  game.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
