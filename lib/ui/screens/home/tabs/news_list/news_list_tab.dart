import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/apis/api_manager/api_manager.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:news_app/ui/common/article_item_builder/article_item_builder.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/sourcesDM/SourcesResponse.dart';

class NewsListTab extends StatelessWidget {

  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return FutureBuilder(
      future: ApiManager.getSources(provider.category),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('error'),);
        }
        else if (snapshot.hasData) {
          return newsListBuilder(snapshot.data!);
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget newsListBuilder(List<Sources> sources) {
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: tabBarBuilder(sources),
          ),
          Expanded(
            flex: 90,
            child: tabBarViewBuilder(sources),
          ),
        ],
      ),
    );
  }

  Widget tabBarBuilder(List<Sources> sources) {
    return TabBar(
      isScrollable: true,
      indicatorColor: AppColors.transparent,
      onTap: (newIndex) => provider.changeTabBarIndex(newIndex),

      tabs: sources.map((e) => Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: sources[provider.tabBarIndex].name != e.name ?
              AppColors.transparent
                :
              AppColors.primary
          ,
          borderRadius: BorderRadius.circular(20.0),
          border: sources[provider.tabBarIndex].name != e.name ?
              Border.all(
                color: AppColors.primary,
                width: 2
              )
                :
              null
          ,

        ),
        child: Text(
          e.name.toString(),
          style: GoogleFonts.exo(
            textStyle: TextStyle(
              fontSize: 14.0,
              color: sources[provider.tabBarIndex].name != e.name ?
                  AppColors.primary
                    :
                  AppColors.accent
            )
          ),
        ),
      )).toList(),
    );
  }

  Widget tabBarViewBuilder(List<Sources> sources) {
    return TabBarView(
      children: sources.map((e) => ArticleItemBuilder(sourceId: e.id ?? '')).toList(),
    );
  }
}