import 'package:basic_start/constants/colors.dart';
import 'package:basic_start/constants/common/custom_textfield.dart';
import 'package:basic_start/experience/service/api_service.dart';
import 'package:basic_start/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/common/custom_button.dart';
import 'model/experience_model.dart';
import 'utils/widgets/custom_line.dart';

class ExperienceSelectionScreen extends StatefulWidget {
  const ExperienceSelectionScreen({super.key});

  @override
  State<ExperienceSelectionScreen> createState() =>
      _ExperienceSelectionScreenState();
}

class _ExperienceSelectionScreenState extends State<ExperienceSelectionScreen> {
  List<bool> selectedImages = [];
  late Future<List<Experiences>> futureExperiences; // Renamed variable

  @override
  void initState() {
    super.initState();
    futureExperiences =
        ApiService().fetchExperienceData(); // Fetching experience data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Keep this true for responsive layout
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context), // Added back navigation
            icon: Icon(
              Icons.arrow_back_rounded,
              color: textColor,
            )),
        actions: [
          Spacer(flex: 6),
          SizedBox(
            width: 280,
            height: 50,
            child: CustomPaint(
              size: const Size(double.infinity, 50),
              painter: SnakeLineHalfColorPainter(divider: 3),
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close_rounded,
                color: textColor,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end, // Align to the bottom
          children: [
            Spacer(),
            Text(
              "What kind of hotspots do you want to host?",
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 0.3),
            ),
            12.heightBox,
            Container(
              height: 160,
              child: FutureBuilder<List<Experiences>>(
                future: futureExperiences,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Experiences>? data = snapshot.data;
                    if (selectedImages.isEmpty) {
                      selectedImages = List<bool>.filled(data!.length, false);
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImages[index] = !selectedImages[index];
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                margin: const EdgeInsets.only(right: 16.0),
                                child: Image.network(
                                  data[index].imageUrl.toString(),
                                ),
                              ),
                              if (!selectedImages[index]) // Adjusted condition
                                Container(
                                  width: 130,
                                  height: 130,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No experiences found'));
                  }
                },
              ),
            ),
            const CustomTextfield(
              height: 165,
              lines: 5,
              length: 250,
            ),
            20.heightBox,
            custom_button(
              ontap: () => Get.to(() => OnboardingScreen()),
            ),
            // 20.heightBox,
          ],
        ),
      ),
    );
  }
}
