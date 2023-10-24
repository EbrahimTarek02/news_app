import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/apis/api_manager/api_manager.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:news_app/ui/screens/article/article_screen.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';

class ArticleItemBuilder extends StatelessWidget {

  String sourceId;

  ArticleItemBuilder({required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getArticles(sourceId),
      builder: (_, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.totalResults,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            itemBuilder: (_, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, ArticleScreen.routeName, arguments: snapshot.data!.articles![index]);
              },
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!.articles![index].urlToImage ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Image.network('https://static.vecteezy.com/system/resources/previews/009/007/136/non_2x/failed-to-load-error-page-404-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg'),
                      placeholder: (_, __) => Center(child: CircularProgressIndicator(),),
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: MediaQuery.of(context).size.width * 0.92,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      snapshot.data!.articles![index].title ?? 'Unable to load Article Title',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 10.0,
                          color: AppColors.textColor
                        )
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      snapshot.data!.articles![index].description ?? 'Unable to load Article Description',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      snapshot.data!.articles![index].publishedAt?.replaceRange(10, snapshot.data!.articles![index].publishedAt?.length, '') ?? 'Unable to load Publish Date',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13.0,
                            color: AppColors.textColor,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else if (snapshot.hasError) {
          return Center(child: Text('Error'),);
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}
