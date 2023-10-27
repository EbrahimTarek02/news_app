import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data/models/articlesDM/ArticlesResponse.dart';
import 'package:news_app/data/models/sourcesDM/SourcesResponse.dart';

abstract class ApiManager {
  static Future<List<Sources>> getSources(String category) async{
    try {
      const String baseUrl = 'https://newsapi.org/';
      const String sourcesEndPoint = 'v2/top-headlines/sources';
      // const String apiKey = 'cd5018f132494c89808207d7534ca5f8';
      const String apiKey = '06113bb6ec544ddc83dac0645693f2a4';
      String url = '${baseUrl}${sourcesEndPoint}?category=${category}&apiKey=${apiKey}';
      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> json = jsonDecode(response.body);
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);

      if (response.statusCode >= 200 && response.statusCode < 300 && sourcesResponse.sources?.isNotEmpty == true){
        return sourcesResponse.sources!;
      }
      throw Exception(sourcesResponse.message);
    }
    catch(e) {
      rethrow;
    }
  }

  static Future<ArticlesResponse> getArticles(String sourceId) async{
    try {
      const String baseUrl = 'https://newsapi.org/';
      const String articlesEndPoint = 'v2/top-headlines';
      // const String apiKey = 'cd5018f132494c89808207d7534ca5f8';
      const String apiKey = '06113bb6ec544ddc83dac0645693f2a4';
      String url = '${baseUrl}${articlesEndPoint}?sources=${sourceId}&apiKey=${apiKey}';
      http.Response articlesResponse = await http.get(Uri.parse(url));

      Map<String, dynamic> json = jsonDecode(articlesResponse.body);
      ArticlesResponse response = ArticlesResponse.fromJson(json);

      if(articlesResponse.statusCode >= 200 && articlesResponse.statusCode < 300 && response.articles?.isNotEmpty == true){
        return response;
      }

      throw Exception('Something went wrong please try again later');
    } catch(e) {
      rethrow;
    }
  }

  static search(String searchKeyword) async{
    try{
      const String baseUrl = 'https://newsapi.org/';
      const String articlesEndPoint = 'v2/top-headlines';
      // const String apiKey = 'cd5018f132494c89808207d7534ca5f8';
      const String apiKey = '06113bb6ec544ddc83dac0645693f2a4';
      String url = '${baseUrl}${articlesEndPoint}?q=${searchKeyword}&apiKey=${apiKey}';
      http.Response response = await http.get(Uri.parse(url));

      Map<String, dynamic> json = jsonDecode(response.body);
      ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300 && articlesResponse.articles?.isNotEmpty == true){
        return articlesResponse;
      }
      throw Exception("Something went wrong please try again later");
    }catch(e){
      rethrow;
    }
  }
}