import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/apis/api_manager/api_manager.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:news_app/ui/common/article_item_builder/article_item_builder.dart';
import 'package:news_app/ui/common/error_widget/error_widget.dart';
import 'package:news_app/ui/common/loading_widget/loading_widget.dart';
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
          return MyErrorWidget(errorMessage: 'Something went wrong please try again later.',);
        }
        else if (snapshot.hasData) {
          print(snapshot.data);
          return newsListBuilder(snapshot.data!);
        }
        else{
          return MyLoadingWidget();
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
      indicator: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      indicatorPadding: EdgeInsets.all(10.0),

      tabs: sources.map((e) => Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border:
            Border.all(
              color: AppColors.primary,
              width: 2
            ),
        ),
        child: Text(
          e.name.toString(),
          style: GoogleFonts.exo(
            textStyle: TextStyle(
              fontSize: 14.0,
              color: Colors.black
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