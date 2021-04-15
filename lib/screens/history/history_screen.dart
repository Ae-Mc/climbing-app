import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traverse/generated/l10n.dart';
import 'package:traverse/models/record.dart';
import 'package:traverse/style.dart';
import 'package:traverse/utils/database_helper.dart';
import 'package:traverse/utils/functions.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int itemsLength = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          child: ListView.builder(
            itemCount: DatabaseHelper.of(context).records.length,
            padding: EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              Record record = DatabaseHelper.of(context).records[index];
              return ListTile(
                minVerticalPadding: 0,
                title: Row(
                  children: [
                    Expanded(
                      child: (record.dateTime != null)
                          ? Text(
                              DateFormat.yMd('ru')
                                  .add_Hm()
                                  .format(record.dateTime),
                            )
                          : SizedBox(),
                    ),
                    Expanded(
                      child: Text(
                        stringFromDuration(record.totalTime),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  height: 48,
                  width: 48,
                  child: FloatingActionButton(
                    onPressed: () => DatabaseHelper.of(context, listen: false)
                        .delete(record.id),
                    child: Icon(Icons.delete),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
