import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/router.gr.dart';
import 'package:itmo_climbing/utils/database_helper.dart';
import 'package:itmo_climbing/utils/functions.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int itemsLength = 0;

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.queryAll();
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuild history screen');
    return Column(
      children: [
        ListTile(
          dense: true,
          minVerticalPadding: 0,
          title: Row(
            children: [
              Expanded(
                child: Text(
                  S.current.ClimbDate,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: Text(
                  S.current.ClimbTime,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          trailing: SizedBox(width: 48),
        ),
        Expanded(
          child: FutureBuilder(
            future: DatabaseHelper.instance.initializationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ListView.builder(
                  itemCount:
                      DatabaseHelper.of(context, listen: true).records.length,
                  padding: EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    final record = DatabaseHelper.of(context).records[index];
                    return Card(
                      child: ListTile(
                        onTap: () => AutoRouter.of(context)
                            .navigate(RecordDetailsRoute(dbRecord: record)),
                        minVerticalPadding: 0,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat.yMd('ru')
                                    .add_Hm()
                                    .format(record.date),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                stringFromDuration(record.totalTime),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () =>
                              DatabaseHelper.of(context, listen: false)
                                  .delete(record.id),
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError) {
                return Text('Error fetching history');
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
