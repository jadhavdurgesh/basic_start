import 'package:basic_start/experience/model/experience_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  Dio dio = Dio();

  Future<List<Experiences>> fetchExperienceData() async {
    try {
      final response =
          await dio.get('https://staging.cos.8club.co/experiences');
      if (response.statusCode == 200) {
        // First decode the response to a Map
        final jsonData = response.data;

        // Create an instance of ExperienceModel using the decoded data
        ExperienceModel experienceModel = ExperienceModel.fromJson(jsonData);

        // Return the list of experiences
        return experienceModel.data?.experiences ?? [];
      } else {
        throw Exception('Failed to load experiences');
      }
    } catch (e) {
      throw Exception('Failed to load experiences: $e');
    }
  }
}
