import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/data/models/categories_model.dart';
import 'package:tourist_website/features/home/presentation/widgets/category_tour_card.dart';

class CustomViewDetailsButton extends StatefulWidget {
  const CustomViewDetailsButton({
    super.key,
    required this.context,
    required this.widget,
    required this.categoryName,
    required this.imageUrl,
    required this.categoriesModel,
  });

  final BuildContext context;
  final CategoryTourCard widget;
  final String categoryName;
  final String imageUrl;
  final CategoriesModel categoriesModel;
  @override
  State<CustomViewDetailsButton> createState() =>
      _CustomViewDetailsButtonState();
}

class _CustomViewDetailsButtonState extends State<CustomViewDetailsButton> {
  bool isHover = false;
  Color backgroundColor = Color(0xff1a73e8);
  Color foregroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
          backgroundColor = Colors.white;
          foregroundColor = Colors.blueAccent;
        });
      },
      onExit: (event) {
        setState(() {
          backgroundColor = Color(0xff1a73e8);
          foregroundColor = Colors.white;
          isHover = false;
        });
      },
      child: AnimatedScale(
        scale: isHover ? 1.04 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ElevatedButton(
          onPressed: () {
            context.go(
              DiscoverPlacesView.routeName,
              extra: widget.categoriesModel.toJson(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'View Details',
            style: TextStyle(color: foregroundColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
