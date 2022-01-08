import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:to_do_app/cubit/todo_details_cubit.dart';
import 'package:to_do_app/entity/todos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ToDoDetails extends StatefulWidget {
  ToDoS todo;


  ToDoDetails({required this.todo});

  @override
  _ToDoDetailsState createState() => _ToDoDetailsState();
}

class _ToDoDetailsState extends State<ToDoDetails> {

  var tfYapilacakIs = TextEditingController();
  var tfExplanation = TextEditingController();

  @override
  void initState() {
    super.initState();
    var todo = widget.todo;
    tfYapilacakIs.text = todo.yapilacak_is;
    tfExplanation.text = todo.yapilacak_is_detay;
  }

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    return Scaffold(
      backgroundColor: Color(0xFF09132D),
      appBar: AppBar(title: Text("Yapılacak İş"),backgroundColor: Colors.black38),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth*0.1,right: screenWidth*0.1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: tfYapilacakIs,
                  decoration: InputDecoration(
                    hintText: "Başlık",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight*0.05,bottom: screenHeight*0.08),
                  child: TextField(
                    controller: tfExplanation,
                    minLines: (screenHeight*0.02).toInt(),
                    maxLines: (screenHeight*0.02).toInt(),
                    decoration: InputDecoration(
                      hintText: "Açıklama",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red
                    ),
                    onPressed: (){
                  context.read<ToDoDetailsCubit>().update(widget.todo.yapilacak_id, tfYapilacakIs.text,tfExplanation.text);
                  Navigator.pop(context);
                }, child: Text("GÜNCELLE"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
