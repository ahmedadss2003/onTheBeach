import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourist_website/core/helper_function/app_router.dart';
import 'package:tourist_website/core/theming/them_cubit/them_cubit.dart';
import 'package:tourist_website/core/widgets/up_arrow.dart';
import 'package:tourist_website/core/widgets/whatsApp_floating_button%20.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const SharmElSheikhApp(),
    ),
  );
}

class SharmElSheikhApp extends StatelessWidget {
  const SharmElSheikhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return AnimatedTheme(
          data: state == ThemeMode.dark ? ThemeData.dark() : ThemeData.light(),
          duration: const Duration(milliseconds: 300),
          child: MaterialApp.router(
            routerConfig: router,
            darkTheme: ThemeData.dark(),
            themeMode: state,
            debugShowCheckedModeBanner: false,
            title: 'On The beach Excursions',
            theme: ThemeData(
              // primaryColor: const Color(0xFF101518),
              scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
              textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
                bodyLarge: GoogleFonts.notoSans(),
                bodyMedium: GoogleFonts.notoSans(),
                bodySmall: GoogleFonts.notoSans(),
              ),
            ),
            builder: (context, child) {
              return Scaffold(
                body: Stack(
                  children: [
                    child ?? const SizedBox.shrink(),
                    const WhatsAppFloatingButton(),
                    UpArrow(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tourist_website/core/helper_function/helper_function.dart';
// import 'package:tourist_website/core/widgets/up_arrow.dart';
// import 'package:tourist_website/core/widgets/whatsApp_floating_button%20.dart';
// import 'package:tourist_website/features/home/presentation/home_view.dart';

// void main() {
//   runApp(const SharmElSheikhApp());
// }

// class SharmElSheikhApp extends StatelessWidget {
//   const SharmElSheikhApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'On The beach Excursions',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF101518),
//         scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
//         textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
//           bodyLarge: GoogleFonts.notoSans(),
//           bodyMedium: GoogleFonts.notoSans(),
//           bodySmall: GoogleFonts.notoSans(),
//         ),
//       ),
//       builder: (context, child) {
//         return Scaffold(
//           body: Stack(
//             children: [
//               child ?? const SizedBox.shrink(),
//               const WhatsAppFloatingButton(),
//               UpArrow(),
//             ],
//           ),
//         );
//       },
//       onGenerateRoute: onGenerateRoute,
//       initialRoute: HomePage.routeName,
//     );
//   }
// }
