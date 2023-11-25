import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/add_school_api.dart';

part 'add_new_school_state.dart';

class AddNewSchoolCubit extends Cubit<AddNewSchoolState> {
  AddNewSchoolCubit() : super(AddNewSchoolInitial());

  addSchool(var data, var image) async {
    await Future.delayed(Duration.zero);

    emit(AddNewSchoolLoading());


    try {
      await AddSchoolApi.addSchool(data, image)
          .then((value) {
        if (value['success'] == true) {
          emit(AddNewSchoolLoaded());
        } else {
          emit(AddNewSchoolError(error: value['error']));
        }
      }).catchError((e) {
        emit(AddNewSchoolError(error: 'Some Thing Wrong'));
      });
    } catch (e) {
      emit(AddNewSchoolError(error: e.toString()));
    }
  }
}