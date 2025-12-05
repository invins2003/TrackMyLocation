import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/geocoding_service.dart';
import 'core/services/location_service.dart';
import 'features/location_tracking/viewmodels/location_view_model.dart';
import 'features/location_tracking/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LocationTrackerApp());
}

class LocationTrackerApp extends StatelessWidget {
  const LocationTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const googleApiKey = 'AIzaSyBs-iqfFbqKlLyWq7jubHPiKGfF7qtXFPo';

    return MultiProvider(
      providers: [
        Provider<LocationService>(
          create: (_) => LocationService(),
        ),
        Provider<GeocodingService>(
          create: (_) => GeocodingService(apiKey: googleApiKey),
        ),
        ChangeNotifierProvider<LocationViewModel>(
          create: (context) => LocationViewModel(
            context.read<LocationService>(),
            context.read<GeocodingService>(),
          )..init(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Location Tracking',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
