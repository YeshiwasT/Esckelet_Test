import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/country_repository_impl.dart';
import 'data/sources/local/country_local_data_source.dart';
import 'data/sources/remote/country_remote_data_source.dart';
import 'domain/repositories/country_repository.dart';
import 'presentation/bloc/country_bloc.dart';
import 'presentation/bloc/country_event.dart'; // Add this import
import 'presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  final remoteDataSource = CountryRemoteDataSource();
  final localDataSource = CountryLocalDataSource();
  final repository = CountryRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CountryRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) =>
            CountryBloc(countryRepository: repository)..add(LoadCountries()),
        child: const HomeScreen(),
      ),
    );
  }
}
