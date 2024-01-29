import 'package:flutter/material.dart';

class FeaturedModel {
  String name;
  String icon;
  String daysLeft;
  Color color;

  //constructor for the class
  FeaturedModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.daysLeft,
  });

  static calculateDaysLeft(DateTime targetDate) {
    DateTime now = DateTime.now();
    Duration difference = targetDate.difference(now);

    int days = difference.inDays;

    return days;
  }

  //we make the method static in order to access it in the home.dart file
  static List<FeaturedModel> getFeatured() {
    //creating a list and returning the list
    List<FeaturedModel> featured = [];

    //calculate the time left for Christmas
    DateTime christmasDate = DateTime(DateTime.now().year, 12, 25);
    int christmasDaysLeft = calculateDaysLeft(christmasDate);

    featured.add(
      FeaturedModel(
        name: 'Christmas',
        icon: 'Icons.settings',
        color: Colors.red,
        daysLeft: '$christmasDaysLeft',
      )
    );

    DateTime summerDate = DateTime(DateTime.now().year, 6, 21);
    int summerDaysLeft = calculateDaysLeft(summerDate);

    featured.add(
      FeaturedModel(
        name: 'Summer',
        icon: 'Icons.settings',
        color: Colors.blue,
        daysLeft: '$summerDaysLeft',
      )
    );

    DateTime aprilfoolsDate = DateTime(DateTime.now().year, 4, 1);
    int aprilfoolsDaysLeft = calculateDaysLeft(aprilfoolsDate);
    featured.add(
      FeaturedModel(
        name: 'April Fools Day',
        icon: 'Icons.settings',
        color: Colors.green,
        daysLeft: '$aprilfoolsDaysLeft',
      )
    );

    DateTime valentinesDate = DateTime(DateTime.now().year, 2, 14);
    int valentinesDaysLeft = calculateDaysLeft(valentinesDate);

    featured.add(
      FeaturedModel(
        name: 'Valentines Day',
        icon: 'Icons.settings',
        color: Colors.pink,
        daysLeft: '$valentinesDaysLeft',
      )
    );

    DateTime newyearDate = DateTime(DateTime.now().year, 12, 31);
    int newYearDaysLeft = calculateDaysLeft(newyearDate);

    featured.add(
      FeaturedModel(
        name: 'New Year',
        icon: 'Icons.settings',
        color: Colors.purple,
        daysLeft: '$newYearDaysLeft',
      )
    );

    DateTime easterDate = DateTime(DateTime.now().year, 03, 31);
    int easterDaysleft = calculateDaysLeft(easterDate);

    featured.add(
      FeaturedModel(
        name: 'Easter',
        icon: 'Icons.settings',
        color: Colors.orange,
        daysLeft: '$easterDaysleft',
      )
    );

    

    return featured;
  }
}