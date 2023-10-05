
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news/model/model_page.dart';

class CustomHttp{

  static Future<NewsModel>fetchHomeData()async{
    String url="https://newsapi.org/v2/everything?q=world&pageSize=10&apiKey=ccdb5fd8b4744dacb1416e93f8c8cf7d";
    NewsModel? newsModel;
    var responce= await http.get(Uri.parse(url));
    var data =jsonDecode(responce.body);
    newsModel=NewsModel.fromJson(data);
    return newsModel!;
  }

}