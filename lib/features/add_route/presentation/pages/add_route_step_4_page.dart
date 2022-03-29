import 'dart:typed_data';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/add_route/presentation/widgets/header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'add_route_step_4_page.freezed.dart';

class AddRouteStep4Page extends StatefulWidget {
  const AddRouteStep4Page({Key? key}) : super(key: key);

  @override
  State<AddRouteStep4Page> createState() => _AddRouteStep4PageState();
}

class _AddRouteStep4PageState extends State<AddRouteStep4Page> {
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
                const Header(stepNum: 4),
                const SizedBox(height: 32),
                Text(
                  'ШАГ 4: Добавь фотографии\n\nДобавляй фотографии по очереди: от старта трассы к финишу',
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
                                      onTap: pickImage,
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
              child: ElevatedButton(
                onPressed: () => GetIt.I<Logger>().d('Push route to server'),
                child: const Text('Добавить трассу'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void pickImage() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() => images.add(UploadImageModel(image, imageBytes)));
    }
  }
}

@freezed
class UploadImageModel with _$UploadImageModel {
  const factory UploadImageModel(XFile file, Uint8List fileBytes) =
      _UploadImageModel;
}
