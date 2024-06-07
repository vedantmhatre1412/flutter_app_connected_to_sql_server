import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async{
  final ImagePicker imagePicker=ImagePicker();
  XFile? _file= await imagePicker.pickImage(source: imageSource);
  if(_file !=null){
    return await _file.readAsBytes();
  }
}