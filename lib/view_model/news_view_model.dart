import 'package:newsdaily/models/categories_news_model.dart';
import 'package:newsdaily/models/news_channels_headlines_model.dart';
import 'package:newsdaily/repository/news_repository.dart';

class NewsViewModel{

  final _rep = NewsRepository();

  Future <NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi()async{
    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
  }

  Future <CategoriesNewsModel> fetchCategoriesNewsApi(String
  category)async{
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}