
import 'package:comic_world/cubits/search_suggestions/search_suggestions_state.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class SearchSuggestionsCubit extends Cubit<SearchSuggestionsState> {
  SearchSuggestionsCubit() : super(SearchSuggestionsInitialState());

  Timer? _debounce;
  String _lastQuery = '';

  void backToHome() {
    emit(SearchSuggestionsInitialState());
  }

  void getSuggestions({required String query}) {
    // لو المستخدم مسح الكلام
    if (query.isEmpty) {
      emit(SearchSuggestionsInitialState());
      return;
    }

    // منع تكرار نفس الكلمة
    if (query == _lastQuery) return;

    // إلغاء التايمر القديم
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    // عمل debounce
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      _lastQuery = query;

      final List<Map<String, dynamic>> data =
          await RequestData().fetchSuggestions(query: query);

      if (data.isNotEmpty) {
        emit(SuggestionsState(suggestions: data));
      } else {
        emit(NoSuggestionsState());
      }
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}