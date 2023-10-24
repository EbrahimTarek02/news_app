import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/apis/api_manager/api_manager.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:news_app/ui/screens/home/tabs/categories/categories_tab.dart';
import 'package:news_app/ui/screens/home/tabs/news_list/news_list_tab.dart';
import 'package:news_app/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:news_app/ui/utils/app_assets.dart';
import 'package:news_app/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home';
  late AppProvider provider;

  List<Widget> screens = [
    CategoriesTab(),
    NewsListTab(),
    SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {
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
                      InkWell(
                        child: drawerItemBuilder(icon: Icons.list, text: 'Categories'),
                        onTap: () {
                          provider.changeCurrentIndex(0);
                          provider.changeAppBarTitle('News App');
                          Navigator.pop(context);
                        },
                      ),
                      InkWell(
                        child: drawerItemBuilder(icon: Icons.settings, text: 'Settings'),
                        onTap: () {
                          provider.changeCurrentIndex(2);
                          provider.changeAppBarTitle('Settings');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: screens[provider.currentIndex],
        ),
      ],
    );
  }

  Widget drawerItemBuilder({
    required IconData icon,
    required String text
  }) {
    return Padding(
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
    );
  }
}
