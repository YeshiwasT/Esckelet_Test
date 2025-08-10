import 'package:equatable/equatable.dart';
import '../../domain/entities/country_entity.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryEntity> countries;

  const CountryLoaded(this.countries);

  @override
  List<Object> get props => [countries];
}

class CountryError extends CountryState {
  final String message;

  const CountryError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteUpdatedState extends CountryState {
  final CountryEntity country;

  const FavoriteUpdatedState(this.country);

  @override
  List<Object> get props => [country];
}

class CountryDetailNavigationState extends CountryState {
  final CountryEntity country;

  const CountryDetailNavigationState(this.country);

  @override
  List<Object> get props => [country];
}
