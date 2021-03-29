// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   var _tabs = ["Home", "Profile", "MyAccount"];
//   TabController _tabBarController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabBarController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (ctx, b) {
//           return [
//             SliverToBoxAdapter(
//               child: Container(
//                 height: 400,
//                 child: Column(
//                   children: [
//                     FlutterLogo(),
//                     Text(
//                       'Sun',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                     Text(
//                       'Star',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverPersistentHeader(
//               delegate: _SliverAppBarDelegate(
//                 TabBar(
//                   controller: _tabBarController,
//                   labelStyle: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w400,
//                       color: Theme.of(context).backgroundColor),
//                   indicatorColor: Theme.of(context).hintColor,
//                   labelColor: Theme.of(context).buttonColor,
//                   unselectedLabelColor: Theme.of(context).dividerColor,
//                   tabs: [
//                     Tab(text: "Menu"),
//                     Tab(text: "About"),
//                     Tab(text: "Contact"),
//                   ],
//                 ),
//               ),
//               pinned: true,
//             ),
//           ];
//         },
//         body: TabBarView(
//           children: _tabs
//               .map(
//                 (e) => ListView.builder(
//                   itemBuilder: (ctx1, index) {
//                     return Text(
//                       index.toString(),
//                     );
//                   },
//                   itemCount: 200,
//                 ),
//               )
//               .toList(),
//           controller: _tabBarController,
//         ),
//       ),
//     );
//   }
// }
