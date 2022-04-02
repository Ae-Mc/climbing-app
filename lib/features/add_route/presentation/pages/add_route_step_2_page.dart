import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/unexpected_behavior.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_bloc.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_event.dart';
import 'package:climbing_app/features/add_route/presentation/widgets/header.dart';
import 'package:climbing_app/features/add_route/presentation/widgets/user_card.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRouteStep2Page extends StatefulWidget {
  const AddRouteStep2Page({Key? key}) : super(key: key);

  @override
  State<AddRouteStep2Page> createState() => _AddRouteStep2PageState();
}

class _AddRouteStep2PageState extends State<AddRouteStep2Page> {
  User? selectedUser;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const Pad(all: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Header(stepNum: 2),
                const SizedBox(height: 32),
                Text(
                  'ШАГ 2: Выбери автора',
                  style: AppTheme.of(context).textTheme.body2Regular,
                  maxLines: 20,
                ),
                const SizedBox(height: 24),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) => state.maybeWhen(
                    authorized: (_, allUsers) => Column(
                      children: allUsers
                          .map(
                            (user) => Padding(
                              padding: const Pad(vertical: 8),
                              child: UserCard(
                                user: user,
                                isSelected: user == selectedUser,
                                onTap: () =>
                                    setState(() => selectedUser = user),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    orElse: () => const UnexpectedBehavior(),
                  ),
                ),
                const SizedBox(height: 24),
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
                onPressed: selectedUser == null
                    ? null
                    : () {
                        final author = selectedUser;
                        if (author == null) {
                          throw UnimplementedError("Impossible state");
                        }
                        BlocProvider.of<AddRouteBloc>(context)
                            .add(AddRouteEvent.setAuthor(author));
                        // ignore: avoid-ignoring-return-values
                        AutoRouter.of(context).push(const AddRouteStep3Route());
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
