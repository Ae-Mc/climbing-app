import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/home_page/presentation/widgets/quarter_tile_widget.dart';
import 'package:flutter/material.dart';

class YearWidget extends StatelessWidget {
  final int year;

  const YearWidget({Key? key, required this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 16,
      margin: Pad.zero,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              margin: Pad.zero,
              color: AppTheme.of(context).colorTheme.primary,
              child: Padding(
                padding: const Pad(horizontal: 16, vertical: 3),
                child: Text(
                  year.toString(),
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: AppTheme.of(context).colorTheme.onPrimary,
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const Pad(vertical: 16, horizontal: 24),
            child: Theme(
              data: Theme.of(context).copyWith(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
              ),
              child: ListTileTheme(
                dense: true,
                contentPadding: Pad.zero,
                minVerticalPadding: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    QuarterTileWidget(title: 'Первый квартал'),
                    QuarterTileWidget(title: 'Второй квартал'),
                    QuarterTileWidget(title: 'Третий квартал'),
                    QuarterTileWidget(title: 'Четвёртый квартал'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
