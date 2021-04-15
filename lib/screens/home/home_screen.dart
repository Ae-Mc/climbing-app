import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traverse/generated/l10n.dart';
import 'package:traverse/models/lap.dart';
import 'package:traverse/models/record.dart';
import 'package:traverse/utils/database_helper.dart';
import 'package:traverse/utils/functions.dart';
import 'package:traverse/widgets/cell.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> _fadeAnimation;
  Animation<RelativeRect> _playIconMovementAnimation;
  Animation<RelativeRect> _lapIconMovementAnimation;
  AnimationController _controller;
  final Stopwatch _stopwatch = Stopwatch();
  Timer _timer;
  String _displayedTime = stringFromDuration(Duration.zero);
  Record record = Record();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 301),
    );
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _lapIconMovementAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, 32),
      end: RelativeRect.fromLTRB(-35, 0, 35, 32),
    ).animate(_controller);
    _playIconMovementAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, 32),
      end: RelativeRect.fromLTRB(35, 0, -35, 32),
    ).animate(_controller);

    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (_stopwatch.isRunning) {
          _displayedTime = stringFromDuration(_stopwatch.elapsed);
          if (record.secondLap == null)
            record.firstLap = Lap(
              duration: _stopwatch.elapsed,
              finishTime: _stopwatch.elapsed,
            );
          else if (record.thirdLap == null)
            record.secondLap = Lap(
              duration: _stopwatch.elapsed - record.firstLap.finishTime,
              finishTime: _stopwatch.elapsed,
            );
          else
            record.thirdLap = Lap(
              duration: _stopwatch.elapsed - record.secondLap.finishTime,
              finishTime: _stopwatch.elapsed,
            );
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            _displayedTime,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 16),
          Spacer(),
          _table(context),
          Spacer(),
          SizedBox(height: 16),
          _bottomButtonsStack(),
        ],
      ),
    );
  }

  Widget _table(BuildContext context) {
    final emptyCell = Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 32,
        child: Divider(
          thickness: 1,
          color: Theme.of(context).dividerColor,
        ),
      ),
    );
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Cell(text: S.current.Lap),
            Cell(text: S.current.LapTime),
            Cell(text: S.current.TotalTime),
          ],
        ),
        TableRow(
          children: [
            Cell(
              text: S.current.First,
              alignment: Alignment.centerLeft,
            ),
            (record.firstLap != null)
                ? Cell(
                    text: stringFromDuration(record.firstLap.duration),
                    alignment: Alignment.center)
                : emptyCell,
            (record.firstLap != null)
                ? Cell(text: stringFromDuration(record.firstLap.finishTime))
                : emptyCell,
          ],
        ),
        TableRow(
          children: [
            Cell(
              text: S.current.Second,
              alignment: Alignment.centerLeft,
            ),
            (record.secondLap != null)
                ? Cell(
                    text: stringFromDuration(record.secondLap.duration),
                    alignment: Alignment.center)
                : emptyCell,
            (record.secondLap != null)
                ? Cell(text: stringFromDuration(record.secondLap.finishTime))
                : emptyCell,
          ],
        ),
        TableRow(
          children: [
            Cell(
              text: S.current.Third,
              alignment: Alignment.centerLeft,
            ),
            (record.thirdLap != null)
                ? Cell(
                    text: stringFromDuration(record.thirdLap.duration),
                    alignment: Alignment.center)
                : emptyCell,
            (record.thirdLap != null)
                ? Cell(text: stringFromDuration(record.thirdLap.finishTime))
                : emptyCell,
          ],
        ),
      ],
    );
  }

  Widget _bottomButtonsStack() {
    final lapButton = () => FloatingActionButton(
          onPressed: () {
            if (_stopwatch.isRunning) {
              if (record.isFilled) {
                _stopwatch.stop();
                _stopwatch.reset();
              } else {
                if (record.firstLap == null)
                  record.firstLap = Lap();
                else if (record.secondLap == null)
                  record.secondLap = Lap();
                else
                  record.thirdLap = Lap();
              }
            } else {
              reset();
            }
          },
          child: Icon(
            _stopwatch.isRunning ? Icons.flag_rounded : Icons.stop_rounded,
          ),
        );

    final playButton = () => FloatingActionButton(
          onPressed: () async {
            if (_stopwatch.isRunning) {
              _stopwatch.stop();
            } else {
              if (record.isFilled) {
                print(record.toMap());
                print(record);
                await DatabaseHelper.of(context, listen: false).insert(record);
                reset();
              } else {
                _stopwatch.start();
                _controller.forward();
                if (record.isEmpty) record.firstLap = Lap();
              }
            }
          },
          child: Icon(
            _stopwatch.isRunning
                ? Icons.pause_rounded
                : (record.isFilled)
                    ? Icons.save_rounded
                    : Icons.play_arrow_rounded,
          ),
        );

    return SizedBox(
      height: 86,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PositionedTransition(
            rect: _lapIconMovementAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: lapButton(),
              ),
            ),
          ),
          PositionedTransition(
            rect: _playIconMovementAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => _controller.isDismissed
                    ? playButton()
                    : FadeTransition(
                        opacity: _fadeAnimation,
                        child: playButton(),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _controller.reverse();
    setState(() {
      record.clear();
      _displayedTime = stringFromDuration(Duration.zero);
    });
  }
}
