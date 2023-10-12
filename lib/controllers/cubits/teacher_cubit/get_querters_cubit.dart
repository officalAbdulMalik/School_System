import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_querter.dart';
import 'package:school_system/models/quarters.dart';

part 'get_querters_state.dart';

class GetQuertersCubit extends Cubit<GetQuertersState> {
  GetQuertersCubit() : super(GetQuertersInitial());

  getQuarters() async {
    emit(GetQuertersLoading());

    try {
      await GetQuerters.getData().then((value) {
        if (value['error'] != null && value['error'] == false) {
          var section = List<Quarters>.from(
              value['quarters'].map((x) => Quarters.fromMap(x)));
          emit(GetQuertersLoaded(list: section));
        } else {
          emit(GetQuertersError(error: value['message']));
        }
      }).catchError((e) {
        emit(GetQuertersError(error: 'Some Thing Wrong Try Again'));
        throw e;
      });
    } catch (e) {
      emit(GetQuertersError(error: e.toString()));
      rethrow;
    }
  }
}
