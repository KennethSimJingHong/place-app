import 'package:flutter/material.dart';
import 'package:place_app/constant.dart';
import 'package:place_app/screens/add_place_screen.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        ClipPath(
          clipper: NavBarClipper(),
          child: Container(width: double.infinity, height:100, color: kGreenHighColor,)
        ),

        Positioned(top:45, left:15,child: Text("Places", style: TextStyle(fontSize: 20, fontFamily: "PatuaOne", color: Colors.white),)),

        Positioned(
          top:35,
          right:0,
          child: Row(children: [
            IconButton(
              icon:Icon(Icons.favorite, color:kGreenHighColor),
              onPressed: (){
                
              },
            ),
            IconButton(
              icon:Icon(Icons.add, color:kGreenHighColor),
              onPressed: (){
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],),
        ),

        
      ],
    );
  }
}


class NavBarClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
      Path path = Path();
      path.lineTo(0, size.height*0.9);
      path.cubicTo(size.width/2, size.height, size.width/3, size.height/5, size.width, size.height/3);
      path.lineTo(size.width, 0);
      return path;
    }
  
    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}