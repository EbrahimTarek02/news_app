import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/app_colors.dart';

class ArticleWebViewScreen extends StatefulWidget {

  static const String routeName = 'article web view';

  @override
  State<ArticleWebViewScreen> createState() => _ArticleWebViewScreenState();
}

class _ArticleWebViewScreenState extends State<ArticleWebViewScreen> {
  late AppProvider provider;
  late WebViewController controller;


  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    String url = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: AppColors.accent,
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
      body: WebViewWidget(
              controller: WebViewController()
                ..setNavigationDelegate(NavigationDelegate(
                  onWebResourceError: (_){
                    Navigator.pop(context);
                  }
                ))
                ..setBackgroundColor(AppColors.accent)
                ..loadRequest(Uri.parse(url)),
            ),
    );
  }
}
