class PersonalModel {
  String name;
  // stream is used to update the time left every second
  Stream<String> countDown;
  String imagePath;
  bool isFavorite;

  PersonalModel({
    required this.name,
    required this.countDown,
    required this.imagePath,
    required this.isFavorite,
  });

  //function to calculate the time left for the event in days, hours, minutes and seconds
  static Stream<String> calculateTimeLeft(DateTime targetDate) async* {
    while (true) {
      DateTime now = DateTime.now();
      Duration difference = targetDate.difference(now);

      // padLeft() is used to add a 0 in front of the number if it is less than 10
      String days = difference.inDays.toString().padLeft(2, '0');
      String hours = (difference.inHours % 24).toString().padLeft(2, '0');
      String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
      String seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

      //yield is used to return the value of the time left
      yield '$days : $hours : $minutes : $seconds';

      // wait for 1 second before updating the time left
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static List<PersonalModel> getPersonal() {
    List<PersonalModel> personal = [];

    //calculate the time left for Christmas
    DateTime christmasDate = DateTime(DateTime.now().year, 12, 25);
    Stream<String> christmasCountdown = calculateTimeLeft(christmasDate);

    personal.add(PersonalModel(
      name: 'Christmas',
      countDown: christmasCountdown,
      imagePath: 'lib/assets/images/christmas.jpg',
      isFavorite: true,
    ));


    //calculate the time left for Summer
    DateTime summerDate = DateTime(DateTime.now().year, 6, 21);
    Stream<String> summerCountdown = calculateTimeLeft(summerDate);

    personal.add(PersonalModel(
      name: 'Summer',
      countDown: summerCountdown,
      imagePath: 'lib/assets/images/summer.jpg',
      isFavorite: true,
    ));


    //calculate the time left for April Fool's Day
    DateTime aprilfoolsDate = DateTime(DateTime.now().year, 4, 1);
    Stream<String> aprilfoolsCountdown = calculateTimeLeft(aprilfoolsDate);

    personal.add(PersonalModel(
      name: 'April Fools Day',
      countDown: aprilfoolsCountdown,
      imagePath: 'lib/assets/images/aprilfools.jpg',
      isFavorite: true,
    ));

    //calculate the time left for Valentines Day
    DateTime valentinesDate = DateTime(DateTime.now().year, 2, 14);
    Stream<String> valentinesCountdown = calculateTimeLeft(valentinesDate);

    personal.add(PersonalModel(
      name: 'Valentines Day',
      countDown: valentinesCountdown,
      imagePath: 'lib/assets/images/valentines.jpg',
      isFavorite: true,
    ));

    // return the list of events
    return personal;
  }
}
