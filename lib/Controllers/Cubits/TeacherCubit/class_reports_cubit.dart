import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_class_reports.dart';
import 'package:school_system/Models/TeacherModels/class_reports.dart';

part 'class_reports_state.dart';

class ClassReportsCubit extends Cubit<ClassReportsState> {
  ClassReportsCubit() : super(ClassReportsInitial());

  getReports(String classId) async {
    await Future.delayed(Duration.zero);

    emit(ClassReportsLoading());

    try {
      await GetClassReports.getData(classId).then((value) {
        if (value['error'] == false) {
          List<ShowClassReports> reports = List<ShowClassReports>.from(
              value['data']['data'].map((x) => ShowClassReports.fromMap(x)));

          emit(ClassReportsLoaded(
              reports: reports,
              counts: value['data']['reports'].toString(),
              published: value['data']['published'].toString()));
        } else {
          emit(ClassReportsError(error: value['message']));
        }
      }).catchError((e) {
        emit(ClassReportsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(ClassReportsError(error: e.toString()));
      rethrow;
    }
  }
}
