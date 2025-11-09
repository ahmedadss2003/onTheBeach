import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/about_us/aboout_us.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/data/models/categories_model.dart';
import 'package:tourist_website/features/home/presentation/home_view.dart';
import 'package:tourist_website/features/home/presentation/widgets/contact_us.dart';
import 'package:tourist_website/features/place_detials/presentation/views/place_details_view.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/transporation_Booking_view.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_booking_form.dart';
import 'package:tourist_website/features/why_choose_us/why_choose_us.dart';

final GoRouter router = GoRouter(
  initialLocation: HomePage.routeName,
  routes: [
    // GoRoute(
    //   path: SplashScreen.routeName,
    //   builder: (context, state) => const SplashScreen(),
    // ),
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
      path: AboutUs.routeName,
      builder:
          (context, state) => AboutUs(width: MediaQuery.of(context).size.width),
    ),
    GoRoute(
      path: WhyChooseUsView.routeName,
      builder: (context, state) => WhyChooseUsView(),
    ),

    GoRoute(
      path: TransportBookingForm.routeName,
      redirect: (context, state) {
        return state.extra == null ? HomePage.routeName : null;
      },
      builder: (context, state) {
        final transportationModel = state.extra as TransportationModel;
        return TransportBookingForm(transportationModel: transportationModel);
      },
    ),

    GoRoute(
      path: '${PlaceDetailsView.routeName}/:id/:title',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final title = state.pathParameters['title']!;
        final tourModel = state.extra as TourModel?;

        return PlaceDetailsView(
          tourModel: tourModel,
          tourId: id,
          tourTitle: title,
        );
      },
    ),

    GoRoute(
      path: DiscoverPlacesView.routeName,
      redirect: (context, state) {
        return state.extra == null ? HomePage.routeName : null;
      },
      pageBuilder: (context, state) {
        final map = state.extra as Map<String, dynamic>;
        final categotyModel = CategoriesModel.fromJson(map);
        return CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
          child: DiscoverPlacesView(
            categoryName: categotyModel.categoryName,
            imageUrl:
                categotyModel.image ??
                "https://images.unsplash.com/photo-1728383171554-9c6bcf32da11?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          ),
        );
      },
    ),
  ],
);
