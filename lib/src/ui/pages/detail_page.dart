import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/services/horoscope_service.dart';
import 'package:horoscope_app/src/ui/widgets/loading_widget.dart';
import 'package:horoscope_app/src/ui/widgets/no-data_widget.dart';
import 'package:horoscope_app/src/utility/constants.dart';
import 'package:horoscope_app/src/utility/nav.dart';

class _SliverLogoPersistentHeader extends SliverPersistentHeaderDelegate {
  final SizedBox container;

  _SliverLogoPersistentHeader(this.container);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Colors.white,
      );

  @override
  double get maxExtent => container.height;

  @override
  double get minExtent => container.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class DetailPage extends StatefulWidget {
  final Zodiac zodiac;

  DetailPage({this.zodiac});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  Zodiac _zodiac;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    var _personZodiac = Zodiac.zodiacList[0];
    Zodiac.zodiacList.forEach((element) {
      if (element.name == AppData().getStarName()) _personZodiac = element;
    });
    _zodiac = widget.zodiac ?? _personZodiac;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        elevation: 1.0,
        child: ListView(
          children: [
            SizedBox(height: 10),
            ListTile(
              title: Text('Change Horoscope'),
              leading: Icon(Icons.track_changes),
              onTap: () async {
                Navigator.of(context).pop();
                final _result = await AppNavigation.toPage(
                  context,
                  AppPage.menuPage,
                );
                if (_result != null) {
                  _zodiac = _result;
                  setState(() {});
                }
              },
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text('Ad will go here'),
              ),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        elevation: 1.0,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
              ),
              color: kPrimaryColor,
            ),
            ListTile(
              title: Text('Ads Free Version'),
              leading: Icon(CupertinoIcons.creditcard_fill),
              onTap: () {},
            ),
            ListTile(
              title: Text('Sign In'),
              leading: Icon(CupertinoIcons.person_solid),
              onTap: () {},
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text('Ad will go here'),
              ),
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                  width: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (ctx, b) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: TextButton(
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(
                    CupertinoIcons.text_justify,
                    color: kPrimaryColor,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                    child: Icon(
                      CupertinoIcons.star,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              SliverPersistentHeader(
                delegate: _SliverLogoPersistentHeader(
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Image.asset(
                            _zodiac.imageName,
                            color: kPrimaryColor,
                          ),
                          Text(
                            _zodiac.name,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: 120,
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign: ${_zodiac.sign}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Planet: ${_zodiac.planet}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Element: ${_zodiac.element}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor,
                    ),
                    isScrollable: true,
                    indicatorColor: kPrimaryColor,
                    labelColor: kPrimaryColor,
                    unselectedLabelColor: Colors.grey.shade500,
                    tabs: [
                      SizedBox(
                        width: 100,
                        child: Tab(text: 'Daily'),
                      ),
                      SizedBox(
                        width: 100,
                        child: Tab(text: 'Weekly'),
                      ),
                      SizedBox(
                        width: 100,
                        child: Tab(text: 'Monthly'),
                      ),
                      SizedBox(
                        width: 100,
                        child: Tab(text: 'Yearly'),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _DailyDetail(name: _zodiac.name),
              _WeeklyDetail(name: _zodiac.name),
              _MonthlyDetail(name: _zodiac.name),
              _YearlyDetail(name: _zodiac.name),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyDetail extends StatefulWidget {
  final String name;

  _DailyDetail({this.name});

  @override
  __DailyDetailState createState() => __DailyDetailState();
}

class __DailyDetailState extends State<_DailyDetail> {
  var _dailyHoroscope = DailyHoroscope();

  Future<DailyHoroscope> _fetchDailyResult() async {
    return HoroscopeService.getDailyHoroscope(widget.name).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchDailyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _dailyHoroscope = data.data;
            if (_dailyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  // padding:
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _dailyHoroscope.detail,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                        softWrap: true,
                      ),
                      LikeDislikeWidget(),
                    ],
                  ),
                ),
              );
            }
          } else
            return LoadingWidget();
        }
      },
    );
  }
}

class _WeeklyDetail extends StatefulWidget {
  final String name;

  _WeeklyDetail({this.name});

  @override
  __WeeklyDetailState createState() => __WeeklyDetailState();
}

class __WeeklyDetailState extends State<_WeeklyDetail> {
  var _weeklyHoroscope = WeeklyHoroscope();

  Future<WeeklyHoroscope> _fetchWeeklyResult() async {
    return HoroscopeService.getWeeklyHoroscope(widget.name).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchWeeklyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _weeklyHoroscope = data.data;
            if (_weeklyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        _weeklyHoroscope.detail,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                        softWrap: true,
                      ),
                      LikeDislikeWidget(),
                    ],
                  ),
                ),
              );
            }
          } else
            return LoadingWidget();
        }
      },
    );
  }
}

class _MonthlyDetail extends StatefulWidget {
  final String name;

  _MonthlyDetail({this.name});

  @override
  __MonthlyDetailState createState() => __MonthlyDetailState();
}

class __MonthlyDetailState extends State<_MonthlyDetail> {
  var _monthlyHoroscope = MonthlyHoroscope();

  Future<MonthlyHoroscope> _fetchMonthlyResult() async {
    return HoroscopeService.getMonthlyHoroscope(widget.name).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchMonthlyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _monthlyHoroscope = data.data;
            if (_monthlyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        _monthlyHoroscope.detail,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                        softWrap: true,
                      ),
                      LikeDislikeWidget(),
                    ],
                  ),
                ),
              );
            }
          } else
            return LoadingWidget();
        }
      },
    );
  }
}

class _YearlyDetail extends StatefulWidget {
  final String name;

  _YearlyDetail({this.name});

  @override
  __YearlyDetailState createState() => __YearlyDetailState();
}

class __YearlyDetailState extends State<_YearlyDetail> {
  var _yearlyHoroscope = YearlyHoroscope();

  Future<YearlyHoroscope> _fetchYearlyResult() async {
    return HoroscopeService.getYearlyHoroscope(widget.name).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchYearlyResult(),
      builder: (ctx, data) {
        if (data.hasError)
          return NoDataWidget(message: 'Error');
        else {
          if (data.hasData) {
            _yearlyHoroscope = data.data;
            if (_yearlyHoroscope?.detail?.isEmpty ?? true)
              return NoDataWidget();
            else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        _yearlyHoroscope.detail,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                        softWrap: true,
                      ),
                      LikeDislikeWidget(),
                    ],
                  ),
                ),
              );
            }
          } else
            return LoadingWidget();
        }
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Colors.white,
        child: _tabBar,
      );

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

class LikeDislikeWidget extends StatefulWidget {
  @override
  _LikeDislikeWidgetState createState() => _LikeDislikeWidgetState();
}

class _LikeDislikeWidgetState extends State<LikeDislikeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: Icon(
              CupertinoIcons.hand_thumbsup,
              color: kPrimaryColor,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Icon(
              CupertinoIcons.hand_thumbsdown,
              color: kPrimaryColor,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
          ),
        ],
      ),
    );
  }
}
