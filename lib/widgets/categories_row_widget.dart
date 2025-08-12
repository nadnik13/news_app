import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main/blocks/filters_blocks.dart';
import '../main/data/models/news_category.dart';

class CategoriesRowWidget extends StatelessWidget {

  bool isSelectedCategories(NewsCategory category,
      Set<NewsCategory> categories) {
    return categories.contains(category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      buildWhen:
          (prev, curr) => prev.selectedCategories != curr.selectedCategories,
      builder: (context, filtersState) {
        return SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
            NewsCategory.values
                .map(
                    (e) {
                  final bool isSelected = isSelectedCategories(
                      e, filtersState.selectedCategories);
                  return InkWell(
                      onTap: () {
                        isSelected ? context.read<FiltersBloc>().add(FilterRemoved(e))
                            : context.read<FiltersBloc>().add(FilterAdded(e));
                      },
                      child: Card
                        (
                        color: isSelected
                            ? Colors.blue
                            : Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(e.name, style: TextStyle(color: Colors.white),),
                      )
                      )));

                }


            )
                .toList(),
          ),
        );
      },
    );
  }
}
