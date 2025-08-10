import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/country_model.dart';

class CountryRemoteDataSource {
  final String baseUrl =
      'https://restcountries.com/v3.1/independent?status=true&fields=name,population,flag,area,region,subregion,timezones,flags';

  Future<List<CountryModel>> getAllCountries() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CountryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
