import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/discogs_repository.dart';
import '../states/discogs_search_state.dart';

class DiscogsSearchCubit extends Cubit<DiscogsSearchState> {
  final DiscogsRepository _discogsRepository;

  DiscogsSearchCubit(this._discogsRepository) : super(DiscogsSearchState());

  Future<void> searchArtists(String query) async {
    if (query.isNotEmpty) {
      try {
        emit(DiscogsSearchState(isLoading: true));
        final searchResult = await _discogsRepository.fetchArtistData(query);
        emit(DiscogsSearchState(results: searchResult, error: null));
      } on Exception catch (e) {
        emit(DiscogsSearchState(error: e.toString()));
      }
    }
  }
}