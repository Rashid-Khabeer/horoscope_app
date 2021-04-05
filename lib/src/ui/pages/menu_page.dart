import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/models/horoscope-detail_model.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8),
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
            Image.asset(
              zodiac.imageName,
              width: 50,
            ),
            Text(
              zodiac.name.capitalize(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                child: Text(
                  zodiac.dateRange,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
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
