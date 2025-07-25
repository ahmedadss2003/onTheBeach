import 'package:flutter/material.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/discover_places_gridview.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/image_section.dart';
import 'package:tourist_website/features/home/presentation/widgets/footer_section.dart';

class DiscoverPlacesViewBody extends StatelessWidget {
  const DiscoverPlacesViewBody({
    super.key,
    required this.categoryName,
    required this.imageUrl,
  });
  final String categoryName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomDiscoverPLaceImageSection(
                  imageUrl: imageUrl,
                  height: height,
                  categoryName: categoryName,
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomDiscoverPlacesGridView(
                    categoryName: categoryName,
                  ),
                ),

                const SizedBox(height: 20),
                const FooterSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
