import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_bloc.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_event.dart';
import 'package:climbing_app/features/add_route/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddRouteBasicsStepPage extends StatefulWidget {
  const AddRouteBasicsStepPage({Key? key}) : super(key: key);

  @override
  State<AddRouteBasicsStepPage> createState() => _AddRouteBasicsStepPageState();
}

class _AddRouteBasicsStepPageState extends State<AddRouteBasicsStepPage> {
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(() => setState(() => {}));
    colorController.addListener(() => setState(() => {}));
    dateController.addListener(() => setState(() => {}));
    descriptionController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    colorController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const Pad(all: 16, bottom: 32),
            child: Column(
              children: [
                const Header(stepNum: 1),
                const SizedBox(height: 32),
                Text(
                  'ШАГ 1: Заполните основные параметры\n\nВведите основные параметры трассы: её название, цвет меток и дату постановки.',
                  style: AppTheme.of(context).textTheme.body2Regular,
                  maxLines: 20,
                ),
                const SizedBox(height: 32),
                StyledTextField(
                  controller: nameController,
                  hintText: 'Название',
                  suffixIcon: Icon(
                    Icons.abc,
                    color: colorTheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                StyledTextField(
                  controller: colorController,
                  hintText: 'Цвет меток',
                  suffixIcon: Icon(
                    Icons.color_lens_rounded,
                    color: colorTheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                StyledTextField(
                  controller: dateController,
                  hintText: 'Дата постановки',
                  onTap: () => pickDate(context, dateController),
                  readOnly: true,
                  suffixIcon:
                      Icon(Icons.calendar_today, color: colorTheme.primary),
                ),
                const SizedBox(height: 16),
                StyledTextField(
                  controller: descriptionController,
                  hintText: 'Описание',
                  maxLines: 8,
                  inputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const Pad(bottom: 16, horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (nameController.text.isEmpty ||
                        colorController.text.isEmpty ||
                        dateController.text.isEmpty)
                    ? null
                    : () {
                        BlocProvider.of<AddRouteBloc>(context)
                            .add(AddRouteEvent.setName(nameController.text));
                        if (colorController.text.length < 4) {
                          CustomToast(context).showTextFailureToast(
                            'Название цвета должно быть минимум из 4 символов',
                          );

                          return;
                        }
                        BlocProvider.of<AddRouteBloc>(context).add(
                          AddRouteEvent.setMarksColor(colorController.text),
                        );
                        BlocProvider.of<AddRouteBloc>(context)
                            .add(AddRouteEvent.setDate(
                          GetIt.I<DateFormat>().parse(dateController.text),
                        ));
                        BlocProvider.of<AddRouteBloc>(context)
                            .add(AddRouteEvent.setDescription(
                          descriptionController.text,
                        ));
                        // ignore: avoid-ignoring-return-values
                        AutoRouter.of(context)
                            .push(const AddRouteCategoryStepRoute());
                      },
                child: const Text('Вперёд'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
