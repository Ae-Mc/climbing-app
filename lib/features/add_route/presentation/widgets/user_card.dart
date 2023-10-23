import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;
  final bool isSelected;
  final void Function() onTap;

  const UserCard({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Padding(
          padding: const Pad(all: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: textTheme.subtitle1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '@${user.username}',
                      style: textTheme.subtitle2
                          .copyWith(color: colorTheme.secondaryVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: isSelected
                        ? BorderSide(width: 6, color: colorTheme.secondary)
                        : BorderSide.none,
                  ),
                  color: colorTheme.unselectedVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
