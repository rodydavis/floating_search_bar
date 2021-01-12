import 'package:flutter/material.dart';

import 'ui/sliver_search_bar.dart';
export 'ui/sliver_search_bar.dart';

class FloatingSearchBar extends StatelessWidget {
  FloatingSearchBar({
    this.body,
    this.drawer,
    this.trailing,
    this.leading,
    this.endDrawer,
    this.controller,
    this.onChanged,
    this.title,
    this.decoration,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.pinned = false,
    required List<Widget> children,
  }) : _childDelagate = SliverChildListDelegate(
          children,
        );

  FloatingSearchBar.builder({
    this.body,
    this.drawer,
    this.endDrawer,
    this.trailing,
    this.leading,
    this.controller,
    this.onChanged,
    this.title,
    this.onTap,
    this.decoration,
    this.padding = EdgeInsets.zero,
    this.pinned = false,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
  }) : _childDelagate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  final Widget? leading, trailing, body, drawer, endDrawer;

  final SliverChildDelegate _childDelagate;

  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;

  final InputDecoration? decoration;

  final VoidCallback? onTap;

  /// Override the search field
  final Widget? title;

  final bool pinned;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      endDrawer: endDrawer,
      body: NestedScrollView(
        headerSliverBuilder: (context, enabled) {
          return [
            SliverPadding(
              padding: padding,
              sliver: SliverFloatingBar(
                leading: leading,
                floating: !pinned,
                pinned: pinned,
                title: title ??
                    TextField(
                      controller: controller,
                      decoration: decoration ??
                          InputDecoration.collapsed(
                            hintText: "Search...",
                          ),
                      autofocus: false,
                      onChanged: onChanged,
                      onTap: onTap,
                    ),
                trailing: trailing,
              ),
            ),
          ];
        },
        body: ListView.custom(childrenDelegate: _childDelagate),
      ),
    );
  }
}
