// trip_place_state.dart
import 'package:equatable/equatable.dart';
import '../../model/trip_place.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object?> get props => [];
}

class TripError extends TripState {
  final String errorMessage;

  const TripError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class TripLoaded extends TripState {
  final List<TripPlace> tripPlaces;

  const TripLoaded({required this.tripPlaces});

  @override
  List<Object?> get props => [tripPlaces];
}
