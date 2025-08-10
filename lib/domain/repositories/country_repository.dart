import '../entities/country_entity.dart';

abstract class CountryRepository {
  Future<List<CountryEntity>> getAllCountries();
  Future<void> toggleFavorite(CountryEntity country);
  Future<List<CountryEntity>> getFavoriteCountries();
}
