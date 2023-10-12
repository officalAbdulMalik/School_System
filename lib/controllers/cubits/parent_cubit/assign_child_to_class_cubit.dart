import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/assign_child.dart';

part 'assign_child_to_class_state.dart';

class AssignChildToClassCubit extends Cubit<AssignChildToClassState> {
  AssignChildToClassCubit() : super(AssignChildToClassInitial());

  assign(String stId, String classId) async {
    await Future.delayed(Duration.zero);

    emit(AssignChildToClassLoading());

    await AssignChild.assign(
      classId: classId,
      studentId: stId,
    ).then((value) {
      if (value == 200) {
        emit(AssignChildToClassLoaded());
      } else {
        emit(AssignChildToClassError(error: value['message']));
      }
    }).catchError((e) {
      emit(AssignChildToClassError(error: "Some Thing Wrong"));
      throw e;
    });
  }
}
