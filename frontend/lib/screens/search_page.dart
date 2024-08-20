import 'package:frontend/app_properties.dart';
import 'package:frontend/models/article.dart';
import 'package:frontend/screens/product/components/product_display.dart';
import 'package:frontend/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';

class SearchPage extends StatefulWidget {
  final String? searchText;

  const SearchPage({Key? key, this.searchText}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";

  List<Article> articles = [
    Article(
        'assets/im1.jpg',
        '\‘I know why women don\’t walk out\’: domestic violence commissioner opens up',
        'Domestic violence commissioner Samantha Pace Gasan has spoken about how she experienced violent relationships in the past, in a bid to encourage other survivors. \nThe 30-year-old has encountered gender-based violence twice in her life. When she was a child, she witnessed violence towards someone close to her. She also experienced it as an adult when she was in an abusive relationship. “I always knew something was not right. I realised that this was not on,” she says. That was when she realised that her childhood memory and her relationship with her partner were abusive. \nShe decided to break up with her partner but soon realised she was pregnant. It crossed her mind to get back together with her partner for the child. “I was going to give him the chance. Which is why I understand why women find it hard to leave.\nShe took her life into her own hands and decided to follow her passion and start studying social policy. \nNot everyone has to share their story publicly and they should not feel pressured. But I want victims to know that I know what it feels like. \nA woman should never stay for the children - Samantha Pace Gasan. \n“I like to share my personal experiences because it sends a message of support,” she says.'),
    Article(
        'assets/im5.jpg',
        'Domestic violence crisis: Number of women allegedly killed in family violence incidents soars',
        'A spike in the number of women dying as a result of domestic violence in Australia has sparked urgent calls for action, including establishing a national list of offenders. \nWARNING: This story contains discussion of domestic and family violence. \nKey points: \n58 women have allegedly been killed this year across the country \nExperts say it\'s a national crisis \nThey want a national register of of family violence offenders \nSix women have been killed across Australia in 10 days — five allegedly by violence inflicted upon them by men. \nOne of the most prominent cases was the murder of 21-year-old sports coach Lilie James, whose body was found at her workplace, a high school in central Sydney. \nHer colleague and former boyfriend Paul Thijssen\'s body was found on Friday.'),
    Article(
        'assets/im12.jpg',
        'More women turning to firearms for self-defense to even the scales: Protecting \'the lives we love\'',
        'It\'s no secret. Across America, crime continues to ravage communities, putting the innocent on high alert as they wonder how they might fend off attackers should they make their move. \nBut some women are stepping up to the challenge, fueling the demographic\'s identity as a growing group arming up with guns across the nation, \n"Women are the fastest-growing group of gun owners in America," Jane Milhans, a firearms instructor in Washington State, told FOX News earlier this year. \nThe claim is backed by data from Gallup showing the percentage of women who reported owning a gun rising from 15% in 2016 to 22% in 2022, the highest percentage since the organization began gathering data on the subject approximately 15 years ago.'),
  ];

  List<String> timeFilter = [
    'Recent Incidents',
    'Safety Tips',
    'Emergency Contacts',
    'Self-defense Techniques',
    'Community Support',
  ];

  List<String> categoryFilter = [
    'Domestic Violence',
    'Street Harassment',
    'Online Safety',
    'Health & Wellness',
    'Legal Rights',
  ];

  List<String> priceFilter = [
    'Free Resources',
    'Low-cost Solutions',
    'Community Support',
    'Government Programs',
  ];

  List<Article> searchResults = [];

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));

    searchController = TextEditingController(text: widget.searchText);
    if (widget.searchText != null && widget.searchText!.isNotEmpty) {
      _performSearch(widget.searchText!);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.orange, width: 1),
              ),
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  List<Article> tempList = [];
                  articles.forEach((article) {
                    if (article.title.toLowerCase().contains(value)) {
                      tempList.add(article);
                    }
                  });
                  setState(() {
                    searchResults.clear();
                    searchResults.addAll(tempList);
                  });
                  return;
                } else {
                  setState(() {
                    searchResults.clear();
                    searchResults.addAll(articles);
                  });
                }
              },
              cursorColor: darkGrey,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
                suffix: TextButton(
                  onPressed: () {
                    searchController.clear();
                    searchResults.clear();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange[50],
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductPage(
                          product: searchResults[index],
                        ),
                      ),
                    ),
                    title: Text(searchResults[index].title),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          color: Colors.amber),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
//          controller: _scrollController,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPeriod = timeFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedPeriod == timeFilter[index]
                          ? BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            )
                          : BoxDecoration(),
                      child: Text(
                        timeFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: timeFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = categoryFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedCategory == categoryFilter[index]
                          ? BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            )
                          : BoxDecoration(),
                      child: Text(
                        categoryFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: categoryFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPrice = priceFilter[index];
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      decoration: selectedPrice == priceFilter[index]
                          ? BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                            )
                          : BoxDecoration(),
                      child: Text(
                        priceFilter[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch(String searchText) {
    if (searchText.isNotEmpty) {
      List<Article> tempList = [];
      articles.forEach((article) {
        if (article.title.toLowerCase().contains(searchText.toLowerCase())) {
          tempList.add(article);
        }
      });
      setState(() {
        searchResults.clear();
        searchResults.addAll(tempList);
      });
    } else {
      setState(() {
        searchResults.clear();
        searchResults.addAll(articles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
//          bottomSheet: ClipRRect(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//            child: BottomSheet(
//                onClosing: () {},
//                builder: (_) => Container(
//                      padding: EdgeInsets.all(16.0),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[Text('Filters')]),
//                      color: Colors.deepPurpleAccent,
//                      width: MediaQuery.of(context).size.height,
//                    )),
//          ),
            body: RubberBottomSheet(
          lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
          animationController: _controller, // The one we created earlier
        )),
      ),
    );
  }
}
