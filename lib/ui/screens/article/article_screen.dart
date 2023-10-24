import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/models/articlesDM/ArticlesResponse.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class ArticleScreen extends StatelessWidget {

  static const String routeName = 'article';
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    Articles article = ModalRoute.of(context)!.settings.arguments as Articles;
    provider = Provider.of(context);
    return Stack(
      children: [
        Image.asset(AppAssets.background, fit: BoxFit.cover, width: double.infinity,),
        Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            title: Text(
              provider.appBarTitle,
              style: GoogleFonts.exo(
                textStyle: TextStyle(
                    fontSize: 22
                ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Image.network('https://static.vecteezy.com/system/resources/previews/009/007/136/non_2x/failed-to-load-error-page-404-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg'),
                  placeholder: (_, __) => Center(child: CircularProgressIndicator(),),
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width * 0.92,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        article.author ?? 'Unable to load Article Source',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 10.0,
                                color: AppColors.smallTextColor
                            )
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        article.title ?? 'Unable to load Article Title',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.textColor
                            )
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        article.publishedAt?.replaceRange(10, article.publishedAt?.length, '') ?? 'Unable to load Publish Date',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 13.0,
                              color: AppColors.smallTextColor,
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Column(
                            children: [
                              Text(
                                article.content  ?? "Unable to load Article content",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 13.0,
                                      color: AppColors.smallTextColor,
                                    )
                                ),
                              ),
                              SizedBox(height: 30.0,),
                            ],
                          ),
                          article.content != null ?
                            GestureDetector(
                            onTap: (){},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View Full article',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.play_arrow_rounded
                                ),
                              ],
                            ),
                          )
                              :
                            SizedBox()
                          ,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
