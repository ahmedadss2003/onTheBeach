import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/discover_places_view.dart';
import 'package:tourist_website/features/home/data/models/categories_model.dart';
import 'package:tourist_website/features/home/presentation/widgets/custom_view_details_button.dart';

class CategoryTourCard extends StatefulWidget {
  final CategoriesModel categoriesModel;
  const CategoryTourCard({super.key, required this.categoriesModel});

  @override
  State<CategoryTourCard> createState() => _CategoryTourCardState();
}

class _CategoryTourCardState extends State<CategoryTourCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          return MouseRegion(
            onEnter:
                (event) => setState(() {
                  isHover = true;
                }),
            onExit:
                (event) => setState(() {
                  isHover = false;
                }),
            child: AnimatedScale(
              scale: isHover ? 1.02 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () {
                    context.go(
                      DiscoverPlacesView.routeName,
                      extra: widget.categoriesModel.toJson(),
                    );
                  },
                  child:
                      isMobile
                          ? _buildMobileLayout(
                            widget.categoriesModel.categoryName,
                          )
                          : _buildWebTabletLayout(
                            isTablet,
                            widget.categoriesModel.categoryName,
                          ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Enhanced image widget that handles multiple formats including AVIF
  Widget _buildEnhancedImage({
    required String? imageUrl,
    required double height,
    double? width,
    required BorderRadius borderRadius,
  }) {
    final fallbackImageUrl =
        "https://images.unsplash.com/photo-1728383171554-9c6bcf32da11?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    return ClipRRect(
      borderRadius: borderRadius,
      child:
          kIsWeb
              ? _buildWebImage(imageUrl ?? fallbackImageUrl, height, width)
              : _buildMobileImage(imageUrl ?? fallbackImageUrl, height, width),
    );
  }

  // For web - use Image.network with better error handling
  Widget _buildWebImage(String imageUrl, double height, double? width) {
    return Image.network(
      imageUrl,
      height: height,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: height,
          width: width ?? double.infinity,
          color: Colors.grey[200],
          child: Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        print('Error loading image: $error');
        // Try to convert AVIF to WebP or use fallback
        return _buildFallbackImage(imageUrl, height, width);
      },
    );
  }

  // For mobile - use CachedNetworkImage with better error handling
  Widget _buildMobileImage(String imageUrl, double height, double? width) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Container(
            height: height,
            width: width ?? double.infinity,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          ),
      errorWidget: (context, url, error) {
        print('Error loading cached image: $error');
        return _buildFallbackImage(imageUrl, height, width);
      },
    );
  }

  // Fallback image handler
  Widget _buildFallbackImage(String originalUrl, double height, double? width) {
    // Try to convert AVIF to WebP by replacing the extension
    String convertedUrl = originalUrl;
    if (originalUrl.toLowerCase().endsWith('.avif')) {
      convertedUrl = originalUrl.replaceAll(
        RegExp(r'\.avif$', caseSensitive: false),
        '.webp',
      );
    }

    if (convertedUrl != originalUrl) {
      // Try the converted URL first
      return kIsWeb
          ? Image.network(
            convertedUrl,
            height: height,
            width: width ?? double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If conversion fails, use the ultimate fallback
              return _buildUltimateFallback(height, width);
            },
          )
          : CachedNetworkImage(
            imageUrl: convertedUrl,
            height: height,
            width: width ?? double.infinity,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return _buildUltimateFallback(height, width);
            },
          );
    }

    return _buildUltimateFallback(height, width);
  }

  // Ultimate fallback - default image
  Widget _buildUltimateFallback(double height, double? width) {
    const fallbackImageUrl =
        "https://images.unsplash.com/photo-1728383171554-9c6bcf32da11?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    return kIsWeb
        ? Image.network(
          fallbackImageUrl,
          height: height,
          width: width ?? double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: width ?? double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, size: 50),
            );
          },
        )
        : CachedNetworkImage(
          imageUrl: fallbackImageUrl,
          height: height,
          width: width ?? double.infinity,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return Container(
              height: height,
              width: width ?? double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, size: 50),
            );
          },
        );
  }

  Widget _buildMobileLayout(String categoryName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEnhancedImage(
          imageUrl: widget.categoriesModel.image,
          height: 180,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.categoriesModel.categoryName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 4),
              const SizedBox(height: 8),
              Text(
                widget.categoriesModel.description ??
                    "Description not available",
                style: const TextStyle(color: Color(0xFF5C748A), fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: CustomViewDetailsButton(
                  categoriesModel: widget.categoriesModel,
                  imageUrl:
                      widget.categoriesModel.image ??
                      "https://images.unsplash.com/photo-1728383171554-9c6bcf32da11?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  context: context,
                  widget: widget,
                  categoryName: categoryName,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebTabletLayout(bool isTablet, String categoryName) {
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildEnhancedImage(
              imageUrl: widget.categoriesModel.image,
              height: 300,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.categoriesModel.categoryName,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 12),
                  Text(
                    widget.categoriesModel.description ??
                        "Description not available",
                    style: const TextStyle(
                      color: Color(0xFF5C748A),
                      fontSize: 16,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomViewDetailsButton(
                      categoriesModel: widget.categoriesModel,
                      imageUrl:
                          widget.categoriesModel.image ??
                          "https://images.unsplash.com/photo-1728383171554-9c6bcf32da11?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      context: context,
                      widget: widget,
                      categoryName: categoryName,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
