import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/entity/todos.dart';
import 'package:to_do_app/repo/tododao_repo.dart';

class AddToDoCubit extends Cubit<List<ToDoS>> {
  AddToDoCubit():super(<ToDoS>[]);

  var tdRepo = ToDoDaoRepo();

  Future<void> add(String yapilacak_is,String yapilacak_is_detay) async {
    await tdRepo.addToDo(yapilacak_is,yapilacak_is_detay);
  }
}