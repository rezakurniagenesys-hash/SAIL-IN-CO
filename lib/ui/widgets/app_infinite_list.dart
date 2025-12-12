import 'package:flutter/material.dart';
import 'package:sail_in_co/l10n/app_localizations.dart';

class AppInfinityList extends StatelessWidget {
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

  /// NEW PARAMS
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
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final ScrollController scrollCtrl = controller ?? ScrollController();

    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent - 200) {
        onLoadMore();
      }
    });

    // INITIAL LOADING
    if (isLoading) {
      return loadingWidget ??
          const Center(
            child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
          );
    }

    // SEARCH NO DATA
    if (items.isEmpty && isSearchActive) {
      return emptyWidget ?? Center(child: Text(l!.emptyState_dataNotFound));
    }

    // EMPTY LIST
    if (items.isEmpty) {
      return emptyWidget ?? Center(child: Text(l!.emptyState_noData));
    }

    // LIST VIEW
    return ListView.builder(
      controller: scrollCtrl,
      padding: padding ?? EdgeInsets.zero,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length + (isLoadMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return itemBuilder(context, index);
        }
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
