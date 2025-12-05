import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/models/location_model.dart';
import '../../../core/models/location_history_item.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/geocoding_service.dart';

enum PermissionStatusView {
  unknown,
  granted,
  denied,
}

class LocationViewModel extends ChangeNotifier {
  final LocationService _locationService;
  final GeocodingService _geocodingService;

  LocationViewModel(
    this._locationService,
    this._geocodingService,
  );

  PermissionStatusView _permissionStatus = PermissionStatusView.unknown;
  PermissionStatusView get permissionStatus => _permissionStatus;

  LocationModel? _currentLocation;
  LocationModel? get currentLocation => _currentLocation;

  final List<LocationHistoryItem> _history = [];
  List<LocationHistoryItem> get history => List.unmodifiable(_history);

  bool _isTracking = false;
  bool get isTracking => _isTracking;

  StreamSubscription<Position>? _positionSubscription;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    final hasPermission = await _locationService.hasLocationPermission();
    _permissionStatus =
        hasPermission ? PermissionStatusView.granted : PermissionStatusView.denied;
    notifyListeners();

    if (hasPermission) {
      await fetchCurrentLocation();
      startLocationStream();
    }
  }

  Future<void> requestPermission() async {
    final granted = await _locationService.requestLocationPermission();
    _permissionStatus =
        granted ? PermissionStatusView.granted : PermissionStatusView.denied;
    notifyListeners();

    if (granted) {
      await fetchCurrentLocation();
      startLocationStream();
    }
  }

  Future<void> fetchCurrentLocation() async {
    try {
      _errorMessage = null;
      final position = await _locationService.getCurrentPosition();
      await _updateLocation(position);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void startLocationStream() {
    if (_positionSubscription != null) return;
    _isTracking = true;
    notifyListeners();

    _positionSubscription = _locationService.positionStream().listen(
      (position) async {
        await _updateLocation(position);
      },
      onError: (e) {
        _errorMessage = e.toString();
        notifyListeners();
      },
    );
  }

  Future<void> _updateLocation(Position position) async {
    final address = await _geocodingService.getAddressFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final updated = LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      city: address['city'],
      state: address['state'],
      pincode: address['pincode'],
      updatedAt: DateTime.now(),
    );

    _currentLocation = updated;
    _history.insert(0, LocationHistoryItem(location: updated));
    notifyListeners();
  }

  void stopLocationStream() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    _isTracking = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}
