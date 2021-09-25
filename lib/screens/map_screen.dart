import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:place_app/constant.dart';
import 'package:place_app/models/place.dart';
import 'package:place_app/providers/places.dart';
import 'package:place_app/widgets/navigation_map.dart';
import 'package:provider/provider.dart';


class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;
  final bool showAllPlace;
  MapScreen({this.initialLocation = const Location(latitude:51.5, longitude: -0.09),this.isSelecting = false, this.showAllPlace = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  void selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  Widget _builderContainer(List items){
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      margin: EdgeInsets.symmetric(vertical:10),
      height:140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: 
          items.map((item){
            return Column(
              children: [
                SizedBox(width:10),
                Padding(
                  padding:const EdgeInsets.all(8),
                  child: _boxes(item),
                )
              ],
            );
          }).toList(),
      ),
    ),
  );
}

Widget _boxes(Place item){

  Future<void> _gotoLocation(double lat,double long) async {
    setState(() {
       _mapController.move(LatLng(lat, long), 16.0);
    });
  }

  return GestureDetector(
    onTap: (){
      setState(() {
        _gotoLocation(item.location.latitude,item.location.longitude);
      });
      
    },
    child: Container(
      child: FittedBox(
        child: Material(
          color: Colors.white,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: FileImage(item.image),
                    ),
                  ),),
                  Container(
                  width:160,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(item.title, style: TextStyle(fontFamily: "PatuaOne", color: kGreenHighColor, fontSize: 22)),
                        Text(item.location.address, style: TextStyle(color: Colors.black54),overflow: TextOverflow.ellipsis, maxLines: 5,),
                      ],
                    )
                  ),
                ),
              ],)
        ),
      ),
    ),
  );
}

MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Places>(context, listen: false).items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenHighColor,
        title: Text("Map", style: TextStyle(fontFamily: "PatuaOne"),),
        actions: [
          if(widget.isSelecting)
          IconButton(icon: Icon(Icons.check), 
            onPressed: _pickedLocation == null ? null : (){
              Navigator.of(context).pop(_pickedLocation);
            },
          ),
          if(!widget.isSelecting && !widget.showAllPlace)
          IconButton(icon: Icon(Icons.navigation), 
            onPressed: (){
             openMapsSheet(context, widget.initialLocation.latitude, widget.initialLocation.longitude, widget.initialLocation.address);
            },
          ),
        ],
      ),
      body:Stack(
              children: [
        new FlutterMap( 
          options: new MapOptions(
            center: widget.showAllPlace ? (_pickedLocation != null ? _pickedLocation : new LatLng(items[0].location.latitude,items[0].location.longitude)) : new LatLng(widget.initialLocation.latitude,widget.initialLocation.longitude),
            zoom: 16.0,
            onTap: widget.isSelecting ? selectLocation : null,
          ),
          mapController: _mapController,
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            new MarkerLayerOptions(
              markers: 

                widget.showAllPlace ?

                items.map((item){
                  return Marker(
                    width:45,
                    height:45,
                    point: LatLng(item.location.latitude, item.location.longitude),
                    builder:(context)=> new Container(
                      child: IconButton(
                        iconSize: 45,
                        icon: Icon(Icons.location_on),
                        onPressed: (){
                        },
                        color:Colors.red,
                      ),
                      
                    )
                  );
                }).toList() :
                [Marker(
                  width:45,
                  height:45,
                  point: _pickedLocation ??
                        LatLng(
                          widget.initialLocation.latitude,
                          widget.initialLocation.longitude,
                        ),
                  builder:(context)=> new Container(
                    child: IconButton(
                      iconSize: 45,
                      icon: Icon(Icons.location_on),
                      onPressed: (){
                      },
                      color:Colors.blue,
                    ),
                    
                  )
                ),
              ],
            )
          ],
        ),
        widget.showAllPlace ?
        _builderContainer(items) : Container(),
        ],
      ),
    );
  }
}


