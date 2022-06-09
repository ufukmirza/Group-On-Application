import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';

import '../services/geolocator_service.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial()) {
    print("BURAYA GİRDİ");
    setCurrentLocation();
  }
  final geoLocatorService = GeolocatorService();
  Position? currentLocation;

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    emit(CurrentLocationState());
  }
}

abstract class MapState {}

class MapInitial extends MapState {}

class CurrentLocationState extends MapState {}
