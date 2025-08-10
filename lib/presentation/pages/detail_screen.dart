import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_event.dart';
import '../bloc/country_state.dart';

class DetailScreen extends StatefulWidget {
  final CountryEntity country;

  const DetailScreen({super.key, required this.country});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late CountryEntity country;

  @override
  void initState() {
    super.initState();
    country = widget.country;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CountryBloc, CountryState>(
      listener: (context, state) {
        if (state is FavoriteUpdatedState &&
            state.country.name == country.name) {
          setState(() {
            country = state.country;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(country.name),
          actions: [
            IconButton(
              icon: Icon(
                country.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: country.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                context.read<CountryBloc>().add(ToggleFavorite(country));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  country.flagUrl,
                  width: 200,
                  height: 120,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.flag, size: 100),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Population: ${country.population}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Area: ${country.area} km²',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Region: ${country.region}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Subregion: ${country.subregion}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Timezones: ${country.timezones.join(", ")}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
