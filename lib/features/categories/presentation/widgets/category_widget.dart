import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';
import 'package:spend_wise/generated/locale_keys.g.dart';

class CategoryWidget extends StatefulWidget {
  final CategoryEntity? category;
  final bool canSelectCategory;
  final ValueChanged<List<CategoryEntity?>?>? onCategorySelected;
  final VoidCallback onTap;

  const CategoryWidget({
    super.key,
    this.category,
    required this.canSelectCategory,
    this.onCategorySelected,
    required this.onTap,
  });

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<CategoryEntity?>? selectedCategory = [];
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            left: 0,
            top: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  widget.category?.icon ?? Icons.category,
                  size: 80.sp,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
                Text(
                  widget.category?.name[0] ??
                      LocaleKeys.pages_category_categoryHaveNoName.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (widget.canSelectCategory)
            PositionedDirectional(
              top: 0,
              start: 0,
              child: SizedBox(
                width: 20.w,
                height: 20.h,
                child: Checkbox(
                  fillColor: WidgetStateColor.resolveWith((callback) {
                    if (callback.contains(WidgetState.disabled)) {
                      return Theme.of(context).disabledColor;
                    }
                    if (callback.contains(WidgetState.selected)) {
                      return Theme.of(context).colorScheme.surface;
                    }
                    return Theme.of(context).colorScheme.primary;
                  }),
                  checkColor: Theme.of(context).textTheme.headlineLarge?.color,
                  value: selectedCategory?.contains(widget.category),
                  onChanged: (value) {
                    setState(() {
                      if (selectedCategory?.contains(widget.category) ??
                          false) {
                        if (selectedCategory?.indexOf(widget.category) !=
                            null) {
                          selectedCategory?.removeAt(
                            selectedCategory?.indexOf(widget.category) ?? 0,
                          );
                        }
                      } else {
                        selectedCategory?.add(widget.category);
                      }
                    });
                    widget.onCategorySelected?.call(selectedCategory);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
