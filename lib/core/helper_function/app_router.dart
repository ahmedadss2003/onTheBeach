import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/presentation/home_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/contact_us.dart';
import 'package:tourist_website/features/place_detials/presentation/views/place_details_view.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/transporation_Booking_view.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_booking_form.dart';
import 'package:tourist_website/splash.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashScreen.routeName,
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: ContactUsScreen.routeName,
      builder: (context, state) => const ContactUsScreen(),
    ),

    GoRoute(
      path: TransporationBookingView.routeName,
      builder: (context, state) => TransporationBookingView(),
    ),
    GoRoute(
      path: TransportBookingForm.routeName,
      builder: (context, state) {
        final transportationModel = state.extra as TransportationModel;
        return TransportBookingForm(transportationModel: transportationModel);
      },
    ),
    GoRoute(
      path: PlaceDetailsView.routeName,
      builder: (context, state) {
        final map = state.extra as Map<String, dynamic>;
        final tourModel = TourModel.fromJson(map);
        return PlaceDetailsView(tourModel: tourModel);
      },
    ),
    GoRoute(
      path: DiscoverPlacesView.routeName, // e.g. '/discover'
      pageBuilder: (context, state) {
        final map = state.extra as Map<String, String>;
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
          child: DiscoverPlacesView(
            categoryName: map['categoryName']!,
            imageUrl: map['imageUrl']!,
          ),
        );
      },
    ),
  ],
);
