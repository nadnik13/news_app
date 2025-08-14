import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/news_list/bloc/filters_bloc.dart';
import 'package:news_app/news_list/data/models/news_category.dart';

class CategoriesRowWidget extends StatelessWidget {
  const CategoriesRowWidget({super.key});

  bool isSelectedCategories(
    NewsCategory category,
    Set<NewsCategory> categories,
  ) {
    return categories.contains(category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      buildWhen: (prev, curr) => prev.selectedCategory != curr.selectedCategory,
      builder: (context, filtersState) {
        final TextStyle style = TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        );
        const EdgeInsets padding = EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        );

        // вычисляем ширину самой длинной категории с учетом локального масштабирования текста
        final l = AppLocalizations.of(context)!;
        final TextScaler scaler = MediaQuery.of(context).textScaler;
        double maxLabelWidth = 0;
        for (final cat in NewsCategory.values) {
          final tp = TextPainter(
            text: TextSpan(text: cat.title(l), style: style),
            textDirection: TextDirection.ltr,
            maxLines: 1,
            textScaler: scaler,
          )..layout();
          maxLabelWidth =
              maxLabelWidth < tp.size.width ? tp.size.width : maxLabelWidth;
        }
        final double itemWidth = maxLabelWidth + padding.horizontal;

        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 19),
            ...NewsCategory.values.map((e) {
              final isSelected = e == filtersState.selectedCategory;
              return SizedBox(
                width: itemWidth,
                child: InkWell(
                  onTap: () => context.read<FiltersBloc>().add(FilterTapped(e)),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    color: isSelected ? Colors.blueAccent : Colors.grey,
                    child: Center(child: Text(e.title(l), style: style)),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
