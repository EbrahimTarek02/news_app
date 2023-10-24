import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:news_app/ui/utils/app_assets.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/categoriesDM/categories_data_model.dart';

class CategoriesTab extends StatelessWidget {

  late AppProvider provider;

  List<CategoriesDM> categories = [
    CategoriesDM(backgroundColor: AppColors.red, imagePath: AppAssets.ball, topic: 'Sports'),
    CategoriesDM(backgroundColor: AppColors.navy, imagePath: AppAssets.politics, topic: 'Technology'),
    CategoriesDM(backgroundColor: AppColors.pink, imagePath: AppAssets.health, topic: 'Health'),
    CategoriesDM(backgroundColor: AppColors.green, imagePath: AppAssets.business, topic: 'Business'),
    CategoriesDM(backgroundColor: AppColors.blue, imagePath: AppAssets.environment, topic: 'Entertainment'),
    CategoriesDM(backgroundColor: AppColors.yellow, imagePath: AppAssets.science, topic: 'Science'),
  ];

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return Padding(
      padding: EdgeInsets.all(36.0),
      child: Column(
        children: [
          Text(
            'Pick your category of interest',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor
              ),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  provider.changeCategory(categories[index].topic.toLowerCase());
                  provider.changeCurrentIndex(1);
                  provider.changeAppBarTitle(categories[index].topic);
                  provider.changeTabBarIndex(0);
                },
                child: gridViewItem(
                  context: context,
                  backgroundColor: categories[index].backgroundColor,
                  imagePath: categories[index].imagePath,
                  topic: categories[index].topic,
                  index: index
                ),
              ),
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget gridViewItem({
    required BuildContext context,
    required Color backgroundColor,
    required String imagePath,
    required String topic,
    required int index
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            index % 2 == 0 ?
        BorderRadius.only(
          topRight: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0)
        )
            :
        BorderRadius.only(
          topRight: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
          bottomLeft: Radius.circular(25.0)
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              topic,
              style: GoogleFonts.exo(
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: AppColors.accent
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}