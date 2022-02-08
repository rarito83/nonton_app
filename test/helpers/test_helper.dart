import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:nonton_app/data/datasources/db/database_helper.dart';
import 'package:nonton_app/data/datasources/movie_local_data_source.dart';
import 'package:nonton_app/data/datasources/movie_remote_data_source.dart';
import 'package:nonton_app/data/datasources/tv_show_local_data_source.dart';
import 'package:nonton_app/data/datasources/tv_show_remote_data_source.dart';
import 'package:nonton_app/domain/repositories/movie_repository.dart';
import 'package:nonton_app/domain/repositories/tv_show_repository.dart';

@GenerateMocks([
  MovieRepository,
  TvShowRepository,
  MovieRemoteDataSource,
  TvShowRemoteDataSource,
  MovieLocalDataSource,
  TvShowLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
