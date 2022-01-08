import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/home_cubit.dart';
import 'package:to_do_app/entity/todos.dart';
import 'package:to_do_app/views/add_todo.dart';
import 'package:to_do_app/views/todo_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isSearching = false;
  bool focus = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().allToDo();
  }

  @override
  Widget build(BuildContext context) {
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    return Scaffold(
      backgroundColor: Color(0xFF09132D),
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: isSearching ?
        TextField(autofocus: focus,style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: "Ara",hintStyle: TextStyle(color:Colors.white)),onChanged: (result){
          context.read<HomeCubit>().search(result);
        },) :
        Text("Yapılacaklar"),
        actions: [
          isSearching ?
              IconButton(onPressed: (){
                context.read<HomeCubit>().allToDo();
                setState(() { isSearching = false;
                focus = false;});
              }, icon: Icon(Icons.cancel)) :
              IconButton(onPressed: (){
                setState(() {isSearching = true;
                focus = true;});

                }, icon: Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<HomeCubit,List<ToDoS>>(
        builder: (context,todoList){
          if(todoList.isNotEmpty){
            return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context,index){
                var todo = todoList[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoDetails(todo: todo))).then((_){
                      context.read<HomeCubit>().allToDo();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.blueGrey,
                      child: SizedBox(
                        height: screenHeight*0.1,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text("${todo.yapilacak_is}",style: TextStyle(fontSize: screenHeight*0.025,color: Colors.white),),
                            ),
                            Spacer(),
                            IconButton(onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black38,
                                  content: SizedBox(
                                      height: screenHeight*0.05 ,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("${todo.yapilacak_is} silinsin mi?",style: TextStyle(fontSize: screenHeight*0.02),),
                                        ],
                                      )),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    textColor: Colors.white,
                                    onPressed: (){
                                      context.read<HomeCubit>().delete(todo.yapilacak_id);
                                    },
                                  ),
                                ),
                              );
                            }, icon: Icon(Icons.delete_outline,color: Colors.black,))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddToDo())).then((_) {
            context.read<HomeCubit>().allToDo();
          });
        },
        child: Icon(Icons.add,size: screenWidth*0.1,),
        backgroundColor: Colors.red,
      ),
    );
  }
}
