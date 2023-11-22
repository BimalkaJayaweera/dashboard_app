import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/Model.dart';

Future<List<Model>> getModel() async{

  const String username = '';
  const String password = '';
  var url = Uri.parse('http://13.229.233.203/apiman/index.php/datalayer/general');
  // Create the request headers for basic authentication
  final Map<String, String> headers = {
    'Authorization': 'Basic ' + base64Encode(utf8.encode('$username:$password')),
    'Content-Type': 'application/json',
  };

  // Create the JSON request body
  final Map requestBody = {
    'apiName': 'AccSubContractor',
  };

  final String jsonBody = jsonEncode(requestBody);
  late http.Response response;
  List<Model> modelArr = [];

  try {
    response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      // Request was successful
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> model = data['results'];

      for(var item in model){
        var gender = item['month'];
        var postcode = item['price'];
        var color = item['color'];
        Model model1 = Model(gender, postcode, color);
        modelArr.add(model1);
      }
    }
    else
    {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }

  return modelArr;
}
