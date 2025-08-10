import 'package:equatable/equatable.dart';
import '../../domain/entities/country_entity.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class LoadCountries extends CountryEvent {
  final String? query;

  const LoadCountries({this.query});
}

class ToggleFavorite extends CountryEvent {
  final CountryEntity country;

  const ToggleFavorite(this.country);

  @override
  List<Object> get props => [country];
}

class NavigateToDetail extends CountryEvent {
  final CountryEntity country;

  const NavigateToDetail(this.country);

  @override
  List<Object> get props => [country];
}
