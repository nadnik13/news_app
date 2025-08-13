import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main/bloc/filters_bloc.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: SearchBar(
        controller: _searchController,
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        // убирает M3-тон
        elevation: WidgetStateProperty.all(0),
        // убирает тень
        leading: Image.asset('assets/search.png', height: 32, width: 32),
        onChanged: (value) {
          context.read<FiltersBloc>().add(SearchQueryChanged(value));
        },
      ),
    );
  }
}
