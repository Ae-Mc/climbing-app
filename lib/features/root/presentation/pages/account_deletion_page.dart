import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/root/presentation/widgets/hyperlink.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              text: 'Удаление аккаунта',
              leading: BackButton(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: Pad(all: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        'Для того, чтобы запросить удаление аккаунта, свяжитесь со мной:'),
                    Padding(
                      padding: Pad(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hyperlink(url: 'https://t.me/ae_mc'),
                          Hyperlink(url: 'https://vk.com/creeperasha'),
                          Hyperlink(
                            url: 'mailto:alexandr.mc12@gmail.com',
                            text: 'alexandr.mc12@gmail.com',
                          ),
                          Hyperlink(
                            url: 'mailto:ae_mc@mail.ru',
                            text: 'ae_mc@mail.ru',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
