import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'imginfo.dart';
import 'package:rstudio/addtofavourite.dart';
import 'package:rstudio/favourite.dart';
import 'package:google_fonts/google_fonts.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  List data;
  List imagesUrl = [];
  List name = [];
  List imgName = [];
  List abc = [];
  List id = [];
  List photographer_id = [];
  List avg_color =[];
  //fetch data using http and connect with api
  Future fetchDataFromApi() async {
    print("***");
    var url = Uri.parse("https://api.pexels.com/v1/search?query=people");
    String apitoken =
        "563492ad6f9170000100000173a1e7111b484072bd3fb9176d1936be";
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": "$apitoken",
    });

    var fetchData = json.decode(response.body);

    setState(() {
      //fetch data from api and store into List
      data = fetchData['photos'];

      data.forEach((element) {
        name.add(element['photographer']);
        imgName.add(element['src']['original'].toString().split("/").last);
        imagesUrl.add(element['src']['medium']);
        id.add(element['id']);
        photographer_id.add(element['photographer_id']);
        avg_color.add(element['avg_color']);
      });
    });

    return "Success";
  }

  @override
  void initState() {
    fetchDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this gridview.builder for manage photos
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.05),
        ),
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          bool a;
          Favourite.imgName.contains(imgName[index]) ? a = true : a = false;
          return Column(
            children: [
              Text(name[index],style: GoogleFonts.ubuntu(fontSize: 18,color: Colors.black)),
              Text(imgName[index],style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.black54),),
              Stack(
                alignment: Alignment.bottomRight,
                children: [

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context ) => ImgInfo(name,id,photographer_id,avg_color,imagesUrl,imgName),));
                    },
                    child: Image.network(
                      imagesUrl[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  //this code for add to favourite button
                  abc.contains(index) ?
                  IconButton(icon: Icon(Icons.favorite,color: Colors.red ,),
                      iconSize: 25,

                      onPressed: (){
                    // Favourite.imgName.add(imgName[index]);
                    if(abc.contains(index)){
                      setState(() {
                        abc.remove(index);
                        funcR(imgName[index]);
                      });
                    }
                    else{
                      setState(() {
                        abc.add(index);
                        funcA(imgName[index]);
                      });
                    }

                  }):
                  IconButton(icon: Icon(Icons.favorite,color: Colors.white ), onPressed: (){
                    // Favourite.imgName.add(imgName[index]);
                    if(abc.contains(index)){
                      setState(() {
                        abc.remove(index);
                        funcR(imgName[index]);
                      });
                    }
                    else{
                      setState(() {
                        abc.add(index);
                        funcA(imgName[index]);
                      });
                    }

                  }),

                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Favourite",
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>AddToFavourite(imagesUrl)));
        },
        child: Icon(Icons.favorite_border),
      ),
    );
  }
  funcA(String name){
    Favourite.imgName.add(name);
  }
  funcR(String name){
    Favourite.imgName.remove(name);
  }
}
