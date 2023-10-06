
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model/model_page.dart';
import 'package:news/screen/details_page.dart';
import 'package:news/statemanagement/custom_http.dart';
import 'package:news/statemanagement/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController newsController = TextEditingController();
  NewsModel ? newsModel;
  final scrollController=ScrollController();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPost();
  }
  void _scrollListener(){
  
    setState(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageNo = pageNo+1;

      }else{
        print("not call......................................");
      }
    });
  }

  Future <void> fetchPost() async {}

  var pageNo = 1;
  String news = "world";

  // String sorted = cityController;
  @override
  Widget build(BuildContext context) {
    var newsPorvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text("Bangladesh Times",style: TextStyle(color: Colors.white),),),
        backgroundColor: Color(0xff1B192F),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child:Column(children: [
          SizedBox(height: 10,),
          Expanded(flex: 1, child: Container( height: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 8,left: 5,right: 5),
                child: TextField(
                  controller: newsController,
                  onEditingComplete: () async {
                    newsModel = await newsPorvider.getHomeData(newsController.text.isEmpty ? news : newsController.text.toString() );
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 2, color: Colors.blueGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(width: 2, color: Colors.teal)),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            newsController.clear();
                            setState(() {});
                          },
                          icon: Icon(Icons.clear_outlined))),
                )),

          ),),
          Expanded(flex: 10, child:
          ListView(
            children: [

              FutureBuilder<NewsModel>(
                future: newsPorvider.getHomeData(newsController.text.isEmpty ? news : newsController.text.toString() ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "Wrong",
                      style: TextStyle(color: Colors.black),
                    );
                  } else if (snapshot.data == null) {
                    return Text(
                      "null",
                      style: TextStyle(color: Colors.black),
                    );
                  }
                  return
                    ListView.builder(
                    controller: scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(articles:  snapshot.data!.articles![index],),));
                          },
                          child: Container(
                            height: 150,
                            color: Color(0xff001429),
                            child: Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  color: Colors.redAccent,
                                ),
                                Container(
                                  height: 70,
                                  width: 70,
                                  color: Colors.redAccent,
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  color: Colors.black,
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Colors.redAccent,
                                    )),
                                Container(
                                  margin: EdgeInsets.all(12),
                                  color: Color(0xFF1B192F),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 5, top: 5, bottom: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child:  CachedNetworkImage(
                                            imageUrl: "${snapshot.data!.articles![index].urlToImage}",
                                            height: 100,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url, error) =>
                                                Image.network(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [

                                                Text(
                                                  "${snapshot.data!.articles![index].title}",
                                                  style: TextStyle(
                                                      color: Colors.white),maxLines: 1,
                                                ),
                                                Text("${snapshot.data!.articles![index].description}",
                                                  style: TextStyle(
                                                      color: Colors.white),maxLines: 3,),

                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )

                  ;
                },
              )
            ],
          ))
        ],)

      ),
    );
  }

}
