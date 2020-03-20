part of 'add_apunte_bloc.dart';

abstract class AddApunteEvent extends Equatable {
  const AddApunteEvent();
}

class InitEvent extends AddApunteEvent {
  @override
  List<Object> get props => [];
}

class ChooseImageEvent extends AddApunteEvent {
  @override
  List<Object> get props => [];
}

class UploadFileEvent extends AddApunteEvent {
  final File image;
  UploadFileEvent({
    @required this.image,
  });
  
  @override
  List<Object> get props => [image];
}


