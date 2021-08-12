import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsState());

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is ProcessDetails) {
      yield* _mapProcessDetailsToState(state);
    }
  }

  Stream<DetailsState> _mapProcessDetailsToState(DetailsState state) async* {
    yield state.copyWith(processingStatus: DetailProcessingStatus.loading);

    var result = await Future.delayed(Duration(seconds: 3), () => Future.value(true));

    if (result == true) {
      yield state.copyWith(processingStatus: DetailProcessingStatus.success);
    }
  }
}
