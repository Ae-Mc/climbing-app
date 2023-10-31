import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AddRouteRootPage extends StatelessWidget {
  const AddRouteRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (_) => GetIt.I<AddRouteBloc>(),
          child: const AutoRouter(),
        ),
      ),
    );
  }
}
