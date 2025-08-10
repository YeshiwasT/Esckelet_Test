import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_state.dart';
import '../widgets/country_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Countries')),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CountryLoaded) {
            // Filter favorite countries
            final favoriteCountries = state.countries
                .where((country) => country.isFavorite)
                .toList();

            if (favoriteCountries.isEmpty) {
              return const Center(child: Text('No favorite countries yet'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemCount: favoriteCountries.length,
              itemBuilder: (context, index) {
                return CountryCard(country: favoriteCountries[index]);
              },
            );
          } else if (state is CountryError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
