import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/update_profile.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  editProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? language,
    String? title,
    String? about,
    String? occupation,
    String? dob,
    String? gender,
    String? image,
  }) async {
    await Future.delayed(Duration.zero);

    emit(EditProfileLoading());

    try {
      await UpdateProfile.updateProfile(
              firstName: firstName!,
              lastName: lastName!,
              email: email!,
              language: language!,
              title: title!,
              about: about!,
              occupation: occupation!,
              dob: dob!,
              gender: gender!,
              image: image!)
          .then((value) {
        if (value['status'] == 200) {
          emit(EditProfileLoaded());
        } else {
          emit(EditProfileError(error: 'Some Thing Wrong'));
        }
      });
    } catch (e) {
      emit(EditProfileError(error: e.toString()));
    }
  }
}
