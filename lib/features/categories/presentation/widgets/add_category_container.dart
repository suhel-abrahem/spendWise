import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass/glass.dart';
import 'package:spend_wise/core/constants/language_constant.dart';
import 'package:spend_wise/core/dependencies_injection.dart';
import 'package:spend_wise/core/enums/categories_type/categories_type.dart';
import 'package:spend_wise/core/enums/position/position_enum.dart';
import 'package:spend_wise/core/resource/custom_widget/custom_input_field/custom_input_field.dart';
import 'package:spend_wise/core/resource/custom_widget/dropdown/drop_down_with_label.dart';
import 'package:spend_wise/core/util/helper/helper.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';
import 'package:spend_wise/features/categories/presentation/bloc/category_bloc.dart';

import '../../../../generated/locale_keys.g.dart';

class AddCategoryContainer extends StatefulWidget {
  final ValueChanged<bool?>? onContainerClose;
  const AddCategoryContainer({super.key, this.onContainerClose});

  @override
  State<AddCategoryContainer> createState() => _AddCategoryContainerState();
}

class _AddCategoryContainerState extends State<AddCategoryContainer> {
  List<String?>? categoryName = ["", "", ""];
  String? defaultLanguage = LanguageConstant.defaultLanguage;
  IconData? selectedCategoryIcon;
  String? selectedCategoryIconName;
  bool? isValid = false;
  Map<String, IconData> categoryIcon = {
    LocaleKeys.pages_category_billsAndUtilities: Icons.electric_bolt,
    LocaleKeys.pages_category_foodAndGroceries: Icons.fastfood,
    LocaleKeys.pages_category_healthAndFitness: Icons.health_and_safety,
    LocaleKeys.pages_category_investments: Icons.pie_chart,

    LocaleKeys.pages_category_shopping: Icons.shopping_cart,
    LocaleKeys.pages_category_transportation: Icons.directions_car,
    LocaleKeys.pages_category_travel: Icons.airplanemode_active,
    LocaleKeys.pages_category_education: Icons.school,
    LocaleKeys.pages_category_personalCare: Icons.person,
    LocaleKeys.pages_category_giftsAndDonations: Icons.card_giftcard,
    LocaleKeys.pages_category_homeAndGarden: Icons.home,
    LocaleKeys.pages_category_pets: Icons.pets,
    LocaleKeys.pages_category_hobbiesAndLeisure: Icons.sports,
    LocaleKeys.pages_category_insurance: Icons.security,
    LocaleKeys.pages_category_subscriptions: Icons.subscriptions,
    LocaleKeys.pages_category_taxes: Icons.account_balance,
    LocaleKeys.pages_category_income: Icons.monetization_on,
    LocaleKeys.pages_category_savings: Icons.savings,
    LocaleKeys.pages_category_otherz: Icons.more_horiz,
  };
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getItInstance<CategoryBloc>()..add(CategoryEvent.started()),
      child: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is Added) {
            widget.onContainerClose?.call(true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys.pages_category_categoryAdded.tr(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            );
          } else if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys.pages_category_errorOccurred.tr(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            );
          }
        },

        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return SizedBox(
              height: 620.h,
              width: double.maxFinite,

              child: Form(
                onChanged:
                    () => setState(() {
                      isValid = formKey.currentState?.validate() == true;
                    }),
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        width: 350.w,
                        child: DropDownWithLabel<String>(
                          items: LanguageConstant.supportedLanguages,
                          onChange:
                              (newLanguage) => setState(() {
                                defaultLanguage = newLanguage;
                              }),
                          stringConverter:
                              (stringConverter) =>
                                  stringConverter.toString() == "fa"
                                      ? "KR"
                                      : stringConverter
                                          .toString()
                                          .toUpperCase(),
                          dropDownWidth: 100.w,
                          dropDownHeight: 50.h,
                          isLoading: false,
                          value: defaultLanguage,
                          labelPosition: Position.beside,
                          label: LocaleKeys.pages_category_DefaultLanguage.tr(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: CustomInputField(
                          width: 300.w,
                          haveOuterLabel: true,
                          outerLabelPadding: EdgeInsets.only(bottom: 8.h),
                          outerLabel:
                              "${LocaleKeys.pages_category_categoryNameAr.tr()}:",
                          onChanged:
                              (value) => setState(() {
                                if (value.toString().trim().isNotEmpty) {
                                  categoryName?[0] = value;
                                }
                              }),

                          initialValue: categoryName?[0],
                          isRequired: defaultLanguage == LanguageConstant.ar,
                          validator: (p0) {
                            return (defaultLanguage == LanguageConstant.ar &&
                                    (p0 == null || p0.isEmpty))
                                ? LocaleKeys.pages_category_pleaseEnterName.tr()
                                : null;
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: CustomInputField(
                        width: 300.w,
                        haveOuterLabel: true,
                        outerLabelPadding: EdgeInsets.only(bottom: 8.h),
                        outerLabel:
                            "${LocaleKeys.pages_category_categoryNameEn.tr()}:",
                        onChanged:
                            (value) => setState(() {
                              if (value.toString().trim().isNotEmpty) {
                                categoryName?[1] = value;
                              }
                            }),
                        validator: (p0) {
                          return (defaultLanguage == LanguageConstant.en &&
                                  (p0 == null || p0.isEmpty))
                              ? LocaleKeys.pages_category_pleaseEnterName.tr()
                              : null;
                        },
                        initialValue: categoryName?[1],
                        isRequired: defaultLanguage == LanguageConstant.en,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: CustomInputField(
                          width: 300.w,
                          haveOuterLabel: true,
                          outerLabelPadding: EdgeInsets.only(bottom: 8.h),
                          outerLabel:
                              "${LocaleKeys.pages_category_categoryNameKr.tr()}:",
                          onChanged:
                              (value) => setState(() {
                                if (value.toString().trim().isNotEmpty) {
                                  categoryName?[2] = value;
                                }
                              }),

                          initialValue: categoryName?[2],
                          isRequired: defaultLanguage == LanguageConstant.fa,
                          validator: (p0) {
                            return (defaultLanguage == LanguageConstant.fa &&
                                    (p0 == null || p0.isEmpty))
                                ? LocaleKeys.pages_category_pleaseEnterName.tr()
                                : null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 20.w,
                      ),
                      child: Helper.labelText(
                        label:
                            "${LocaleKeys.pages_category_selectCategoryIcon.tr()}:",
                      ),
                    ),

                    FormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (selectedCategoryIcon == null) {
                          return LocaleKeys.pages_category_pleaseSelectIcon
                              .tr();
                        }
                        return null;
                      },
                      builder:
                          (state) => SizedBox(
                            height: 90.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: SizedBox(
                                    height: 60.h,
                                    child: ListView.builder(
                                      itemCount: categoryIcon.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                          ),
                                          child: AnimatedSwitcher(
                                            duration: Duration(
                                              milliseconds: 300,
                                            ),
                                            child: SizedBox(
                                              key: ValueKey(
                                                selectedCategoryIconName,
                                              ),
                                              width: 200.w,
                                              height: 60.h,
                                              child: ElevatedButton.icon(
                                                icon: Icon(
                                                  categoryIcon.values.elementAt(
                                                    index,
                                                  ),
                                                  size: 22.sp,
                                                  color:
                                                      Theme.of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.color,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    selectedCategoryIcon =
                                                        categoryIcon.values
                                                            .elementAt(index);
                                                    selectedCategoryIconName =
                                                        categoryIcon.keys
                                                            .elementAt(index);

                                                    selectedCategoryIconName
                                                            .toString()
                                                            .isNotEmpty
                                                        ? true
                                                        : false;
                                                  });
                                                  state.didChange(
                                                    selectedCategoryIcon,
                                                  );
                                                },
                                                label: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    categoryIcon.keys
                                                        .elementAt(index)
                                                        .tr(),
                                                    style:
                                                        Theme.of(
                                                          context,
                                                        ).textTheme.labelLarge,
                                                  ),
                                                ),
                                                style: Theme.of(
                                                  context,
                                                ).elevatedButtonTheme.style?.copyWith(
                                                  shape: WidgetStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30.r,
                                                          ),
                                                      side: BorderSide(
                                                        width:
                                                            selectedCategoryIconName ==
                                                                    categoryIcon
                                                                        .keys
                                                                        .elementAt(
                                                                          index,
                                                                        )
                                                                ? 4.w
                                                                : 2.w,
                                                        color:
                                                            selectedCategoryIconName ==
                                                                    categoryIcon
                                                                        .keys
                                                                        .elementAt(
                                                                          index,
                                                                        )
                                                                ? Theme.of(
                                                                  context,
                                                                ).focusColor
                                                                : Theme.of(
                                                                  context,
                                                                ).dividerColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                state.hasError
                                    ? Text(
                                      state.errorText ?? '',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                    )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 60.h,
                        width: 200.w,
                        child: ElevatedButton(
                          onPressed:
                              (isValid ?? false)
                                  ? () {
                                    final CategoryEntity categoryEntity =
                                        CategoryEntity(
                                          icon: selectedCategoryIcon,
                                          name: categoryName ?? ["", "", ""],
                                        );
                                    BlocProvider.of<CategoryBloc>(context).add(
                                      CategoryEvent.addCategory(categoryEntity),
                                    );
                                  }
                                  : null,
                          child: Text(
                            LocaleKeys.add.tr(),
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).textTheme.headlineLarge?.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).asGlass(
              blurX: 3,
              blurY: 3,
              frosted: true,
              tintColor: Theme.of(context).scaffoldBackgroundColor,
              firstOpacity: 0.6,
              secondOpacity: 0.46,
              clipBorderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(30.r),
              ),
            );
          },
        ),
      ),
    );
  }
}
