import 'package:flutter/material.dart';

class LazyLoadingListviewBuilder extends StatefulWidget {
  const LazyLoadingListviewBuilder({
    super.key,
    required this.slivers,
    required this.loadMore,
  });

  final List<Widget> slivers;
  final VoidCallback loadMore;

  @override
  State<LazyLoadingListviewBuilder> createState() =>
      _LazyLoadingListviewBuilderState();
}

class _LazyLoadingListviewBuilderState
    extends State<LazyLoadingListviewBuilder> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      CustomScrollView(controller: _scrollController, slivers: widget.slivers);

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      widget.loadMore();
    }
  }
}
