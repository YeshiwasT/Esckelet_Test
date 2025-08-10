class CountryEntity {
  final String name;
  final String capital;

  final String flagUrl;
  final double area;
  final String region;
  final String subregion;
  final int population;
  final List<String> timezones;
  final bool isFavorite;

  const CountryEntity({
    required this.name,
    required this.capital,

    required this.flagUrl,
    required this.area,
    required this.region,
    required this.subregion,
    required this.population,
    required this.timezones,
    this.isFavorite = false,
  });

  CountryEntity copyWith({
    String? name,
    String? flagUrl,
    String? capital,
    double? area,
    String? region,
    String? subregion,
    int? population,
    List<String>? timezones,
    bool? isFavorite,
  }) {
    return CountryEntity(
      name: name ?? this.name,
      capital: capital ?? this.capital,
      flagUrl: flagUrl ?? this.flagUrl,
      area: area ?? this.area,
      region: region ?? this.region,
      subregion: subregion ?? this.subregion,
      population: population ?? this.population,
      timezones: timezones ?? this.timezones,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
