import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/entity/todos.dart';
import 'package:to_do_app/repo/tododao_repo.dart';

class ToDoDetailsCubit extends Cubit<List<ToDoS>> {
  ToDoDetailsCubit():super(<ToDoS>[]);

  var tdRepo = ToDoDaoRepo();


  Future<void> update(int yapilacak_id,String yapilacak_is,String yapilacak_is_detay) async {
    await tdRepo.updateToDo(yapilacak_id, yapilacak_is,yapilacak_is_detay);
  }






}