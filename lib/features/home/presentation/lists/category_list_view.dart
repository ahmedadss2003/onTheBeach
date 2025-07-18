import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/features/home/data/models/categories_model.dart';
import 'package:tourist_website/features/home/presentation/manager/get_categories/get_categories_cubit.dart';
import 'package:tourist_website/features/home/presentation/widgets/category_tour_card.dart';

class CustomCategoryListView extends StatelessWidget {
  const CustomCategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator(), // Show loading indicator
          );
        } else if (state is GetCategoriesSuccess) {
          final List<CategoriesModel> categories = state.categories;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryTourCard(categoriesModel: categories[index]);
            },
          );
        } else {
          return const Center(
            child: Text(
              'No categories found',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          );
        }
      },
    );
  }
}
