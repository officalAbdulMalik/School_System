import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/news_events_api.dart';
import 'package:school_system/models/news_events_model.dart';

part 'events_newz_state.dart';

class EventsNewsCubit extends Cubit<EventsNewsState> {
  EventsNewsCubit() : super(EventsNewsInitial());

  getEventsNews() async {
    await Future.delayed(Duration.zero);

    emit(EventsNewsLoading());

    try {
      await GetNewsEvents.getData().then((value) {
        if (value['error'] == false) {
          List<NewsEvents> events = List<NewsEvents>.from(
              value['data'].map((x) => NewsEvents.fromMap(x)));
          emit(EventsNewsLoaded(newsEvents: events));
        } else {
          emit(EventsNewsError(error: value['error']));
        }
      }).catchError((e) {
        emit(EventsNewsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(EventsNewsError(error: e.toString()));
      rethrow;
    }
  }
}
