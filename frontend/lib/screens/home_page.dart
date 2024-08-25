import 'package:flutter/material.dart';
import 'package:frontend/screens/daily_tip_page.dart';
import 'package:frontend/screens/emergency_page.dart';
import 'package:frontend/screens/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstant.horizontalPadding,
                right: AppConstant.horizontalPadding,
                top: AppConstant.verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/menu.png',
                    height: 30,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstant.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo above the heading
                  Center(
                    child: Image.asset(
                      'assets/icons/logo.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Safety Mitra',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    'Stay in control with Safety Mitra\'s \'Live Select\' - Your personalized safety solution for peace of mind on the go!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstant.horizontalPadding,
              ),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstant.horizontalPadding,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Table(
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.green.shade200,
                          width: 1,
                        ),
                        verticalInside: BorderSide(
                          color: Colors.green.shade200,
                          width: 1,
                        ),
                        bottom: BorderSide(
                          color: Colors.green.shade300,
                          width: 2,
                        ),
                        top: BorderSide(
                          color: Colors.green.shade300,
                          width: 2,
                        ),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(2),
                      },
                      children: [
                        // Header Row
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Live Select',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Data Rows
                        for (var option
                            in AppData.liveSelectOptions.asMap().entries)
                          TableRow(
                            decoration: BoxDecoration(
                              color: option.key.isOdd
                                  ? Colors.green.shade50
                                  : Colors.white,
                            ),
                            children: [
                              InkWell(
                                  onTap: () {
                                    switch (option.value) {
                                      case "Settings":
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SettingsScreen(),
                                          ),
                                        );
                                        break;
                                      case "Daily Tips":
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DailyTipsPage(),
                                          ),
                                        );
                                        break;
                                      case "Emergency Call":
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EmergencyCallScreen(),
                                          ),
                                        );
                                        break;
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      option.value,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Footer Text
            Center(
                child: Padding(
              padding: const EdgeInsets.all(AppConstant.horizontalPadding),
              child: Text(
                'Swift support when you need it the most!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
