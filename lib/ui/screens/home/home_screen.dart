import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_app/ui/utils/app_assets.dart';
import 'package:news_app/ui/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home';

  List<Widget> screens = [
    CategoriesTab(),
    // news list
    // settings
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppAssets.background, fit: BoxFit.cover, width: double.infinity,),
        Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            title: Text(
              'News App',
              style: GoogleFonts.exo(
                textStyle: TextStyle(
                  fontSize: 22
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 34,
                ),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: AppColors.accent,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: AppColors.primary,
                    child: Center(
                      child: Text(
                        'News App',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 28,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      drawerItemBuilder(icon: Icons.list, text: 'Categories'),
                      drawerItemBuilder(icon: Icons.settings, text: 'Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: screens[0],
        ),
      ],
    );
  }

  Widget drawerItemBuilder({
    required IconData icon,
    required String text
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 20.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: AppColors.textColor,
            ),
            SizedBox(width: 10.0,),
            Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 24,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
