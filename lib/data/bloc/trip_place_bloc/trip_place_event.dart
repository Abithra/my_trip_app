import 'package:equatable/equatable.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

class LoadTripData extends TripEvent {}
