import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/entity/todos.dart';
import 'package:to_do_app/repo/tododao_repo.dart';

class HomeCubit extends Cubit<List<ToDoS>> {
  HomeCubit():super(<ToDoS>[]);

  var tdRepo = ToDoDaoRepo();

  Future<void> delete(int yapilacak_id) async {
    await tdRepo.deleteToDo(yapilacak_id);
    await allToDo();
  }

  Future<void> allToDo() async {
    var list = await tdRepo.allToDoS();
    emit(list);
  }

  Future<void> search(String searchWord) async {
    var list = await tdRepo.searchToDo(searchWord);
    emit(list);
  }
}