part of 'details_bloc.dart';

enum DetailProcessingStatus { initial, loading, success, failure, complete }

class DetailsState extends Equatable {
  final DetailProcessingStatus processingStatus;

  DetailsState({this.processingStatus = DetailProcessingStatus.initial});

  DetailsState copyWith({
    DetailProcessingStatus? processingStatus,
  }) {
    return DetailsState(
      processingStatus: processingStatus ?? this.processingStatus,
    );
  }

  @override
  List<Object> get props => [processingStatus];
}
