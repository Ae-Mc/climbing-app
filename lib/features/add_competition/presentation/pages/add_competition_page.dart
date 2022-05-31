import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:flutter/material.dart';

class AddCompetitionPage extends StatefulWidget {
  const AddCompetitionPage({Key? key}) : super(key: key);

  @override
  State<AddCompetitionPage> createState() => _AddCompetitionPageState();
}

class _AddCompetitionPageState extends State<AddCompetitionPage> {
  final TextEditingController dateController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController ratioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const Pad(horizontal: 16, vertical: 16),
          children: [
            Row(
              children: [
                const CustomBackButton(),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Добавление соревнования',
                    maxLines: 2,
                    style: textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 16),
            StyledTextField(
              controller: nameController,
              hintText: 'Название',
              suffixIcon: Icon(Icons.abc, color: colorTheme.primary),
            ),
            const SizedBox(height: 16),
            StyledTextField(
              controller: dateController,
              hintText: 'Дата постановки',
              onTap: () => pickDate(context, dateController),
              readOnly: true,
              suffixIcon: Icon(Icons.calendar_today, color: colorTheme.primary),
            ),
            const SizedBox(height: 16),
            StyledTextField(
              controller: ratioController,
              hintText: 'Коэффицент баллов',
              suffixIcon: Icon(Icons.onetwothree, color: colorTheme.primary),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
