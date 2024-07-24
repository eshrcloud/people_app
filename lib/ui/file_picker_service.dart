import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FilePickerService {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<void> uploadFile(double vReqId, File file, String url) async {
    late String serverIP;
    late SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    serverIP = (sharedPreferences.getString('serverIP')! != '') ? sharedPreferences.getString('serverIP')! : 'http://103.47.185.240:99';
    String attachfileUrl = '/api/Attach_File/AttachFile/reqid=' + vReqId.toString();

    var request = http.MultipartRequest('POST', Uri.parse(attachfileUrl));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully.');
    } else {
      print('File upload failed.');
    }
  }
}