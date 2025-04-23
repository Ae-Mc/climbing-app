import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/competitions/domain/entities/competition_create.dart';
import 'package:climbing_app/features/competitions/domain/entities/participant_create.dart';
import 'package:climbing_app/features/competitions/presentation/bloc/competitions_bloc.dart';
import 'package:climbing_app/features/competitions/presentation/widgets/participant_card.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class AddCompetitionPage extends StatefulWidget {
  const AddCompetitionPage({super.key});

  @override
  State<AddCompetitionPage> createState() => _AddCompetitionPageState();
}

class _AddCompetitionPageState extends State<AddCompetitionPage> {
  final TextEditingController dateController =
      TextEditingController(text: GetIt.I<DateFormat>().format(DateTime.now()));
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ratioController =
      TextEditingController(text: '1.0');
  String? dateError;
  String? nameError;
  String? ratioError;
  Map<User, int> participants = {};

  @override
  void initState() {
    checkDate();
    checkName();
    checkRatio();
    dateController.addListener(checkDate);
    nameController.addListener(checkName);
    ratioController.addListener(checkRatio);
    super.initState();
  }

  void checkDate() {
    setState(() => dateError = dateController.text.trim().isEmpty
        ? 'Дата не может быть пустой'
        : null);
  }

  void checkName() {
    setState(() => nameError = nameController.text.trim().isEmpty
        ? 'Название не может быть пустым'
        : null);
  }

  void checkRatio() {
    setState(() => ratioError = ratioController.text.trim().isEmpty
        ? 'Коэффицент не может быть пустым'
        : double.tryParse(ratioController.text.trim()) == null
            ? 'Коэффицент должен быть числом'
            : null);
  }

  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    ratioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is! UserStateAuthorized) {
              throw UnimplementedError('Impossible state');
            }
            final sortedUsers = List<User>.from(state.allUsers);
            sortedUsers.sort(
              (a, b) => ('${a.lastName} ${a.firstName}'.toLowerCase())
                  .compareTo('${b.lastName} ${b.firstName}'.toLowerCase()),
            );

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor: colorTheme.background,
                  foregroundColor: colorTheme.onBackground,
                  title: const Text('Добавление соревнования'),
                  leading: const BackButton(),
                  floating: true,
                  snap: true,
                  forceElevated: true,
                ),
              ],
              body: ListView(
                padding: const Pad(horizontal: 16, vertical: 16),
                children: [
                  StyledTextField(
                    controller: nameController,
                    errorText: nameError,
                    hintText: 'Название',
                    suffixIcon: Icon(Icons.abc, color: colorTheme.primary),
                  ),
                  const SizedBox(height: 16),
                  StyledTextField(
                    controller: dateController,
                    errorText: dateError,
                    hintText: 'Дата проведения',
                    onTap: () => pickDate(context, dateController),
                    readOnly: true,
                    suffixIcon:
                        Icon(Icons.calendar_today, color: colorTheme.primary),
                  ),
                  const SizedBox(height: 16),
                  StyledTextField(
                    controller: ratioController,
                    errorText: ratioError,
                    hintText: 'Коэффицент баллов',
                    suffixIcon:
                        Icon(Icons.onetwothree, color: colorTheme.primary),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Участники',
                    style: textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ...sortedUsers.map((e) => Padding(
                        padding: const Pad(top: 8),
                        child: ParticipantCard(
                          user: e,
                          onPlaceChange: (place) => setState(() => place == null
                              ? participants.remove(e)
                              : participants[e] = place),
                        ),
                      )),
                  if (participants.isEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Добавьте участников!',
                      style: textTheme.body1Regular
                          .copyWith(color: colorTheme.error),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  SingleResultBlocBuilder<CompetitionsBloc, CompetitionsState,
                      CompetitionsSingleResult>(
                    onSingleResult: (context, singleResult) {
                      switch (singleResult) {
                        case CompetitionsSingleResultFailure(:final failure):
                          CustomToast(context)
                              .showTextFailureToast(failureToText(failure));
                        case CompetitionsSingleResultSuccess():
                          CustomToast(context).showTextSuccessToast(
                            'Соревнование успешно добавлено',
                          );

                          AutoRouter.of(context).maybePop();
                      }
                    },
                    builder: (context, state) => SubmitButton(
                      isActive: [nameError, dateError, ratioError]
                              .every((element) => element == null) &&
                          participants.isNotEmpty,
                      isLoaded: state is! CompetitionsStateLoading,
                      onPressed: () =>
                          add(BlocProvider.of<CompetitionsBloc>(context)),
                      text: 'Добавить',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void add(CompetitionsBloc bloc) {
    bloc.add(CompetitionsEvent.addCompetition(CompetitionCreate(
      name: nameController.text,
      date: GetIt.I<DateFormat>().parse(dateController.text),
      ratio: double.parse(ratioController.text),
      participants: participants.entries
          .map((e) => ParticipantCreate(place: e.value, userId: e.key.id))
          .toList(),
    )));
  }
}
