import 'dart:typed_data';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/update_route/domain/entities/file.dart';
import 'package:climbing_app/features/routes/domain/entities/image.dart'
    as route_image;
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

class ImagesCarousel extends StatefulWidget {
  final ImagesCarouselController controller;
  final List<route_image.Image> initialImages;

  const ImagesCarousel(
      {super.key, required this.controller, required this.initialImages});

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel>
    with AutomaticKeepAliveClientMixin {
  final imagesPageController = PageController(initialPage: 0);
  var imagesTapped = <bool>[];

  var imagePicker = ImagePicker();

  @override
  bool get wantKeepAlive => true;

  Future<List<File>> initImages() async {
    if (!widget.controller.imagesInitialized) {
      final temp = <int, File>{};
      for (int i = 0; i < widget.initialImages.length; i++) {
        final image = widget.initialImages[i];
        var imageData = GetIt.I<Dio>()
            .get(image.url, options: Options(responseType: ResponseType.bytes))
            .then((value) => Uint8List.fromList(value.data as List<int>));
        temp[i] =
            (File(filename: path.basename(image.url), data: await imageData));
        GetIt.I<Logger>().d("Image $image loaded");
      }
      widget.controller.images.clear();
      for (int i = 0; i < widget.initialImages.length; i++) {
        if (temp.containsKey(i)) {
          widget.controller.images.add(temp[i]!);
        }
      }
      imagesTapped =
          List.filled(widget.controller.images.length, false, growable: true);
      widget.controller.imagesInitialized = true;
    }
    return widget.controller.images;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxWidth - 32,
        child: Material(
          color: AppTheme.of(context).colorTheme.background,
          child: FutureBuilder<void>(
              future: initImages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    controller: imagesPageController,
                    itemCount: imagesTapped.length + 1,
                    itemBuilder: (context, index) => (index ==
                            imagesTapped.length)
                        ? Center(
                            child: SizedBox.square(
                            dimension: constraints.maxWidth / 2,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              onTap: () => pickImage(),
                              child: DottedBorder(
                                radius: const Radius.circular(16),
                                dashPattern: const [6, 6],
                                borderType: BorderType.RRect,
                                color: colorTheme.primary,
                                padding: const Pad(all: 8),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          ))
                        : Padding(
                            padding: const Pad(horizontal: 16),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              onTap: () => setState(() {
                                imagesTapped[index] = !imagesTapped[index];
                              }),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: MemoryImage(
                                          widget.controller.images[index].data,
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: imagesTapped[index]
                                            ? const ColorFilter.mode(
                                                Colors.black45,
                                                BlendMode.darken,
                                              )
                                            : null,
                                      ),
                                    ),
                                    child: imagesTapped[index]
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () =>
                                                    replaceImage(index),
                                                icon: const Icon(
                                                  Icons.upload_file,
                                                ),
                                                color: Colors.white,
                                                iconSize: 48,
                                              ),
                                              const SizedBox(width: 32),
                                              IconButton(
                                                onPressed: () => setState(() {
                                                  imagesTapped.removeAt(index);
                                                  widget.controller.images
                                                      .removeAt(index);
                                                }),
                                                icon: const Icon(
                                                  Icons.delete_forever_outlined,
                                                ),
                                                color: Colors.white,
                                                iconSize: 48,
                                              ),
                                            ],
                                          )
                                        : null,
                                    // margin: Pad.zero,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: const Text("Ошибка получения изображений с сервера"),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              }),
        ),
      ),
    );
  }

  void pickImage() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      widget.controller.images
          .add(File(filename: path.basename(image.path), data: imageBytes));
      imagesTapped.add(false);
      setState(() => {});
    }
  }

  void replaceImage(int index) async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() {
        widget.controller.images[index] =
            (File(filename: path.basename(image.path), data: imageBytes));
        imagesTapped[index] = false;
      });
    }
  }
}

class ImagesCarouselController {
  final List<File> images;
  var imagesInitialized = false;

  ImagesCarouselController({required this.images});
}
