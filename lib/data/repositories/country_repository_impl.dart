import '../../domain/entities/country_entity.dart';
import '../../domain/repositories/country_repository.dart';
import '../sources/remote/country_remote_data_source.dart';
import '../sources/local/country_local_data_source.dart';
import '../models/country_model.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDataSource remoteDataSource;
  final CountryLocalDataSource localDataSource;

  CountryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<CountryEntity>> getAllCountries() async {
    try {
      final List<CountryModel> models = await remoteDataSource
          .getAllCountries();
      final favoriteNames = await localDataSource.getFavoriteCountryNames();

      return models.map((model) {
        return model.toEntity().copyWith(
          isFavorite: favoriteNames.contains(model.name),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  @override
  Future<void> toggleFavorite(CountryEntity country) async {
    await localDataSource.toggleFavorite(country.name);
  }

  @override
  Future<List<CountryEntity>> getFavoriteCountries() async {
    final favoriteNames = await localDataSource.getFavoriteCountryNames();
    final allCountries = await getAllCountries();

    return allCountries
        .where((country) => favoriteNames.contains(country.name))
        .toList();
  }
}
