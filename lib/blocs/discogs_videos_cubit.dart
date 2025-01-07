import 'package:bloc/bloc.dart';

import '../repositories/discogs_repository.dart';
import '../states/discogs_videos_state.dart';

class DiscogsVideosCubit extends Cubit<DiscogsVideosState> {
  final DiscogsRepository _discogsRepository;

  DiscogsVideosCubit(this._discogsRepository) : super(DiscogsVideosState());

  Future<void> searchArtistsVideos(int query) async {
    try {
      emit(DiscogsVideosState(isLoading: true));
      final searchResult = await _discogsRepository.fetchReleaseVideos(query);
      emit(DiscogsVideosState(videos: searchResult, error: null));
    } on Exception catch (e) {
      emit(DiscogsVideosState(error: e.toString()));
    }
  }

}