import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/country_repository_impl.dart';
import 'data/sources/local/country_local_data_source.dart';
import 'data/sources/remote/country_remote_data_source.dart';
import 'domain/repositories/country_repository.dart';
import 'presentation/bloc/country_bloc.dart';
import 'presentation/bloc/country_event.dart';
import 'presentation/pages/home_screen.dart';
import 'presentation/pages/favorite_screen.dart';

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

class MyApp extends StatefulWidget {
  final CountryRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  late CountryBloc _countryBloc;

  @override
  void initState() {
    super.initState();
    _countryBloc = CountryBloc(countryRepository: widget.repository)
      ..add(LoadCountries());
  }

  final List<Widget> _screens = [const HomeScreen(), const FavoriteScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider.value(
        value: _countryBloc,
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
