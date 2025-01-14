import 'dart:convert';

import 'package:api_todo_app/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Firstpage extends StatefulWidget{
  @override
  State<Firstpage> createState()=> _firstpageState();
}

class _firstpageState extends State<Firstpage>{
  bool _isLoading=true;

  void initstate(){
    super.initState();
    _getData();
  }

  Todomodelapi? dataFromAPI;

  
  _getData()async{
    try{
      String url="https://dummyjson.com/todos";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        dataFromAPI=Todomodelapi.fromJson(json.decode(res.body));
        _isLoading=false;
        setState(() { });
      }
    }
    catch (e){
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo app"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: _isLoading?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
      :dataFromAPI == null?
      Center(
        child: Text("Failed to load data"),
      )
      :ListView.separated(itemBuilder: (context,index){
        final data=dataFromAPI!.todos[index];
        return ListTile(
          title: Text("${data.id}"),

        );
      }, separatorBuilder: (context,index){
        return SizedBox(height: 5,);
        }, itemCount: dataFromAPI!.todos.length)
    );
  }
}