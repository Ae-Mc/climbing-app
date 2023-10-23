import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/add_competition/domain/entities/competition_create.dart';
import 'package:climbing_app/features/add_competition/domain/entities/participant_create.dart';
import 'package:climbing_app/features/add_competition/presentation/bloc/add_competition_bloc.dart';
import 'package:climbing_app/features/add_competition/presentation/widgets/participant_card.dart';
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
    // ignore: avoid-unnecessary-setstate
    [checkDate(), checkName(), checkRatio()];
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
        child: BlocProvider(
          create: (context) => GetIt.I<AddCompetitionBloc>(),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => ListView(
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
                ...state.maybeMap(
                  authorized: (value) => value.allUsers.map((e) => Padding(
                        padding: const Pad(top: 8),
                        child: ParticipantCard(
                          user: e,
                          onPlaceChange: (place) => setState(() => place == null
                              ? participants.remove(e)
                              : participants[e] = place),
                        ),
                      )),
                  orElse: () => throw UnimplementedError("Impossible state"),
                ),
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
                SingleResultBlocBuilder<AddCompetitionBloc, AddCompetitionState,
                    AddCompetitionSingleResult>(
                  onSingleResult: (context, singleResult) => singleResult.when(
                    failure: (failure) => CustomToast(context)
                        .showTextFailureToast(failureToText(failure)),
                    success: () {
                      CustomToast(context).showTextSuccessToast(
                        'Соревнование успешно добавлено',
                      );

                      return AutoRouter.of(context).pop();
                    },
                  ),
                  builder: (context, state) {
                    return SubmitButton(
                      isActive: [nameError, dateError, ratioError]
                              .every((element) => element == null) &&
                          participants.isNotEmpty,
                      isLoaded:
                          state.when(loaded: () => true, loading: () => false),
                      onPressed: () =>
                          add(BlocProvider.of<AddCompetitionBloc>(context)),
                      text: 'Добавить',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add(AddCompetitionBloc bloc) {
    bloc.add(AddCompetitionEvent.addCompetition(CompetitionCreate(
      name: nameController.text,
      date: GetIt.I<DateFormat>().parse(dateController.text),
      ratio: double.parse(ratioController.text),
      participants: participants.entries
          .map((e) => ParticipantCreate(place: e.value, userId: e.key.id))
          .toList(),
    )));
  }
}
