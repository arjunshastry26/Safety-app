import 'package:frontend/models/category.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/articles/components/d_violence_list.dart';
import 'package:frontend/screens/articles/components/s_assault.dart';
import 'package:frontend/screens/articles/components/s_defense_list.dart';

import 'category_card.dart';
import 'recommended_list.dart';

class TabView extends StatelessWidget {
  final TabController tabController;

  TabView({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: DViolenceList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: SAssaultList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: SDefenseList())
          ]),
        ]);
  }
}
