import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/add_child_api.dart';

part 'add_child_state.dart';

class AddChildCubit extends Cubit<AddChildState> {
  AddChildCubit() : super(AddChildInitial());

  addChild({
    required String firstName,
    required String lastName,
    required String relation,
    required String dob,
    required String gender,
    required String image,
  }) async {
    await Future.delayed(Duration.zero);

    emit(AddChildLoading());

    await AddChildRepo.addChild(
            firstName: firstName,
            lastName: lastName,
            dob: dob,
            relation: relation,
            gender: gender,
            image: image)
        .then((value) {
      if (value == 200) {
        emit(AddChildLoaded());
      } else {
        emit(AddChildError(error: value['error']));
      }
    }).catchError((e) {
      emit(AddChildError(error: "Some Thing Wrong"));
      throw e;
    });
  }
}
