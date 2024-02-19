import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/util/pick_date.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

@RoutePage()
class UpdateRoutePage extends StatefulWidget {
  final Route route;

  const UpdateRoutePage(this.route, {super.key});

  @override
  State<UpdateRoutePage> createState() => _UpdateRoutePageState();
}

class _UpdateRoutePageState extends State<UpdateRoutePage> {
  final nameController = TextEditingController();
  final marksColorController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.route.name;
    marksColorController.text = widget.route.markColor;
    dateController.text =
        GetIt.I<DateFormat>().format(widget.route.creationDate);
    categoryController.text = widget.route.category.name;
    descriptionController.text = widget.route.description;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    final columnItems = [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(
          label: Text("Название трассы"),
          suffixIcon: Icon(Icons.abc),
        ),
      ),
      TextField(
        controller: marksColorController,
        decoration: const InputDecoration(
          label: Text("Цвет меток"),
          suffixIcon: Icon(Icons.color_lens_rounded),
        ),
      ),
      TextField(
        controller: dateController,
        decoration: const InputDecoration(
          label: Text("Дата постановки"),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => pickDate(context, dateController),
      ),
      SizedBox(
        width: double.infinity,
        child: DropdownMenu<Category>(
          controller: categoryController,
          inputDecorationTheme: Theme.of(context).inputDecorationTheme,
          label: Text("Категория", style: textTheme.subtitle1),
          dropdownMenuEntries: Category.values
              .map(
                (category) =>
                    DropdownMenuEntry(value: category, label: category.name),
              )
              .toList(),
          expandedInsets: Pad.zero,
        ),
      ),
      TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          label: Text("Описание"),
        ),
        maxLines: 8,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
      ),
    ];

    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          text: "Редактирование трассы",
          leading: BackButton(),
        ),
        SliverPadding(
          padding: const Pad(all: 16),
          sliver: SliverList.separated(
            itemBuilder: (context, index) => columnItems[index],
            itemCount: columnItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          ),
        )
      ],
    )));
  }
}
