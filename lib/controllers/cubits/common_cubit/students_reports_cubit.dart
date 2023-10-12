import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_students_reports.dart';
import 'package:school_system/models/students_reports.dart';

part 'students_reports_state.dart';

class StudentsReportsCubit extends Cubit<StudentsReportsState> {
  StudentsReportsCubit() : super(StudentsReportsInitial());

  getReports(String id) async {
    await Future.delayed(Duration.zero);

    emit(StudentsReportsLoading());
    try {
      await GetStudentsReports().getStudentsReports(id).then((value) {
        if (value['error'] == false) {
          var reports = List<StudentReports>.from(
              value['data'].map((x) => StudentReports.fromJson(x)));
          emit(StudentsReportsLoaded(
            reports: reports,
          ));
        }
      }).catchError((e) {
        emit(StudentsReportsError(error: "Some Thing Wrong"));
      });
    } catch (e) {
      emit(StudentsReportsError(error: e.toString()));
    }
  }
}
