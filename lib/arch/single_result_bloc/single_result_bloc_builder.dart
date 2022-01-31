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
    B extends SingleResultBloc<Object?, S, SingleResult>,
    S,
    SingleResult> extends StatelessWidget {
  final B? bloc;
  final SingleResultListener<SingleResult> onSingleResult;
  final BlocWidgetBuilder<S> builder;
  final BlocBuilderCondition<S>? buildWhen;

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
      stream: (bloc ?? context.read<B>()).singleResults,
      onData: (data) => onSingleResult(context, data),
      child: BlocBuilder(
        bloc: bloc,
        builder: builder,
        buildWhen: buildWhen,
      ),
    );
  }
}
