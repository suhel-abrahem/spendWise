import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spend_wise/core/resource/main_page/main_page.dart';
import 'package:spend_wise/core/util/helper/helper.dart';
import 'package:spend_wise/features/categories/domain/entities/category_entity.dart';
import 'package:spend_wise/generated/locale_keys.g.dart';

class CategoryPage extends StatefulWidget {
  final CategoryEntity? categoryEntity;
  const CategoryPage({super.key, this.categoryEntity});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isCataegoryAvailable = false;
  @override
  void initState() {
    isCataegoryAvailable = widget.categoryEntity != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainPage(
      title:
          isCataegoryAvailable
              ? Helper.nameLanguageSelector(
                context: context,
                defaultLanguage: widget.categoryEntity?.defaultLanguage,
                names: widget.categoryEntity?.name,
              )
              : LocaleKeys.pages_pageNotFound.tr(),
      body:
          isCataegoryAvailable
              ? ListView()
              : Center(
                child: Text(
                  LocaleKeys.pages_pageNotFound.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
    );
  }
}
