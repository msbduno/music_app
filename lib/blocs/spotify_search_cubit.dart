
/* 'package:bloc/bloc.dart';
import 'package:music_app/repositories/spotify_repository.dart';
import '../models/spotify_model.dart';

class SearchCubit extends Cubit<List<Track>> {
  final SpotifyRepository _spotifyRepository;

  SearchCubit(this._spotifyRepository) : super([]);

  void searchTracks(String query) async {
    emit([]);
    final tracks = await _spotifyRepository.searchTracks(query);
    emit(tracks);
  }
}

 */