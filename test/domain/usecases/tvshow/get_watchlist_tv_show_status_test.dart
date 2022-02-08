import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_show_status.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShowStatus usecase;
  late MockTvShowRepository repository;
  setUp(() {
    repository = MockTvShowRepository();
    usecase = GetWatchlistTvShowStatus(repository);
  });
  test('return true when check availability at watchlist', () async {
    //arrange
    when(repository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    //act
    final result = await usecase.execute(1);
    //assert
    verify(repository.isAddedToWatchlist(1));
    expect(result, true);
  });
}