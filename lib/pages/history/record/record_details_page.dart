import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/models/db_record.dart';
import 'package:itmo_climbing/theme/custom_color_scheme.dart';
import 'package:itmo_climbing/utils/functions.dart';

class RecordDetailsPage extends StatelessWidget {
  final DBRecord dbRecord;

  const RecordDetailsPage({Key? key, required this.dbRecord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: IntrinsicHeight(
          child: Theme(
            data: Theme.of(context).copyWith(
              cardTheme: CardTheme(margin: EdgeInsets.all(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            S.current.Climb,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            _getDateTimeStr(dbRecord.date),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildFlexibleCard(
                  context,
                  number: 1,
                  title: S.current.FirstLap,
                  content: stringFromDuration(dbRecord.firstLap.duration),
                ),
                _buildFlexibleCard(
                  context,
                  number: 2,
                  title: S.current.SecondLap,
                  content: stringFromDuration(dbRecord.secondLap.duration),
                ),
                _buildFlexibleCard(
                  context,
                  number: 3,
                  title: S.current.ThirdLap,
                  content: stringFromDuration(dbRecord.thirdLap.duration),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlexibleCard(
    BuildContext context, {
    required int number,
    required String title,
    required String content,
    int flex = 2,
  }) {
    assert(number >= 0 && number < 10);
    return Flexible(
      flex: flex,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.indicatorColors[
                            (number - 1) %
                                Theme.of(context)
                                    .colorScheme
                                    .indicatorColors
                                    .length],
                      ),
                      padding: EdgeInsets.all(12),
                      child: Text(
                        number.toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDateTimeStr(DateTime dateTime) {
    return DateFormat.yMd().add_Hm().format(dateTime);
  }
}
