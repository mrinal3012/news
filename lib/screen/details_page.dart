import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/statemanagement/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:news/model/model_page.dart';

class DetailsPage extends StatefulWidget {
  // const DetailsPage({super.key});
  Articles? articles;

  DetailsPage({required this.articles});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      // backgroundColor: newsProvider.gr,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Text(
              "${widget.articles!.title}",
              style: TextStyle(
                  fontSize: 35,
                  color:  Color(0xff2A2A36),

                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.articles!.publishedAt}",
                  style: TextStyle(
                      fontSize: 16,
                      color:  Color(0xff2A2A36)
                         ),
                ),
                Text(
                  "less them a minute",
                  style: TextStyle(
                      fontSize: 16,
                      color:  Color(0xff2A2A36)
                          ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 350,
              width: 50,
              // color: Colors.redAccent,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: "${widget.articles!.urlToImage}",
                height: 300,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
              ),

              // Image(image: NetworkImage("${articles!.urlToImage}")),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Description",
                style: TextStyle(
                    fontSize: 26,
                    color:Color(0xff2A2A36),

                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 20,
            ),
            Text("${widget.articles!.description}",
                style: TextStyle(
                    fontSize: 22,
                    color:  Color(0xff2A2A36)
                        )),
            SizedBox(
              height: 20,
            ),
            Text("Contruct",
                style: TextStyle(
                    fontSize: 26,
                    color:  Color(0xff2A2A36), fontWeight: FontWeight.w600)),
            SizedBox(
              height: 20,
            ),
            Text("${widget.articles!.content}",
                style: TextStyle(
                    fontSize: 22, color: Color(0xff2A2A36)
                        )),
          ],
        ),
      ),
    );
  }
}
