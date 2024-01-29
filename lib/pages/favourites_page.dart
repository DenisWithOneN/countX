import 'package:flutter/material.dart';
import 'package:test_navbar/models/personal_event_model.dart';
import 'package:test_navbar/common/colors.dart' as colors;

// ignore: must_be_immutable
class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<PersonalModel> personal = [];

    @override
  void initState() {
    super.initState();
    getInitialInfo();
  }

  void getInitialInfo() {
    personal = PersonalModel.getPersonal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              myEvents(context),
            ],
          ),
        ));
  }

  Column myEvents(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'My events',
              style: TextStyle(
                  color: colors.secondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: personal.map((item) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item.imagePath),
                            fit: BoxFit.cover,
                            opacity: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.name,
                                style: const TextStyle(
                                    color: colors.primaryColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                            StreamBuilder<String>(
                              stream: item.countDown,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                      color: colors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: colors.contrastColor,
                                backgroundColor: colors.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/favourites');
                              },
                              child: const Text('view'),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 30,
                      child: IconButton(
                        icon: Icon(
                          item.isFavorite ? Icons.star : Icons.star_border,
                          color: colors.contrastColor,
                          size: 50,
                        ),
                        onPressed: () {
                          setState(() {
                            item.isFavorite = !item.isFavorite;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}