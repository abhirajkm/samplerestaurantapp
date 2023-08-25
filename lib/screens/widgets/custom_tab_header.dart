import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/view.dart';

import '../../models/table_menu_list.dart';
import '../../utils/theme.dart';



class TabSingleHeader extends StatelessWidget {
  final bool isEnable;
  final String tabTitle, count;

  const TabSingleHeader({super.key,
    this.isEnable = false,
    this.tabTitle = "",
    this.count = "",
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Tab(
          text: tabTitle,

        ),
      ),
    );
  }
}

class CustomTabHeader extends StatefulWidget {
  final List<TableMenuList> menuList;
  final bool selectedIndex;
  const CustomTabHeader({
    Key? key,
    required TabController? nestedTabController, required this.menuList, required this.selectedIndex,
  })  : _nestedTabController = nestedTabController,
        super(key: key);

  final TabController? _nestedTabController;

  @override
  State<CustomTabHeader> createState() => _CustomTabHeaderState();
}

class _CustomTabHeaderState extends State<CustomTabHeader> {
  @override
  Widget build(BuildContext context) {



    return SizedBox(
      // height: 40,
      width: fullWidth(context),
      child: TabBar(
        labelPadding: const EdgeInsets.all(0),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: soldColor),
          ),
          color: white,
        ),
        controller: widget._nestedTabController,

        labelColor: widget.selectedIndex?soldColor:black,
        unselectedLabelColor: black,
        // labelStyle: tabLabelStyle,
        isScrollable: true,
        tabs:/*[
          ...List.generate(widget.menuList.length, (index) => TabSingleHeader(tabTitle: widget.menuList[index].menuCategory!,isSelected: selectedIndex==index,))
        ]*/
        widget.menuList.map((e) =>TabSingleHeader(tabTitle: e.menuCategory!, )).toList()
        ,
      ),
    );
  }
}