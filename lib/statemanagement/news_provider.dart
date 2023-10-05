import 'package:flutter/cupertino.dart';
import 'package:news/model/model_page.dart';
import 'package:news/statemanagement/custom_http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewsProvider with  ChangeNotifier{

  NewsModel? newsModel;

  Future<NewsModel> getHomeData()async{

    newsModel=await CustomHttp.fetchHomeData( );

    return newsModel!;
  }

}