import 'dart:io';

import 'package:flutter/material.dart';

class Location{
  final double latitude;
  final double longitude;
  final String address;

  const Location({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

}

class Place{
  final String id;
  final String title;
  final String description;
  final Location location;
  final File image;
  bool isFavourite;
  
  Place({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.location,
    @required this.image,
    @required this.isFavourite,
  });
}