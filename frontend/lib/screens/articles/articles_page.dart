import 'package:frontend/app_properties.dart';
import 'package:frontend/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/screens/search_page.dart';

import 'components/staggered_category_card.dart';
import 'components/tab_view.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage>
    with TickerProviderStateMixin<ArticlesPage> {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    // searchResults = categories;
  }

  List<Category> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF9F9F9),
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10.0),
                      child: Text(
                        'Articles',
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black12,
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/search_icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchPage(searchText: value),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  TabBar(
                    tabs: [
                      Tab(text: 'Recommended'),
                      Tab(text: 'Domestic Violence'),
                      Tab(text: 'Sexual Harrasment'),
                      Tab(text: 'Self Defense Tips'),
                    ],
                    labelStyle: TextStyle(fontSize: 16.0),
                    unselectedLabelStyle: TextStyle(fontSize: 14.0),
                    padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    labelColor: Colors.black,
                    unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
                    isScrollable: true,
                    controller: tabController,
                  ),
                ]),
              ),
            ];
          },
          body: TabView(
            tabController: tabController,
          ),
        ),
      ),
    );
  }
}
