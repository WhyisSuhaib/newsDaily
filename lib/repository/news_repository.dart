import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsdaily/models/categories_news_model.dart';
import 'package:newsdaily/models/news_channels_headlines_model.dart';

class NewsRepository{

  Future<NewsChannelsHeadlinesModel>fetchNewsChannelHeadlinesApi()async{
    String url =
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=308a607bd9cb4f45a1b02ec3af43bea6";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode== 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }


  Future<CategoriesNewsModel>fetchCategoriesNewsApi(String category)
  async{
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=308a607bd9cb4f45a1b02ec3af43bea6";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode== 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}