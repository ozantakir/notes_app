import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/add_todo_cubit.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/views/home.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {

  var tfToDo = TextEditingController();
  var tfExplanation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    return Scaffold(
      backgroundColor: Color(0xFF09132D),
      appBar: AppBar(title: Text("Add Note"),
          backgroundColor: Colors.black38
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth*0.1,right: screenWidth*0.1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: tfToDo,
                  decoration: InputDecoration(
                    hintText: "Title",
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
                      hintText: "Explanation",
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
                  context.read<AddToDoCubit>().add(tfToDo.text,tfExplanation.text);
                  Navigator.pop(context);
                }, child: Text("SAVE")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
