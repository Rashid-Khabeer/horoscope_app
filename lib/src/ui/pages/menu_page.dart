import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';
import 'package:horoscope_app/src/utility/constants.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Select zodiac sign'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 55),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: Zodiac.zodiacList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (ctx, index) => _TileWidget(
                zodiac: Zodiac.zodiacList[index],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              color: kPrimaryColor,
              child: Center(
                child: Text(
                  'Ad will go here',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TileWidget extends StatelessWidget {
  final Zodiac zodiac;

  _TileWidget({this.zodiac});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(zodiac);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(zodiac.imageName),
            Text(
              zodiac.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              zodiac.dateRange,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
