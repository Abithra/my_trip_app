// trip_place_bloc.dart
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:my_trip_flutter_app/data/bloc/trip_place_bloc/trip_place_event.dart';
import 'package:my_trip_flutter_app/data/bloc/trip_place_bloc/trip_place_state.dart';
import '../../model/trip_place.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(const TripLoaded(tripPlaces: [])) {
    on<LoadTripData>((event, emit) async {
      try {
        String jsonData = await rootBundle.loadString('assets/places.json');
        List<dynamic> jsonList = json.decode(jsonData);

        List<TripPlace> tripPlaces = jsonList
            .map((data) => TripPlace(
                  tripPlace: data['tripPlace'],
                  locationWithCityName: data['locationWithCityName'],
                  locationName: data['locationName'],
                  rating: (data['rating'] as num).toDouble(),
                  numberOfRating: data['numberOfRating'] as int,
                  numberOfPersons: data['numberOfPersons'] as int,
                  description: data['description'],
                ))
            .toList();

        emit(TripLoaded(tripPlaces: tripPlaces));
      } catch (e) {
        emit(TripError("Error loading trip data: $e"));
      }
    });
  }

  @override
  Stream<TripState> mapEventToState(TripEvent event) async* {
    if (event is LoadTripData) {
      yield* _mapLoadTripDataToState(event);
    }
  }

  Stream<TripState> _mapLoadTripDataToState(LoadTripData event) async* {
    try {
      String jsonData = await rootBundle.loadString('assets/places.json');
      List<dynamic> jsonList = json.decode(jsonData);

      List<TripPlace> tripPlaces = jsonList
          .map((data) => TripPlace(
                tripPlace: data['tripPlace'],
                locationWithCityName: data['locationWithCityName'],
                locationName: data['locationName'],
                rating: (data['rating'] as num).toDouble(),
                numberOfRating: data['numberOfRating'] as int,
                numberOfPersons: data['numberOfPersons'] as int,
                description: data['description'],
              ))
          .toList();

      yield TripLoaded(tripPlaces: tripPlaces);
    } catch (e) {
      yield TripError("Error loading trip data: $e");
    }
  }
}
