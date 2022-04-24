import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/models/timeline_zoom.dart';

class ZoomCubit extends Cubit<TimelineZoom> {
  ZoomCubit(TimelineZoom initialState) : super(initialState);

  void zoomIn() {
    switch (state) {
      case TimelineZoom.year:
        {
          emit(TimelineZoom.month);
          break;
        }
      case TimelineZoom.month:
        {
          emit(TimelineZoom.day);
          break;
        }
      case TimelineZoom.day:
        {
          emit(TimelineZoom.shortDescription);

          break;
        }
      case TimelineZoom.shortDescription:
        {
          emit(TimelineZoom.fullDescription);

          break;
        }
      case TimelineZoom.fullDescription:
        {
          emit(TimelineZoom.fullDescription);

          break;
        }
    }
  }

  void zoomOut() {
    switch (state) {
      case TimelineZoom.year:
        {
          emit(TimelineZoom.year);
          break;
        }
      case TimelineZoom.month:
        {
          emit(TimelineZoom.year);
          break;
        }
      case TimelineZoom.day:
        {
          emit(TimelineZoom.month);

          break;
        }
      case TimelineZoom.shortDescription:
        {
          emit(TimelineZoom.day);

          break;
        }
      case TimelineZoom.fullDescription:
        {
          emit(TimelineZoom.shortDescription);

          break;
        }
    }
  }
}
