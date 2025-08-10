import 'package:equatable/equatable.dart';
import '../../domain/entities/country_entity.dart';

class CountryModel extends Equatable {
  final String name;
  final String capital;
  final String flagUrl;
  final double area;
  final String region;
  final String subregion;
  final int population;
  final List<String> timezones;

  const CountryModel({
    required this.name,
    required this.capital,
    required this.flagUrl,
    required this.area,
    required this.region,
    required this.subregion,
    required this.population,
    required this.timezones,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'] ?? '',
      capital: json['capital'] ?? "",
      flagUrl: json['flags']['png'] ?? '',
      area: (json['area'] ?? 0.0).toDouble(),
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      population: json['population'] ?? 0,
      timezones: List<String>.from(json['timezones'] ?? []),
    );
  }

  CountryEntity toEntity() {
    return CountryEntity(
      name: name,
      capital: capital,
      flagUrl: flagUrl,
      area: area,
      region: region,
      subregion: subregion,
      population: population,
      timezones: timezones,
    );
  }

  @override
  List<Object> get props => [
    name,
    capital,
    flagUrl,
    area,
    region,
    subregion,
    population,
    timezones,
  ];
}
