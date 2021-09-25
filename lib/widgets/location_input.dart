import 'package:flutter/material.dart';
import 'package:location/location.dart' as locat;
import 'package:place_app/helpers/location_helper.dart';
import 'package:latlong/latlong.dart';
import 'package:place_app/models/place.dart';
import 'package:place_app/screens/map_screen.dart';
import '../constant.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _locationImg;

  void _showPreview(double lat, double lng){
    final staticMapImageUrl = LocationHelper.genertaePreviewImageUrl(
      lat:lat,
      lng:lng,
    );
    setState(() {
      _locationImg = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async{
    try{
      final locData = await locat.Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    }catch(e){
      return;
    }
  }

  Future<void> _selectOnMap() async{
    final locData = await locat.Location().getLocation();
    Location locationData = Location(latitude: locData.latitude, longitude: locData.longitude);
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx) => MapScreen(initialLocation:locationData,isSelecting: true,)));
    if(selectedLocation == null){
      return;
    }
    _showPreview(selectedLocation.latitude,selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width:double.infinity,
          height:200,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _locationImg != null ? Image.network(_locationImg, fit:BoxFit.cover, width: double.infinity) : Text( "No Location Shown", textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(width:10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                color: kGreenHighColor,
                icon: Icon(Icons.location_on, color: Colors.white,),
                onPressed: _getCurrentLocation, 
                label: Text("Current Location", style: TextStyle(color: Colors.white),),
              ),
            ),
            Expanded(
              child: OutlineButton.icon(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20))),
                color: kBlueLowColor,
                icon: Icon(Icons.map, color: kGreenHighColor,),
                onPressed: _selectOnMap, 
                label: Text("Select On Map", style: TextStyle(color: kGreenHighColor),),
              ),
            ),
          ],
        ),
      ],
    );
  }
}