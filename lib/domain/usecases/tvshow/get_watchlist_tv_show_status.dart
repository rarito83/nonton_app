import 'package:nonton_app/domain/repositories/tv_show_repository.dart';

class GetWatchlistTvShowStatus {
  final TvShowRepository repository;

  GetWatchlistTvShowStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
