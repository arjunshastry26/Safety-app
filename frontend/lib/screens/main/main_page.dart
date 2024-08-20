import 'package:flutter/material.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';
import 'package:frontend/models/helpline.dart';
import 'package:frontend/screens/articles/articles_page.dart';
import 'package:frontend/screens/sos_page.dart';
import 'package:frontend/screens/profile_page.dart';
import 'package:frontend/screens/search_page.dart';
import 'components/custom_bottom_bar.dart';
import 'components/helpline_list.dart';
import 'components/tab_view.dart';
import 'components/bookmarks_list.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<String> timelines = [''];
String selectedTimeline = '';

List<Helpline> helplines = [
  Helpline('assets/icons/helpline.png', 'Mahila Helpline', 'A', 1091),
  Helpline('assets/icons/police.png', 'Police', 'B', 100),
  Helpline('assets/icons/policewoman.png', 'National Commision for Women ', 'C',
      26944754),
  Helpline('assets/icons/phone-book.png', 'Emergency Contact', 'D', 1234567890),
  Helpline('assets/icons/fake_call.png', 'Fake Call', 'E', 0),
];

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late TabController tabController;
  late TabController bottomTabController;
  double sliderValue = 0.5;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            child: IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SOSPage())),
              icon: Image(image: AssetImage('assets/icons/emergency.png')),
            ),
          ),
          Text(
            "Voyage",
            style: TextStyle(fontSize: 25.0),
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SearchPage())),
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        painter: MainBackground(),
        child: TabBarView(
          controller: bottomTabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: appBar,
                    ),
                    SliverToBoxAdapter(
                      child: HelplineList(
                        helplines: helplines,
                      ),
                    ),
                  ];
                },
                body: TabView(
                  tabController: tabController,
                ),
              ),
            ),
            ArticlesPage(),
            Column(),
            ProfilePage()
          ],
        ),
      ),
    );
  }
}

class IconSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const IconSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _IconSliderState createState() => _IconSliderState();
}

class _IconSliderState extends State<IconSlider> {
  double _dragPosition = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragPosition += details.primaryDelta! / 100;
          if (_dragPosition < 0) {
            _dragPosition = 0;
          } else if (_dragPosition > 1) {
            _dragPosition = 1;
          }
          widget.onChanged(_dragPosition);
        });
      },
      child: Container(
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: widget.value * 100,
              child: Icon(Icons.arrow_forward_ios),
            ),
            Slider(
              value: widget.value,
              onChanged: widget.onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
