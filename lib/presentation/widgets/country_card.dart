import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_event.dart';

class CountryCard extends StatelessWidget {
  final CountryEntity country;

  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CountryBloc>(context).add(NavigateToDetail(country));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                country.flagUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.flag),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('Population: ${country.population}'),
                  const SizedBox(height: 4),
                  // IconButton(
                  //   icon: Icon(
                  //     country.isFavorite
                  //         ? Icons.favorite
                  //         : Icons.favorite_border,
                  //     color: country.isFavorite ? Colors.red : null,
                  //   ),
                  //   onPressed: () {
                  //     BlocProvider.of<CountryBloc>(
                  //       context,
                  //     ).add(ToggleFavorite(country));
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
