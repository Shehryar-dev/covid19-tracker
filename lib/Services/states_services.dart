import 'dart:convert';

import 'package:covid_app/Models/WorldStatesModel.dart';
import 'package:covid_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{
  Future<WorldStatesModel>  fetchWorldStatesRecord() async{
   final response = await http.get(Uri.parse(AppUrl.worldStateApi));

   if(response.statusCode == 200){
     var data = jsonDecode(response.body.toString());
     return WorldStatesModel.fromJson(data);
   }else{
     throw Exception('Error');
   }
  }

  Future<List<dynamic>> CountryListApi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesApi));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }
}
