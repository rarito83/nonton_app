import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/search_tv_shows.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  final testTvShow = <TvShow>[];
  const tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(testTvShow));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTvShow));
  });
}
