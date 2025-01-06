import 'package:bloc/bloc.dart';

import '../repositories/discogs_repository.dart';
import '../states/discogs_artist_state.dart';

class DiscogsReleasesCubit extends Cubit<DiscogsReleasesState> {
  final DiscogsRepository _discogsRepository;

  DiscogsReleasesCubit(this._discogsRepository) : super(DiscogsReleasesState());

  Future<void> searchArtistsReleases(int query) async {
    try {
      emit(DiscogsReleasesState(isLoading: true));
      final searchResult = await _discogsRepository.fetchArtistReleases(query);
      emit(DiscogsReleasesState(releases: searchResult, error: null));
    } on Exception catch (e) {
      emit(DiscogsReleasesState(error: e.toString()));
    }
  }

}