// import 'package:file_picker/file_picker.dart';
//
// String selectedfile = '';
//   late XFile file;
//   late Uint8List selectedImageInByte;
//
//   bool imageset = false;
//   bool imagechange = false;
//   var _imageFile;
//   var fileEncoded;
//   final ImagePicker _picker = ImagePicker();
//   var imagepath;
//
//
//
// captureImage()async {
//   var picked = await FilePicker.platform.pickFiles();
//   if (picked != null) {
//     print(picked.files.first.name);
//
//     setState((){
//       imagechange = true;
//       imageset = true;
//       selectedImageInByte = picked.files.first.bytes!;
//     });
//
//     // String base64String = base64Encode(selectedImageInByte);
//     // print(selectedImageInByte);
//     var mimeType = lookupMimeType(picked.files.first.name);
//     fileEncoded =  "data:${mimeType};base64,${base64Encode(selectedImageInByte!)}";
//     // print(fileEncoded);
//     // print('her is file mime ${mimeType}');
//   }
// }