import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colors

class AppColors {
  static const Color black = Color(0xFF0D0D0D);
  static const Color gustieGold = Color(0xFFF5C518);
  static const Color white = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color border = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF888888);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color tableHeaderBackground = Color(0xFF0D0D0D);
  static const Color tableHeaderText = Color(0xFFF5C518);
  static const Color divider = Color(0xFFE0E0E0);
}

/// Text Styles

class AppTextStyles {
  static TextStyle mainTitle = GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle dateStyle = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle tableHeader = GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: .w700,
    color: AppColors.tableHeaderText,
  );

  static TextStyle personStyle = GoogleFonts.outfit(
    fontSize: 15,
    fontWeight: .w500,
    color: AppColors.black,
  );

  static TextStyle noEvents = GoogleFonts.outfit(
    fontSize: 15,
    fontWeight: .w400,
    color: AppColors.textSecondary,
  );

  static TextStyle appBarButton = GoogleFonts.outfit(
    fontSize: 13,
    fontWeight: .w600,
    color: AppColors.black,
  );
}

class AppPadding {
  static const double extraSmall = 4;
  static const double small = 8;
  static const double normal = 16;
  static const double large = 24;
  static const double gigantomorous = 32;

  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    horizontal: normal);
  static const EdgeInsets fullPadding = EdgeInsets.all(normal);
  static const EdgeInsets tableCellPadding =
      EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0);
}

class TableDecorations {
  static BoxDecoration table = BoxDecoration(
    color: AppColors.cardBackground,
    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
  );

  static BoxDecoration get tableHeader => const BoxDecoration(
        color: AppColors.tableHeaderBackground,
        borderRadius: BorderRadius.all(Radius.circular(4))
      );
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gustieGold,
          surface: AppColors.white,
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.black,
          elevation: 0,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gustieGold,
            foregroundColor: AppColors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            textStyle: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.outfit(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
          floatingLabelStyle: GoogleFonts.outfit(
            fontSize: 13,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.black, width: 2),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        dividerColor: AppColors.divider,
      );
}