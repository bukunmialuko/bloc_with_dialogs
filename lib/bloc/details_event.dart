part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProcessDetails extends DetailsEvent {}
