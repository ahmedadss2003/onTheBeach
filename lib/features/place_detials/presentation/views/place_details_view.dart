import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/place_detials/data/repos/best_sall_impl.dart';
import 'package:tourist_website/features/place_detials/domain/uses_case/best_sall_usecase.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/best_saller_cubit/best_salle_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/views/place_details_view_body.dart';

class PlaceDetailsView extends StatelessWidget {
  const PlaceDetailsView({
    super.key,
    this.tourModel,
    this.tourId,
    this.tourTitle,
  });

  static const String routeName = '/place_details';

  final TourModel? tourModel;
  final String? tourId;
  final String? tourTitle;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => BestSalleCubit(
                BestSallUsecase(
                  bestSallRepo: BestSallRepoImpl(apiService: ApiService(Dio())),
                ),
              )..getBestSalleTours(),
        ),
        BlocProvider(create: (context) => BookingCubit(ApiService(Dio()))),
      ],
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (tourModel != null) {
      return PlaceDetailsViewBody(tourModel: tourModel!);
    }

    if (tourId != null) {
      return FutureBuilder<TourModel>(
        future: _fetchTourById(int.parse(tourId!)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text(tourTitle ?? 'Tour Details')),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load tour details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Go Back'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return PlaceDetailsViewBody(tourModel: snapshot.data!);
          }

          return Scaffold(
            appBar: AppBar(title: const Text('Tour Details')),
            body: const Center(child: Text('No tour data available')),
          );
        },
      );
    }

    // لو مفيش tourModel ولا tourId، ارجع error screen
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              'Invalid tour data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 Method لجلب الـ tour من الـ API
  Future<TourModel> _fetchTourById(int id) async {
    final apiService = ApiService(Dio());
    return await apiService.getTourById(id);
  }
}
