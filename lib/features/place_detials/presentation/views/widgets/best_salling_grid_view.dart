import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/widgets/trip_card.dart';
import 'package:tourist_website/features/home/presentation/manager/get_all_tours_cubit/get_all_tours_cubit.dart';
import 'package:tourist_website/features/place_detials/presentation/manager/best_saller_cubit/best_salle_cubit.dart';

class CustomBestSallerTourGridView extends StatelessWidget {
  const CustomBestSallerTourGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSalleCubit, BestSalleState>(
      builder: (context, state) {
        if (state is BestSalleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BestSalleSuccess) {
          final List<TourModel> tours = state.tours;
          return LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: _getChildAspectRatio(constraints.maxWidth),
                ),
                itemCount: tours.length,
                itemBuilder: (context, index) {
                  return TripCard(
                    tourModel: tours[index],
                    width: constraints.maxWidth,
                  );
                },
              );
            },
          );
        } else if (state is GetAllTourError) {
          return const Text('Please try again');
        }
        return const SizedBox();
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  double _getChildAspectRatio(double width) {
    if (width > 1322) return 0.7;
    if (width <= 290) return 0.56;

    if (width < 490) return 0.9;
    if (width > 994) return 0.62;
    if (width < 870) return 0.7;
    if (width > 750) return 0.9;
    if (width < 750) return 0.6;
    if (width > 650) return 1.1;
    return 0.9;
  }
}
