import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/widgets/trip_card.dart';
import 'package:tourist_website/features/home/presentation/manager/get_all_tours_cubit/get_all_tours_cubit.dart';

class CustomMostPopularGridView extends StatelessWidget {
  final bool seeAll;
  const CustomMostPopularGridView({super.key, required this.seeAll});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllToursCubit, GetAllToursState>(
      builder: (context, state) {
        if (state is GetAllTourLoading) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: Colors.purple,
              rightDotColor: Colors.cyan,
              size: 100,
            ),
          );
        } else if (state is GetAllTourSuccess) {
          final List<TourModel> tours = state.tourList;
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
                itemCount: 10,
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
