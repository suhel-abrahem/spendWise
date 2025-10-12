import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass/glass.dart';
import 'package:go_router/go_router.dart';
import 'package:spend_wise/config/route/routes_manager.dart';
import 'package:spend_wise/core/dependencies_injection.dart';
import 'package:spend_wise/core/resource/main_page/main_page.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';
import 'package:spend_wise/features/categories/presentation/bloc/category_bloc.dart';
import 'package:spend_wise/features/categories/presentation/widgets/add_category_container.dart';
import 'package:spend_wise/features/categories/presentation/widgets/category_widget.dart';
import 'package:spend_wise/generated/locale_keys.g.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool isAddCategoryContainerShowed = false;
  double addCategoryContainerPosition = -620.h;
  bool canSelectCategory = false;
  List<CategoryEntity?>? selectedCategory = [];
  late List<CategoryEntity?>? getedCategories = [];
  void setAddCategoryContainerPosition() {
    addCategoryContainerPosition = isAddCategoryContainerShowed ? 0 : -620.h;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return MainPage(
      title: LocaleKeys.pages_category_title.tr(),
      key: ValueKey(isAddCategoryContainerShowed),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: LocaleKeys.pages_category_addCategory.tr(),
            iconColor:
                Theme.of(context).textTheme.labelLarge?.color ?? Colors.white,
            bubbleColor: Theme.of(context).colorScheme.primary,
            icon: Icons.add_rounded,
            titleStyle: Theme.of(context).textTheme.labelLarge ?? TextStyle(),
            onPress: () {
              setState(() {
                isAddCategoryContainerShowed = true;
                setAddCategoryContainerPosition();
              });
              _animationController.reverse();
            },
          ),

          Bubble(
            title: LocaleKeys.pages_category_editCategory.tr(),
            iconColor:
                Theme.of(context).textTheme.displayLarge?.color ?? Colors.white,
            bubbleColor: Theme.of(context).colorScheme.primary,
            icon: Icons.edit_rounded,
            titleStyle: Theme.of(context).textTheme.labelLarge ?? TextStyle(),
            onPress: () {
              setState(() {
                canSelectCategory = true;
                selectedCategory = [];
              });
              _animationController.reverse();
            },
          ),
        ],
        animation: _animation,
        onPress:
            () =>
                _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward(),
        iconColor:
            Theme.of(context).textTheme.labelLarge?.color ?? Colors.white,
        iconData: Icons.edit_rounded,
        backGroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocProvider(
          create:
              (context) =>
                  getItInstance<CategoryBloc>()
                    ..add(CategoryEvent.getCategories()),
          child: BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is Deleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.pages_category_categoryDeleted.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                BlocProvider.of<CategoryBloc>(
                  context,
                ).add(CategoryEvent.getCategories());
              }
              if (state is Error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${LocaleKeys.pages_category_errorOccurred.tr()}: ${state.message}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
              if (state is Added) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.pages_category_categoryAdded.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                BlocProvider.of<CategoryBloc>(
                  context,
                ).add(CategoryEvent.getCategories());
              }
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Visibility(
                          key: ValueKey(canSelectCategory),
                          visible: canSelectCategory,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 12.w,
                            ),

                            height: 50.h,
                            width: double.maxFinite,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  tooltip: LocaleKeys.selectAll.tr(),
                                  onPressed:
                                      (getedCategories != null &&
                                              (getedCategories?.isNotEmpty ??
                                                  false))
                                          ? () {
                                            setState(() {
                                              selectedCategory =
                                                  getedCategories;
                                            });
                                          }
                                          : null,
                                  icon: Icon(
                                    Icons.select_all_rounded,
                                    size: 24.sp,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                IconButton(
                                  tooltip: LocaleKeys.deselectAll.tr(),
                                  onPressed:
                                      (selectedCategory != null &&
                                              (selectedCategory?.isNotEmpty ??
                                                  false))
                                          ? () {
                                            setState(() {
                                              selectedCategory = [];
                                            });
                                          }
                                          : null,
                                  icon: Icon(
                                    Icons.clear_all_rounded,
                                    size: 24.sp,
                                    color:
                                        (selectedCategory != null &&
                                                (selectedCategory?.isNotEmpty ??
                                                    false))
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryContainer
                                            : Theme.of(context).disabledColor,
                                  ),
                                ),
                                BlocBuilder<CategoryBloc, CategoryState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      tooltip: LocaleKeys.delete.tr(),
                                      onPressed:
                                          (selectedCategory != null &&
                                                  (selectedCategory
                                                          ?.isNotEmpty ??
                                                      false))
                                              ? () {
                                                if (selectedCategory != null &&
                                                    (selectedCategory
                                                            ?.isNotEmpty ??
                                                        false)) {
                                                  BlocProvider.of<CategoryBloc>(
                                                    context,
                                                  ).add(
                                                    CategoryEvent.deleteCategory(
                                                      (selectedCategory),
                                                    ),
                                                  );
                                                  selectedCategory = [];
                                                }
                                              }
                                              : null,
                                      icon: Icon(
                                        Icons.delete_rounded,
                                        size: 24.sp,
                                        color:
                                            (selectedCategory != null &&
                                                    (selectedCategory
                                                            ?.isNotEmpty ??
                                                        false))
                                                ? Theme.of(
                                                  context,
                                                ).colorScheme.onPrimaryContainer
                                                : Theme.of(
                                                  context,
                                                ).disabledColor,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      canSelectCategory = false;
                                      selectedCategory = [];
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close_rounded,
                                    size: 24.sp,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ).asGlass(
                            clipBorderRadius: BorderRadius.circular(8.r),
                            frosted: true,
                            tintColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 12.w,
                          top: 20.h,
                        ),
                        child: Text(
                          "${LocaleKeys.pages_category_title.tr()}:",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            return state.when(
                              initial:
                                  () => const Center(child: Text("Initial")),
                              loading:
                                  () => Center(
                                    child: SizedBox(
                                      width: 50.w,
                                      height: 50.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                              loaded:
                                  (categories) => AnimatedSwitcher(
                                    duration: Duration(milliseconds: 600),
                                    switchInCurve: Curves.decelerate,
                                    child: GridView.builder(
                                      key: ValueKey(categories?.length),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 12.h,
                                      ),
                                      itemCount: categories?.length ?? 0,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisExtent: 180.h,
                                            crossAxisSpacing: 20.w,
                                            mainAxisSpacing: 20.h,
                                            childAspectRatio: 1,
                                          ),
                                      itemBuilder: (context, index) {
                                        getedCategories = categories;
                                        final CategoryEntity? category =
                                            categories?[index];
                                        return CategoryWidget(
                                          onTap:
                                              () => context.go(
                                                RoutesPath.categoryPage,
                                                extra: category,
                                              ),
                                          category: category,
                                          canSelectCategory: canSelectCategory,
                                          onCategorySelected:
                                              (value) => setState(() {
                                                selectedCategory = value;
                                              }),
                                        );
                                      },
                                    ),
                                  ),
                              error:
                                  (message) => Center(
                                    child: Text(
                                      "Error: $message",
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                    ),
                                  ),
                              added:
                                  () => const Center(
                                    child: Text("Category added"),
                                  ),
                              deleted:
                                  () => const Center(
                                    child: Text("Category deleted"),
                                  ),
                              empty:
                                  () => Center(
                                    child: Text(
                                      LocaleKeys
                                          .pages_category_noCategoriesFound
                                          .tr(),
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                    ),
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositionedDirectional(
                  duration: const Duration(milliseconds: 300),
                  start: 0,
                  end: 0,
                  bottom: addCategoryContainerPosition,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        addCategoryContainerPosition -= details.delta.dy;
                        if (addCategoryContainerPosition > 0) {
                          addCategoryContainerPosition = 0;
                        } else if (addCategoryContainerPosition < -620.h) {
                          addCategoryContainerPosition = -620.h;
                        }
                      });
                    },
                    onVerticalDragEnd: (details) {
                      setState(() {
                        if (addCategoryContainerPosition > -250.h) {
                          addCategoryContainerPosition = 0;
                        } else {
                          addCategoryContainerPosition = -620.h;
                          isAddCategoryContainerShowed = false;
                        }
                      });
                    },
                    child: AddCategoryContainer(
                      onContainerClose: (value) {
                        if (value == true) {
                          setState(() {
                            isAddCategoryContainerShowed = false;
                            setAddCategoryContainerPosition();
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
