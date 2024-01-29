import 'package:flutter/material.dart';
import 'package:test_navbar/common/colors.dart' as colors;
import 'package:test_navbar/models/featured_model.dart';
import 'package:test_navbar/models/personal_event_model.dart';
import 'package:test_navbar/common/strings.dart' as strings;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FeaturedModel> featured = [];
  List<PersonalModel> personal = [];
  List<PersonalModel> favorites = []; 

  @override
  void initState() {
    super.initState();
    featured = FeaturedModel.getFeatured();
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
            searchBar(),
            const SizedBox(height: 25),
            featuredEvents(),
            const SizedBox(height: 25),
            myEvents(context),
          ],
        ),
      ),
    );
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

  Column featuredEvents() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Featured',
                style: TextStyle(
                    color: colors.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //was container replaced with sizebox
            SizedBox(
              height: 150,
              child: ListView.separated(
                //specify the number of items
                itemCount: featured.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
                //create space between the items
                separatorBuilder: (context, index) => const SizedBox(
                  width: 25,
                ),
                //build the items
                itemBuilder: (context, index) {
                  return Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: featured[index].color.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            featured[index].name,
                            style: const TextStyle(
                                color: colors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${featured[index].daysLeft} days left',
                            style: const TextStyle(
                              color: colors.primaryColor,
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container searchBar() {
    return Container(
      //setting up the margin for the search bar
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        
        //styling the search bar
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            //sets padding for the content inside the search bar
            contentPadding: const EdgeInsets.all(15),
            hintText: strings.searchBarPlaceholder,
            //prefixIcon for the search icon
            prefixIcon: const Icon(Icons.search, color: colors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
