import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/ui/pages/payment_page.dart';
import 'package:horoscope_app/src/ui/pages/sign-in_page.dart';
import 'package:horoscope_app/src/ui/views/daily_view.dart';
import 'package:horoscope_app/src/ui/views/monthly_view.dart';
import 'package:horoscope_app/src/ui/views/weekly_view.dart';
import 'package:horoscope_app/src/ui/views/yearly_view.dart';
import 'package:horoscope_app/src/ui/widgets/like-dislike_widget.dart';
import 'package:horoscope_app/src/utility/assets.dart';
import 'package:horoscope_app/src/utility/constants.dart';
import 'package:horoscope_app/src/utility/nav.dart';
import 'package:url_launcher/url_launcher.dart';

class _SliverLogoPersistentHeader extends SliverPersistentHeaderDelegate {
  final Container container;
  final double height;

  _SliverLogoPersistentHeader(this.container, this.height);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      container;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

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

  _launchURL(String url) async => await canLaunch(url)
      ? await launch(url)
      : ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch'),
          ),
        );

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
            if (!AppData().getHasPayed())
              InkWell(
                child: Image.asset(AppAssets.banner2),
                onTap: () {
                  Navigator.of(context).pop();
                  _launchURL('http://bit.ly/3uqgUurB2');
                },
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
              onTap: () {
                Navigator.of(context).pop();
                AppNavigation.to(
                  context,
                  PaymentPage(
                    callBack: () => setState(() {}),
                  ),
                );
              },
            ),
            // if (!AppData().getSignIn())
            ListTile(
              title: Text('Sign In'),
              leading: Icon(CupertinoIcons.person_solid),
              onTap: () {
                Navigator.of(context).pop();
                AppNavigation.to(
                  context,
                  SignInPage(
                    callBack: () => setState(() {}),
                  ),
                );
              },
            ),
            if (!AppData().getHasPayed())
              InkWell(
                child: Image.asset(AppAssets.banner3),
                onTap: () {
                  Navigator.of(context).pop();
                  _launchURL('http://bit.ly/2R6GrufB1');
                },
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
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          _zodiac.imageName,
                          // color: kPrimaryColor,
                          // width: 250,
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Center(
                            child: Text(
                              _zodiac.name.capitalize(),
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MediaQuery.of(context).size.height / 2.5,
                ),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: 120,
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign: ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          Text(
                            'Planet: ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          Text(
                            'Element: ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            _zodiac.sign,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.5),
                            child: Text(
                              _zodiac.planet,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            _zodiac.element,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
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
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DailyDetailView(name: _zodiac.name),
                    WeeklyDetailView(name: _zodiac.name),
                    MonthlyDetailView(name: _zodiac.name),
                    YearlyDetailView(name: _zodiac.name),
                  ],
                ),
              ),
              LikeDislikeWidget(),
            ],
          ),
        ),
      ),
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
