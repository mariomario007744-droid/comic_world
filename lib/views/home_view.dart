import 'package:comic_world/cubits/search_suggestions/search_suggestions_cubit.dart';
import 'package:comic_world/cubits/search_suggestions/search_suggestions_state.dart';
import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/comic_view.dart';
import 'package:comic_world/widgets/custom_home_app_bar.dart';
import 'package:comic_world/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  final String id='HomeView';

  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => SearchSuggestionsCubit(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CustomHomeAppBar(),
                ),
                Stack(
                  children: [
                    const HomeBody(),
                    BlocBuilder<SearchSuggestionsCubit, SearchSuggestionsState>(
                      builder: (context, state) {
                        if (state is SearchSuggestionsInitialState) {
                          return const SizedBox(
                            height: 0,
                            width: 0,
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              if (context.mounted) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<SearchSuggestionsCubit>(
                                  context,
                                ).backToHome();
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 120,
                              color: Colors.black.withValues(alpha: 0.6),
                              child: state is SuggestionsState
                                  ? ListView.builder(
                                      itemCount: state.suggestions.length,
                                      itemBuilder: (context, index) {
                                        return ElevatedButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.white
                                                .withValues(alpha: 0.2),
                                          ),
                                          onPressed: () async {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();

                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            );
                                            final data = await RequestData()
                                                .fetchOneComic(
                                                  id: state
                                                      .suggestions[index]['id'],
                                                );
                                            BlocProvider.of<
                                                  SearchSuggestionsCubit
                                                >(context)
                                                .backToHome();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ComicView(
                                                    data: ComicModel.fromJson(
                                                      data,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            state.suggestions[index]['name'],
                                            style: TextStyle(color: kTextColor),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Text(
                                        'لا توجد اقتراحات',
                                        style: TextStyle(color: kTextColor),
                                      ),
                                    ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
