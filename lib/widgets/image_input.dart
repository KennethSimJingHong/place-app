import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_app/constant.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future _takePicture(String val) async {
    File imageFile;
    if(val == "cam"){
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 500, maxHeight: 300);
    }else{
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 500, maxHeight: 300);
    }
    if(imageFile == null) return null;
      setState(() {
        _storedImage = imageFile;
      });
    widget.onSelectImage(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height:300,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null ? Image.file(_storedImage, fit:BoxFit.cover, width: double.infinity) : Text( "No Image Taken", textAlign: TextAlign.center,),
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
                icon: Icon(Icons.camera, color: Colors.white,),
                onPressed: ()=>_takePicture("cam"), 
                label: Text("Take Picture", style: TextStyle(color: Colors.white),),
              ),
            ),
            Expanded(
              child: OutlineButton.icon(
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20))),
                color: kBlueLowColor,
                icon: Icon(Icons.image, color: kGreenHighColor,),
                onPressed: ()=>_takePicture("gallery"), 
                label: Text("Get From Gallery", style: TextStyle(color: kGreenHighColor),),
              ),
            ),
          ],
        ),
      ],
    );
  }
}