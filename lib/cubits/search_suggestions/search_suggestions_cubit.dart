import 'package:comic_world/cubits/search_suggestions/search_suggestions_state.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSuggestionsCubit extends Cubit<SearchSuggestionsState>{
  SearchSuggestionsCubit() : super(SearchSuggestionsInitialState());
  
  backToHome(){
    emit(SearchSuggestionsInitialState());
  }
  getSuggestions({required String query})async{
      final List<Map<String, dynamic>> data=await  RequestData().fetchSuggestions(query: query);
    if (data.isNotEmpty) {
  emit(SuggestionsState(suggestions: data));
}else if(data.isEmpty){
  emit(NoSuggestionsState());
}
  }
}