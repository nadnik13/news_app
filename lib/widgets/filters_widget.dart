import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/widgets/search_widget.dart';

import '../main/bloc/filters_bloc.dart';
import '../main/bloc/news_list_bloc.dart';
import 'categories_row_widget.dart';

class FiltersWidget extends StatelessWidget {
  const FiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FiltersBloc, FiltersState>(
      listener: (context, filtersState) {
        context.read<NewsListBloc>().add(
          NewsListWithFiltersRequested(
            searchQuery: filtersState.searchQuery,
            selectedCategories: filtersState.selectedCategories,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: SearchWidget()),
          Expanded(child: CategoriesRowWidget()),
        ],
      ),
    );
  }
}
