part of 'add_apunte_bloc.dart';

abstract class AddApunteState extends Equatable {
  const AddApunteState();
}

class AddApunteInitial extends AddApunteState {
  @override
  List<Object> get props => [];
}

class GetImageState extends AddApunteState {
  final File image;

  GetImageState({
    @required this.image
  });
  @override
  List<Object> get props => [image];
}

class GetImageErrorState extends AddApunteState {
  final String errorMessage;

  GetImageErrorState({
    @required this.errorMessage
  });
  @override
  List<Object> get props => [errorMessage];
}

class UploadedFileState extends AddApunteState {
  final String image;

  UploadedFileState({
    @required this.image
  });
  @override
  List<Object> get props => [image];
}

class UploadedFileErrorState extends AddApunteState {
  final String errorMessage;

  UploadedFileErrorState({
    @required this.errorMessage
  });
  @override
  List<Object> get props => [errorMessage];
}
