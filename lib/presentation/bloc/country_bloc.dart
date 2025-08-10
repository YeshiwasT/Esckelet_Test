import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/country_repository.dart';
import '../../domain/entities/country_entity.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository countryRepository;

  CountryBloc({required this.countryRepository}) : super(CountryInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<ToggleFavorite>(_onToggleFavorite);
    on<NavigateToDetail>(_onNavigateToDetail);
  }

  FutureOr<void> _onLoadCountries(
    LoadCountries event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());
    try {
      List<CountryEntity> countries = await countryRepository.getAllCountries();

      if (event.query != null && event.query!.isNotEmpty) {
        countries = countries
            .where(
              (country) => country.name.toLowerCase().contains(
                event.query!.toLowerCase(),
              ),
            )
            .toList();
      }

      emit(CountryLoaded(countries));
    } catch (e) {
      emit(CountryError('Failed to load countries: $e'));
    }
  }

  FutureOr<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CountryState> emit,
  ) async {
    try {
      await countryRepository.toggleFavorite(event.country);
      emit(FavoriteUpdatedState(event.country));

      // Reload countries to update favorites
      add(LoadCountries());
    } catch (e) {
      emit(CountryError('Failed to toggle favorite: $e'));
    }
  }

  FutureOr<void> _onNavigateToDetail(
    NavigateToDetail event,
    Emitter<CountryState> emit,
  ) {
    emit(CountryDetailNavigationState(event.country));
    emit(
      CountryLoaded(
        state is CountryLoaded ? (state as CountryLoaded).countries : [],
      ),
    );
  }
}
