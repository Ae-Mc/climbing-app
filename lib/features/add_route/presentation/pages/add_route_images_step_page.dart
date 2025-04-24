import 'dart:typed_data';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/submit_button.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_bloc.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_event.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_single_result.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_state.dart';
import 'package:climbing_app/features/add_route/presentation/widgets/header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:single_result_bloc/single_result_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'add_route_images_step_page.freezed.dart';

@RoutePage()
class AddRouteImagesStepPage extends StatefulWidget {
  const AddRouteImagesStepPage({super.key});

  @override
  State<AddRouteImagesStepPage> createState() => _AddRouteImagesStepPageState();
}

class _AddRouteImagesStepPageState extends State<AddRouteImagesStepPage> {
  final controller = PageController();
  final imagePicker = ImagePicker();
  List<UploadImageModel> images = [];

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const Pad(all: 16),
            child: Column(
              children: [
                const Header(stepNum: 3),
                const SizedBox(height: 32),
                Text(
                  'ШАГ 3: Добавь фотографии\n\nДобавляй фотографии по очереди: от старта трассы к финишу',
                  style: textTheme.body2Regular,
                  maxLines: 20,
                ),
                const SizedBox(height: 36),
                LayoutBuilder(
                  builder: (context, constraints) => AspectRatio(
                    aspectRatio: 1,
                    child: OverflowBox(
                      maxWidth: constraints.maxWidth + 32,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: images.length + 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const Pad(horizontal: 16),
                          child: index < images.length
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  child: Image.memory(
                                    images[index].fileBytes,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    width: 144,
                                    height: 144,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      onTap: () => pickImage(
                                        BlocProvider.of<AddRouteBloc>(context),
                                      ),
                                      child: DottedBorder(
                                        radius: const Radius.circular(16),
                                        dashPattern: const [6, 6],
                                        borderType: BorderType.RRect,
                                        color: colorTheme.primary,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload_outlined,
                                              color: colorTheme.secondary,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              'Загрузить фотографию',
                                              style: textTheme.headline2,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (images.isNotEmpty)
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: images.length + 1,
                      effect: ExpandingDotsEffect(
                        activeDotColor: colorTheme.secondary,
                        dotColor: colorTheme.unselected,
                        dotHeight: 6,
                        dotWidth: 6,
                      ),
                    ),
                  ),
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
              child: SingleResultBlocBuilder<AddRouteBloc, AddRouteState,
                  AddRouteSingleResult>(
                onSingleResult: (context, singleResult) =>
                    switch (singleResult) {
                  AddRouteSingleResultAddedSuccessfully() =>
                    AutoRouter.of(context)
                      ..popUntilRoot()
                      ..maybePop(),
                  AddRouteSingleResultFailure(:final failure) =>
                    CustomToast(context)
                        .showTextFailureToast(failureToText(failure)),
                },
                builder: (context, state) => SubmitButton(
                  onPressed: () => BlocProvider.of<AddRouteBloc>(context)
                      .add(const AddRouteEvent.uploadRoute()),
                  isLoaded: state is! AddRouteStateLoading,
                  text: 'Добавить трассу',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void pickImage(AddRouteBloc bloc) async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      images.add(UploadImageModel(image, imageBytes));
      bloc.add(AddRouteEvent.setImages(images.map((e) => e.file).toList()));
      setState(() => {});
    }
  }
}

@freezed
sealed class UploadImageModel with _$UploadImageModel {
  const factory UploadImageModel(XFile file, Uint8List fileBytes) =
      _UploadImageModel;
}
