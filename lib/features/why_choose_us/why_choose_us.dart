import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WhyChooseUsView extends StatelessWidget {
  const WhyChooseUsView({super.key});
  static const routeName = "/why-choose-us";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F4),
      appBar: AppBar(
        title: const Text(
          'Why Choose On The Beach Excursions',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF0077B6), // BLUE SEA
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO SECTION
            Container(
              width: double.infinity,
              height: isMobile ? 200 : 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1544552866-d1c8f40f7190?auto=format&fit=crop&w=1350&q=80',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black38,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: AutoSizeText(
                  'Your Journey, Our Passion',
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 16, 15, 15),
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                ),
              ),
            ),

            // MAIN CONTENT SECTION
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE9C46A), // Soft Sand Yellow
                    Colors.white,
                  ],
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 30 : 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Why Travel with Us?',
                    style: TextStyle(
                      fontSize: isMobile ? 26 : 34,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0077B6), // SEA BLUE
                    ),
                  ),
                  const SizedBox(height: 12),

                  AutoSizeText(
                    'Discover why travelers from the UK & Europe choose On The Beach Excursions as their trusted Egypt tour operator.',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildSectionCard(
                    width,
                    icon: Icons.verified,
                    title: "Trusted & Professional",
                    text:
                        "Licensed, experienced, and internationally trusted tour operator offering high-quality travel experiences all over Egypt.",
                  ),
                  const SizedBox(height: 20),

                  _buildSectionCard(
                    width,
                    icon: Icons.tour,
                    title: "Expert Local Guides",
                    text:
                        "Experienced guides in Cairo, Luxor, Aswan & the Red Sea bring history and culture to life with real passion.",
                  ),
                  const SizedBox(height: 20),

                  _buildSectionCard(
                    width,
                    icon: Icons.star,
                    title: "Top-Rated Experiences",
                    text:
                        "Our tours include must-see wonders: Pyramids, Luxor Temples, Red Sea diving, desert safaris & Nile cruises.",
                  ),
                  const SizedBox(height: 20),

                  _buildSectionCard(
                    width,
                    icon: Icons.handshake,
                    title: "Transparent Pricing",
                    text:
                        "No hidden fees — clear communication, fair pricing, comfortable travel, and professional service.",
                  ),
                  const SizedBox(height: 20),

                  _buildSectionCard(
                    width,
                    icon: Icons.flight_takeoff,
                    title: "Your Journey, Made Personal",
                    text:
                        "We treat every traveler like a friend — ensuring comfort, safety, and unforgettable memories.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    double width, {
    required IconData icon,
    required String title,
    required String text,
  }) {
    final isMobile = width < 600;
    return Card(
      elevation: 5,
      shadowColor: const Color(0xFF0077B6).withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: isMobile ? 30 : 38,
              color: const Color(0xFFE9C46A), // SAND YELLOW
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0077B6),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8),
                  AutoSizeText(
                    text,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
