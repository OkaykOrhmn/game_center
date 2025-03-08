import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageCustomesPage extends StatelessWidget {
  const ManageCustomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Customers'),
      ),
      body: Column(
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
                    await showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.height * 0.6,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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
          Table(
            columnWidths: {
              0: const FlexColumnWidth(1),
              1: const FlexColumnWidth(1),
              2: const FlexColumnWidth(2),
              3: const FlexColumnWidth(2),
              4: const FlexColumnWidth(2),
              5: const FlexColumnWidth(2),
            },
            border: TableBorder.all(
                color: Theme.of(context).colorScheme.onSurface, width: 0.5),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
            ],
          )
        ],
      ),
    );
  }
}
