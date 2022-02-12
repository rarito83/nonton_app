import 'package:equatable/equatable.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/entities/tv_show_detail.dart';

class TvShowTable extends Equatable {
  const TvShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  factory TvShowTable.fromJson(Map<String, dynamic> json) => TvShowTable(
        id: json["id"],
        name: json["name"],
        posterPath: json["posterPath"],
        overview: json["overview"],
      );

  TvShow toEntity() => TvShow.watchlist(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
