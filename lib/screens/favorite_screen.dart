import 'package:flutter/material.dart';
import 'package:place_app/constant.dart';
import 'package:place_app/providers/places.dart';
import 'package:place_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
          child: Consumer<Places>(
              child: Center(
                child: const Text('Got no favourites yet, start adding some!'),
              ),
              builder: (ctx, greatPlaces, ch) => greatPlaces.getFav.length <= 0
              ? ch
              : 
              ListView.builder(
                  itemCount: greatPlaces.getFav.length,
                  itemBuilder: (ctx, i){
                  {return Padding(
                    padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.getFav[i].id);
                        },
                        child: Container(
                          width: double.infinity,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children:[
                                ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.file(greatPlaces.getFav[i].image, fit:BoxFit.cover, height:200, width: double.infinity,)),
                                Positioned(
                                  top:20,
                                  right: 20,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      color:Colors.white,
                                      child: IconButton(
                                        padding: EdgeInsets.all(6),
                                        icon: greatPlaces.getFav[i].isFavourite == false ? Icon(Icons.favorite_border) : Icon(Icons.favorite, color:Colors.pink[300]),
                                        onPressed: (){
                                          setState(() {
                                            Provider.of<Places>(context, listen: false).changeFavor(greatPlaces.getFav[i].id, !greatPlaces.items[i].isFavourite);
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
                    );}
                  } 
                  ), 
                ),
          ),
        ],
      );
  }
}