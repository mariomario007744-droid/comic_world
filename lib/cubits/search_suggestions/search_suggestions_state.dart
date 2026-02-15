class SearchSuggestionsState {}

class SearchSuggestionsInitialState extends SearchSuggestionsState{}

class SuggestionsState extends SearchSuggestionsState{
  SuggestionsState({required this.suggestions});
  final List<Map<String, dynamic>> suggestions;
}

class NoSuggestionsState extends SearchSuggestionsState{}
