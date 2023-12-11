import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/styled_text_field.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';

class ParticipantCard extends StatefulWidget {
  final void Function(int? place) onPlaceChange;
  final User user;

  const ParticipantCard({
    super.key,
    required this.onPlaceChange,
    required this.user,
  });

  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard>
    with AutomaticKeepAliveClientMixin<ParticipantCard> {
  final TextEditingController placeController = TextEditingController();
  bool isError = false;

  @override
  void initState() {
    placeController.addListener(() {
      final place = int.tryParse(placeController.text.trim());
      setState(() =>
          isError = placeController.text.trim().isNotEmpty && place == null);
      widget.onPlaceChange(place);
    });
    super.initState();
  }

  @override
  void dispose() {
    placeController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const Pad(all: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.user.lastName} ${widget.user.firstName}',
                    style: textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '@${widget.user.username}',
                    style: textTheme.subtitle2
                        .copyWith(color: colorTheme.secondaryVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 75, minWidth: 50),
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    StyledTextField(
                      controller: placeController,
                      isError: isError,
                      hintText: 'Нет',
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    ),
                    Text('Место', style: textTheme.subtitle2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
