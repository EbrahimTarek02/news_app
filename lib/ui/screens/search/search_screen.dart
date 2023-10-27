import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/apis/api_manager/api_manager.dart';
import 'package:news_app/data/models/articlesDM/ArticlesResponse.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:news_app/ui/common/error_widget/error_widget.dart';
import 'package:news_app/ui/common/loading_widget/loading_widget.dart';
import 'package:provider/provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../article/article_screen.dart';

class SearchScreen extends StatelessWidget {

  static const String routeName = 'search';
  late AppProvider provider;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Stack(
      children: [
        Image.asset(AppAssets.background, fit: BoxFit.cover, width: double.infinity,),
        Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.12,
            automaticallyImplyLeading: false,
            title: Container(
              padding: EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 10.0
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(35.0),
                      bottomLeft: Radius.circular(35.0)
                  )
              ),
              child: TextFormField(
                controller: controller,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.textColor
                  ),
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: AppColors.transparent
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                          color: AppColors.transparent
                      )
                  ),
                  hintText: 'Search for article',
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.smallTextColor
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.accent,
                  prefixIcon: IconButton(
                    onPressed: (){
                      provider.clearSearch(controller);
                    },
                    icon: Icon(Icons.clear),
                  ),
                  suffixIcon: Icon(Icons.search)
                ),
                onChanged: (newValue) {
                  controller.text = provider.changeSearch(newValue);
                },
              ),
            ),
          ),
          body: FutureBuilder(
            future: ApiManager.search(controller.text),
            builder: (_, snapshot) => searchListBuilder(snapshot, context),
          ),
        ),
      ],
    );
  }

  Widget searchListBuilder(AsyncSnapshot snapshot, BuildContext context) {
    ArticlesResponse? articlesResponse = snapshot.data;
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.totalResults,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        itemBuilder: (_, index) =>
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ArticleScreen.routeName,
                    arguments: snapshot.data!.articles![index]);
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
                      imageUrl: snapshot.data!.articles![index].urlToImage ??
                          '',
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          Image.network(
                              'https://static.vecteezy.com/system/resources/previews/009/007/136/non_2x/failed-to-load-error-page-404-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg'),
                      placeholder: (_, __) =>
                          MyLoadingWidget(),
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.26,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.92,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      articlesResponse!.articles![index].title ??
                          'Unable to load Article Title',
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
                      snapshot.data!.articles![index].description ??
                          'Unable to load Article Description',
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
                      snapshot.data!.articles![index].publishedAt?.replaceRange(
                          10,
                          snapshot.data!.articles![index].publishedAt?.length,
                          '') ?? 'Unable to load Publish Date',
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
      return MyErrorWidget(errorMessage: 'Noting was Found!');
    }
    else {
      return MyLoadingWidget();
    }
  }
}
