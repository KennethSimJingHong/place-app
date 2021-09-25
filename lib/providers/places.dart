import 'dart:io';

import 'package:flutter/material.dart';
import 'package:place_app/helpers/location_helper.dart';
import 'package:place_app/models/place.dart';

class Places with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  Future<void> addPlace(
    String pickedTitle,
    String desc,
    File pickedImage,
    Location pickedLocation,
  )async{
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = Location(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude, address:address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      description:desc,
      location: updateLocation,
      isFavourite: false,
    );
    _items.add(newPlace);
    notifyListeners();
  }

  void changeFavor(String id, bool isFavorValue){
    _items[_items.indexWhere((element) => element.id == id)].isFavourite = isFavorValue;
    notifyListeners();
  }

  List<Place> get getFav{
    final favorList =  _items.where((item) => item.isFavourite == true).toList();
    return favorList;
  }

  Place findById(String id){
    return _items.firstWhere((place) => place.id == id);
  }
}