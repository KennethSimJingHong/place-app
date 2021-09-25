import 'package:flutter/material.dart';
import 'package:place_app/constant.dart';
import 'package:place_app/models/place.dart';
import 'package:place_app/providers/places.dart';
import 'package:place_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  static const routeName = "/placedetail";

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<Places>(context, listen:false).findById(id);
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(children: [
          Stack(
            children:[
              Container(
                width: double.infinity,
                child: Image.file(selectedPlace.image, width: double.infinity, fit: BoxFit.cover,height: 250,)
              ),
              Positioned(
                top: 40,
                left:20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      icon:Icon(Icons.arrow_back,),
                      padding: EdgeInsets.all(6), 
                      onPressed: (){Navigator.of(context).pop();},
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 40,
                right:20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.all(6),
                      icon: selectedPlace.isFavourite == false ? Icon(Icons.favorite_border) : Icon(Icons.favorite, color:Colors.pink[300]), 
                      onPressed: (){
                        setState(() {
                          Provider.of<Places>(context, listen: false).changeFavor(selectedPlace.id, !selectedPlace.isFavourite);
                        });
                        },
                    ),
                  ),
                ),
              ),
            ]
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                SizedBox(height:10),
                Text(selectedPlace.title, style: TextStyle(fontFamily: "PatuaOne", fontSize: 30, color: kGreenHighColor),),
                SizedBox(height:10),
                Text(selectedPlace.location.address, style: TextStyle(fontFamily: "PatuaOne", fontWeight: FontWeight.w400, color: Colors.black54),),
                SizedBox(height:30),
                Text(selectedPlace.description, textAlign: TextAlign.justify, style: TextStyle(fontFamily: "PatuaOne", fontSize: 14, fontWeight: FontWeight.w200),),
              ]
            ),
          ),
          ],),
          

          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: kGreenHighColor,
            icon:Icon(Icons.map, color: Colors.white,),
            label: Text("View on Map", style: TextStyle(color: Colors.white),),
            onPressed:(){
              Location locationData = Location(latitude: selectedPlace.location.latitude, longitude: selectedPlace.location.longitude, address:selectedPlace.location.address);
            Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx)=>MapScreen(initialLocation:locationData, isSelecting:false))); 
          },
          ),
        ],
      ),
    );
  }
}