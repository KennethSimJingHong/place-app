import 'package:flutter/material.dart';
import 'package:place_app/providers/places.dart';
import 'package:place_app/screens/add_place_screen.dart';
import 'package:place_app/screens/place_detail_screen.dart';
import 'package:place_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value:Places(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlacesListScreen(),
        routes:{
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
