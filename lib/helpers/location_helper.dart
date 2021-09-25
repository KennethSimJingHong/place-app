import 'package:geocoder/geocoder.dart';


final MAP_API_KEY = "pk.eyJ1Ijoia2VubmV0aGRkaiIsImEiOiJja2d4cWY5NWIwOXlmMnNscTQ4bGZvanI5In0.3ErDJow1rT3IskyBYTTp9g";

class LocationHelper{
  static String genertaePreviewImageUrl({double lat, double lng}){
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($lng,$lat)/$lng,$lat,14.25,0,0/600x300?access_token=$MAP_API_KEY';   
  }

  static Future<String> getPlaceAddress(double lat, double lng) async{
    final coordinates = new Coordinates(lat, lng);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first.addressLine;
  }
}