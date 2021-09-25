import 'package:flutter/material.dart';
import 'package:place_app/constant.dart';
import 'package:place_app/providers/places.dart';
import 'package:place_app/screens/add_place_screen.dart';
import 'package:place_app/screens/favorite_screen.dart';
import 'package:place_app/screens/map_screen.dart';
import 'package:place_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {
  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  bool isFavTaped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenHighColor,
        elevation: 0,
        centerTitle: false,
        title: Text("Places",
          style: TextStyle(
            fontFamily: "PatuaOne",
          ),
        ),
        actions: [
          IconButton(
            icon: isFavTaped ?  Icon(Icons.favorite) : Icon(Icons.favorite_border),
            onPressed: (){
              setState(() {
                isFavTaped = !isFavTaped;
              });
            },
          ),
          IconButton(
            icon:Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: 

      !isFavTaped ?
      
      Column(
        children: [
          Expanded(
            child: Consumer<Places>(
                child: Center( child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                ? ch
                : 
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, i){
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                                },
                                child: Container(
                                  width: double.infinity,
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(children:[
                                        ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.file(greatPlaces.items[i].image, fit:BoxFit.cover, height:200, width: double.infinity,)),
                                        Positioned(
                                          top:20,
                                          right: 20,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Container(
                                              color:Colors.white,
                                              child: IconButton(
                                                padding: EdgeInsets.all(6),
                                                icon: greatPlaces.items[i].isFavourite == false ? Icon(Icons.favorite_border) : Icon(Icons.favorite, color:Colors.pink[300]),
                                                onPressed: (){
                                                  setState(() {
                                                    Provider.of<Places>(context, listen: false).changeFavor(greatPlaces.items[i].id, !greatPlaces.items[i].isFavourite);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ] ),
                                      SizedBox(height: 5,),
                                      Text(greatPlaces.items[i].title, style: TextStyle(fontFamily: "PatuaOne", fontSize: 23, color: kGreenHighColor),),
                                      SizedBox(height: 5,),
                                      Text(greatPlaces.items[i].location.address, style: TextStyle(fontFamily: "PatuaOne", fontWeight: FontWeight.w400, color: Colors.black54),),
                                      SizedBox(height: 5,),
                                    ],
                                  )
                                ),
                              ),
                            );
                          } 
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton.icon(
                          elevation: 0,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          color: kGreenHighColor,
                          icon:Icon(Icons.map, color: Colors.white,),
                          label:Text("Show All Locations", style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (ctx)=>MapScreen(isSelecting:false, showAllPlace: true,)));
                          },
                        ),
                      ),
                    ],
                  ),
                ), 
              ),
          ),
        ],
      ) :
      FavouriteScreen(),
    );
  }
}