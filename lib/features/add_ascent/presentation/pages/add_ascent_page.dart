import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/add_ascent/domain/entities/ascent_create.dart';
import 'package:climbing_app/features/add_ascent/presentation/bloc/add_ascent_bloc.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class AddAscentPage extends StatefulWidget {
  final Route route;

  const AddAscentPage({super.key, required this.route});

  @override
  State<AddAscentPage> createState() => _AddAscentPageState();
}

class _AddAscentPageState extends State<AddAscentPage> {
  final dateController =
      TextEditingController(text: GetIt.I<DateFormat>().format(DateTime.now()));

  bool isFlash = false;

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return BlocProvider(
      create: (context) => GetIt.I<AddAscentBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const Pad(all: 16, bottom: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CustomBackButton(),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Добавление пролаза трассы «${widget.route.name}»',
                              style: textTheme.title,
                              maxLines: 5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      StyledTextField(
                        controller: dateController,
                        hintText: 'Дата пролаза',
                        onTap: () => pickDate(context, dateController),
                        readOnly: true,
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: colorTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        onTap: () => setState(() => isFlash = !isFlash),
                        title: const Text('Флеш'),
                        contentPadding: Pad.zero,
                        trailing: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: colorTheme.primary, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: isFlash
                              ? Center(
                                  child: Icon(
                                    Icons.done,
                                    size: 25,
                                    color: colorTheme.primary,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const Pad(all: 32),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleResultBlocBuilder<AddAscentBloc,
                          AddAscentState, AddAscentSingleResult>(
                        onSingleResult: (context, singleResult) =>
                            singleResult.when(
                          failure: (failure) => CustomToast(context)
                              .showTextFailureToast(failureToText(failure)),
                          success: () {
                            CustomToast(context).showTextSuccessToast(
                              'Пролаз успешно добавлен',
                            );

                            return AutoRouter.of(context).maybePop();
                          },
                        ),
                        builder: (context, state) => SubmitButton(
                          isLoaded: state.when(
                            loaded: () => true,
                            loading: () => false,
                          ),
                          onPressed: () => addAscent(context),
                          text: 'Добавить пролаз',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addAscent(BuildContext context) {
    if (dateController.text.isEmpty) {
      return CustomToast(context)
          .showTextFailureToast('Заполните дату пролаза!');
    }

    BlocProvider.of<AddAscentBloc>(context).add(AddAscentEvent.addAscent(
      AscentCreate(
        date: GetIt.I<DateFormat>().parse(dateController.text),
        isFlash: isFlash,
        routeId: widget.route.id,
      ),
    ));
  }
}
