import 'package:flutter/material.dart';

class Widgets {
  final decorationCard = BoxDecoration(
    gradient: LinearGradient(
      colors: <Color>[
        Colors.black26.withOpacity(0.2),
        Colors.white.withOpacity(0.5),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  bottomNavigationBarItem(String label, String urlImage) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        "assets/icons/$urlImage",
        height: 30.0,
      ),
      label: label,
    );
  }

  gridView(dynamic jsonClass, Size size) {
    return GridView.builder(
        itemCount: jsonClass.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: size.height * 0.29,
        ),
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
            color: Colors.yellow,
            child: Text(jsonClass[index].name.toString()),
          );
        }));
  }
}
