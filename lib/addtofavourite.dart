import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rstudio/favourite.dart';

class AddToFavourite extends StatefulWidget {
  List imagesUrl = [];

  AddToFavourite(this.imagesUrl);
  @override
  _AddToFavouriteState createState() => _AddToFavouriteState();
}

class _AddToFavouriteState extends State<AddToFavourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this gridview.builder for manage photos
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height ),
          ),
          itemCount: Favourite.imgName.length,
          itemBuilder: (BuildContext context, int index) {

            return SafeArea(child: Column(
              children: [
                //image name
                Text(Favourite.imgName[index]),
                //image
                Image.network(
                  widget.imagesUrl[index],
                  fit: BoxFit.cover,
                ),

              ],
            ));
          }),
    );
  }
}
