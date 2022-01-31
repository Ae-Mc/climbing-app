import 'package:climbing_app/arch/single_result_bloc/single_result_bloc.dart';
import 'package:climbing_app/arch/single_result_bloc/stream_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef SingleResultListener<SingleResult> = void Function(
  BuildContext context,
  SingleResult singleResult,
);

/// Виджет-прослойка над bloc-builder для работы с SingleResultBloc
class SingleResultBlocBuilder<
    Bloc extends SingleResultBloc<Object?, State, SingleResult>,
    State,
    SingleResult> extends StatelessWidget {
  final Bloc? bloc;
  final SingleResultListener<SingleResult> onSingleResult;
  final BlocWidgetBuilder<State> builder;
  final BlocBuilderCondition<State>? buildWhen;

  const SingleResultBlocBuilder({
    required this.onSingleResult,
    required this.builder,
    this.bloc,
    this.buildWhen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamListener<SingleResult>(
      stream: (bloc ?? context.read<Bloc>()).singleResults,
      onData: (data) => onSingleResult(context, data),
      child: BlocBuilder(
        bloc: bloc,
        builder: builder,
        buildWhen: buildWhen,
      ),
    );
  }
}
