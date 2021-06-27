import 'package:flutter/material.dart';
import 'package:rstudio/favourite.dart';

class ImgInfo extends StatefulWidget {
  //fetch the data from display page
  List id;
  List imgName;
  List imagesUrl;
  List avg_color;
  List photographer_id;
  List name;
  ImgInfo(this.id, this.imgName, this.imagesUrl, this.avg_color,
      this.photographer_id,this.name);
  @override
  _ImgInfoState createState() => _ImgInfoState();
}

class _ImgInfoState extends State<ImgInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: GridView.builder(
            itemBuilder: (context, index) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   'Id : '+ widget.id[index].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("----------"),
                  Text(
                    "Photographer Name : "+ widget.name[index],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("----------"),
                  Text(
                    "Photographer_id : " + widget.photographer_id[index],
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("----------"),
                  Text(
                    "avg_color : " + widget.avg_color[index],
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            },
            itemCount: Favourite.imgName.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              // childAspectRatio: MediaQuery.of(context).size.width /
              //     (MediaQuery.of(context).size.height),
            ),
          ),
        ),
      ),
    );
  }
}
