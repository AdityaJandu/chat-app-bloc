import 'package:flutter/material.dart';

/*

Manage all the constants:
=> STYLES
=> THEMES (in future)
=> Gradients
=> Common useful functions

*/

class Consts {
  /* TEXT STYLE */
  TextStyle semiBoldStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  TextStyle regularStyle = const TextStyle(
    fontSize: 15,
  );
  TextStyle boldStyleLarge = const TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
  );
  TextStyle boldStyleMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  TextStyle mediumStyle1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  TextStyle mediumStyle2 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  TextStyle thinStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /* GRADIENTS */
  LinearGradient linearGradient1 = const LinearGradient(
    colors: [
      Color(0xffddd6f3),
      Color(0xfffaaca8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /* FUNCTIONS */
  // Func to capitlize:
  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /* WIDGETS */
  Widget backgroundGradient = Container(
    height: double.infinity,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xfffad0c4),
          Color(0xffffd1ff),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  );

  List<Color> getColorForStatus(String status) {
    switch (status) {
      case 'approved':
        return [const Color(0xFFD1FAE5), Colors.green];
      // Very soft mint green
      case 'pending':
        return [
          const Color(0xFFFEF9C3),
          const Color(0xFFEAB308) // Deep amber yellow
        ];
      // Soft buttery yellow
      case 'rejected':
        return [
          const Color(0xFFFEE2E2),
          const Color.fromARGB(255, 255, 24, 24)
        ];
      // Soft pink/red
      default:
        return [const Color(0xFFE5E7EB), const Color(0xFFD1D5DB)];
      // Soft neutral grey
    }
  }
}
