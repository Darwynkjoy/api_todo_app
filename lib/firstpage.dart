import 'dart:convert';

import 'package:api_todo_app/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Firstpage extends StatefulWidget{
  Firstpage({super.key});
  @override
  State<Firstpage> createState()=> _firstpageState();
}

class _firstpageState extends State<Firstpage>{
  bool _isLoading=true;
  @override
  void initState(){
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
        title: Text("TODO APP",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
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
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.amber),
            borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ID                    : ${data.id}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  Text("TODO             : ${data.todo}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  Text("USER ID         : ${data.userId}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  Text("COMPLETED: ${data.completed}",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  ],
              ),
            ),
          ),
        );
      }, separatorBuilder: (context,index){
        return SizedBox(height: 5,);
        }, itemCount: dataFromAPI!.todos.length,        
        )
    );
  }
}