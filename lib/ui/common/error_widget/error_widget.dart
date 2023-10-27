import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/ui/utils/app_assets.dart';
import 'package:news_app/ui/utils/app_colors.dart';

class MyErrorWidget extends StatelessWidget {

  String errorMessage;

  MyErrorWidget({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 70,
            color: AppColors.red,
          ),
          Text(
            errorMessage,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 24,
                color: AppColors.textColor
              )
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
