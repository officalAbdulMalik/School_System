
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/Data/Repository/get_partciption.dart';
import 'package:school_system/Models/participations.dart';

part 'get_parents_teachers_state.dart';

class GetParentsTeachersCubit extends Cubit<GetAllParentsState> {
  GetParentsTeachersCubit() : super(GetAllParentsInitial());

  Future getParentsTeachers(String enPoint) async {
    await Future.delayed(Duration.zero);

    emit(GetAllParentsLoading());

    try {
      GetParticipation.getData(enPoint).then((value) {
        if (value['error'] == false) {
          List<Participation> data = List<Participation>.from(
              value['data'].map((x) => Participation.fromJson(x)));

          List<bool> checkboxStates = [];

          checkboxStates =
              List.generate(value['data'].length, (index) => false);

          emit(GetAllParentsLoaded(checkList: checkboxStates,model: data));
        } else {
          emit(GetAllParentsError(error: value['message']));
        }
      }).catchError((e) {
        emit(GetAllParentsError(error: e.toString()));
        throw e;
      });
    } catch (e) {
      emit(GetAllParentsError(error: e.toString()));
      rethrow;
    }

    /// theses api same call on multiple side like parents and teachers so from torp means the apis is call for teachers or parents
  }

  emitFirstState() {
    emit(GetAllParentsFirstState());
  }
}
