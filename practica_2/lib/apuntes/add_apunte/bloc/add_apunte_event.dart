part of 'add_apunte_bloc.dart';

abstract class AddApunteEvent extends Equatable {
  const AddApunteEvent();
}

class ChooseImageEvent extends AddApunteEvent {
  final File image;

  ChooseImageEvent({
    @required this.image
  });

  @override
  List<Object> get props => [image];
}

class UploadFileEvent extends AddApunteEvent {
  final String image;

  UploadFileEvent({
    @required this.image,
  });
  
  @override
  List<Object> get props => [image];
}


