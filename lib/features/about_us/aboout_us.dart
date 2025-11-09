import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key, required this.width});
  static const routeName = "/about-us";
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0077B6), // Blue - Water
            Color(0xFFE9C46A), // Sand - Desert
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            AutoSizeText(
              "About Us",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF4D35E), // Sand Highlight Title
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width < 700 ? 25 : 60),
              child: AutoSizeText(
                textAlign: TextAlign.start,
                "Welcome to On The Beach Excursions — your trusted UK-based travel company with offices in England and Sharm El Sheikh, Egypt.\n"
                "We are a fully licensed tour operator providing high–quality excursions, private transfers, and unforgettable holiday experiences across Egypt.\n"
                "\n"
                "• Travel with Confidence: With British management and local Egyptian expertise, we ensure world-class service with authentic local experiences.\n"
                "• Personalized Adventures: Whether you're diving in the Red Sea, exploring the Pyramids of Giza, or discovering the temples of Luxor, every trip is designed to match your interests.\n"
                "• Stress-Free Holidays: From booking to the end of your journey, we take care of every detail — transfers, tours, safety, comfort, and guidance.\n"
                "• Trusted & Licensed: As a fully registered tour operator, we guarantee professional service, transparent pricing, and reliable support throughout your stay.\n"
                "\n"
                "At On The Beach Excursions, every traveler is more than a guest — you’re a friend. We are here to make your holiday safe, smooth, and full of memories you’ll always treasure.",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
