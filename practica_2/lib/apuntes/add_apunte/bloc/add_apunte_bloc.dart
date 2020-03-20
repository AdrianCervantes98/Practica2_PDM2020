import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

part 'add_apunte_event.dart';
part 'add_apunte_state.dart';

class AddApunteBloc extends Bloc<AddApunteEvent, AddApunteState> {
  File _chosenImage;
  String _url;
  @override
  AddApunteState get initialState => AddApunteInitial();

  @override
  Stream<AddApunteState> mapEventToState(
    AddApunteEvent event,
  ) async* {
    if (event is ChooseImageEvent) {
      bool imagePicked = await _chooseImage();
      if (imagePicked) {
        yield GetImageState(image: _chosenImage);
      } else {
        yield GetImageErrorState(
            errorMessage: "No se pudo seleccionar la imagen.");
      }
    } else if (event is UploadFileEvent) {
      bool fileUploaded = await _uploadFile();
      if (fileUploaded) {
        yield UploadedFileState(image: _url);
      } else {
        yield UploadedFileErrorState(errorMessage: "No se pudo cargar la imagen.");
      }
    }
  }

  Future<bool> _chooseImage() async {
    try {
      await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 720,
        maxWidth: 720,
      ).then((image) {
        _chosenImage = image;
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _uploadFile() async {
    try {
      String filePath = _chosenImage.path;
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("apuntes/${Path.basename(filePath)}");
      StorageUploadTask uploadTask = reference.putFile(_chosenImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        print("Link>>>>> $imageUrl");
      });

      reference.getDownloadURL().then((fileURL) {
        print("$fileURL");
        _url = fileURL;
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
