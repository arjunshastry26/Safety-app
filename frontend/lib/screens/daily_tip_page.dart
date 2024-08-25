import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app_properties.dart';
import 'package:frontend/custom_background.dart';

class DailyTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Daily Tips',
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                right: 24.0, left: 24.0, bottom: 24.0, top: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Today's Tip Card
                Card(
                  elevation: 10,
                  color: Colors.orange[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s Tip',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Title
                        Text(
                          'Trust Your Instincts',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Sub Paragraph
                        Text(
                          'Always trust your instincts when making decisions. Explore all features and apply the tips to enhance your experience. Small, consistent improvements can lead to significant progress.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Image
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust the radius as needed
                            child: Image.asset(
                              'assets/im7.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Horizontal Scroll for Quotes
                Text(
                  'Daily Quotes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 10),
                _buildQuotesSection(),
                const SizedBox(height: 20),
                // Additional Tips Section
                Text(
                  'More Tips',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 10),
                _buildAdditionalTips(),
                const SizedBox(height: 20),
                // Latest News Section
                Text(
                  'Latest News',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 10),
                _buildNewsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Horizontal Scroll for Quotes
  Widget _buildQuotesSection() {
    final quotes = [
      '“Believe in yourself and all that you are.”',
      '“You are stronger than you think.”',
      '“Success is not final, failure is not fatal.”',
      '“Keep pushing forward, no matter what.”',
    ];

    return Container(
      height: 120, // Fixed height for the horizontal scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  quotes[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.green[900],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Horizontal Scroll for Additional Tips
  Widget _buildAdditionalTips() {
    final tips = [
      'Always be aware of your surroundings, especially in unfamiliar areas.',
      'Keep your phone fully charged and easily accessible.',
      'Share your location with a trusted friend or family member when going out.',
      'Trust your instincts—if something feels off, remove yourself from the situation.',
      'Learn basic self-defense techniques and practice them regularly.',
    ];

    return Container(
      height: 200, // Fixed height for the horizontal scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    tips[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Horizontal Scroll for Latest News
  Widget _buildNewsSection() {
    final newsItems = [
      {
        'title': 'Safety Awareness Program Launched',
        'description':
            'New initiatives for women safety are being introduced across the city.',
        'image': 'assets/im6.jpg',
      },
      {
        'title': 'Self-Defense Workshops',
        'description':
            'Join upcoming self-defense workshops to boost your confidence and learn essential skills.',
        'image': 'assets/im6.jpg',
      },
      {
        'title': 'Safety App Features Update',
        'description':
            'Check out the latest features added to the app to enhance your safety and convenience.',
        'image': 'assets/im6.jpg',
      },
    ];

    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      newsItems[index]['image']!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newsItems[index]['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          newsItems[index]['description']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
