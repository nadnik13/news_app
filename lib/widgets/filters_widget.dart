import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/widgets/search_widget.dart';

import '../main/blocks/filters_blocks.dart';
import 'categories_row_widget.dart';

class FiltersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      buildWhen:
          (prev, curr) => prev.selectedCategories != curr.selectedCategories,
      builder: (context, filtersState) {
        return Column(children: [SearchWidget(), CategoriesRowWidget()]);
      },
    );
  }
}
