import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/recent_researh_service.dart';
import '../states/recent_artists_state.dart';

class RecentArtistsCubit extends Cubit<RecentArtistsState> {
  final RecentSearchesService _searchesService;

  RecentArtistsCubit(this._searchesService) : super(RecentArtistsState());

  Future<void> loadRecentArtists() async {
    try {
      emit(RecentArtistsState(isLoading: true));
      final artists = await _searchesService.loadRecentArtists();
      emit(RecentArtistsState(artists: artists));
    } catch (e) {
      emit(RecentArtistsState(error: e.toString()));
    }
  }

  Future<void> removeArtist(String artistName) async {
    try {
      await _searchesService.removeSearch(artistName);
      await loadRecentArtists(); // Recharge la liste après suppression
    } catch (e) {
      emit(RecentArtistsState(error: e.toString()));
    }
  }
}