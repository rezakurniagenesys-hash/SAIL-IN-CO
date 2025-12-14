import 'package:flutter/material.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class AppInfinityList extends StatefulWidget {
  final ScrollController? controller;
  final bool isSearchActive;
  final List items;
  final bool isLoading;
  final bool isLoadMore;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback onLoadMore;
  final EdgeInsetsGeometry? padding;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const AppInfinityList({
    super.key,
    this.controller,
    required this.items,
    required this.isLoading,
    required this.isLoadMore,
    required this.itemBuilder,
    required this.onLoadMore,
    this.isSearchActive = false,
    this.padding,
    this.emptyWidget,
    this.loadingWidget,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  State<AppInfinityList> createState() => _AppInfinityListState();
}

class _AppInfinityListState extends State<AppInfinityList> {
  late final ScrollController _scrollController;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isFetchingMore && widget.isLoadMore == false) {
        _isFetchingMore = true;
        widget.onLoadMore();
      }
    }
  }

  @override
  void didUpdateWidget(covariant AppInfinityList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoadMore && !widget.isLoadMore) {
      _isFetchingMore = false;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    if (widget.isLoading) {
      return widget.loadingWidget ??
          const Center(
            child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
          );
    }

    if (widget.items.isEmpty && widget.isSearchActive) {
      return widget.emptyWidget ?? Center(child: Text(l!.emptyState_dataNotFound));
    }

    if (widget.items.isEmpty) {
      return widget.emptyWidget ?? Center(child: Text(l!.emptyState_noData));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding ?? EdgeInsets.zero,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemCount: widget.items.length + (widget.isLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.items.length) {
          return widget.itemBuilder(context, index);
        }
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
