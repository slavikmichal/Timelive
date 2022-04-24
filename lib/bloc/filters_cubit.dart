import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/models/tag.dart';

class FiltersCubit extends Cubit<List<Tag>> {
  late List<Tag> activeTags = [];

  FiltersCubit() : super([]);

  void setFilters(List<Tag> filters) {
    activeTags = filters;
    emit(filters);
  }

}