import 'package:learn_dart_together/24_04_01/data_source/results_api.dart';
import 'package:learn_dart_together/24_04_01/mapper/results_mapper.dart';
import 'package:learn_dart_together/24_04_01/model/photo.dart';
import 'package:learn_dart_together/24_04_01/model/results.dart';
import 'package:learn_dart_together/24_04_01/repository/results_repository.dart';

import 'package:learn_dart_together/24_04_01/result.dart';

class ResultsRepoImpl implements ResultsRepository {
  final ResultsApi _api;

  ResultsRepoImpl(this._api);

  @override
  Future<Result<Results>> getResults(String query) async {
    try {
      final resultsDto = await _api.getResults(query);
      final result = resultsDto.toResults();

      return Result.success(result);
    } catch (e) {
      return Result.error('알 수 없는 에러');
    }
  }

  @override
  Future<Result<List<Photo>>> getPhotos(String query) async {
    try {
      if (query == '바보') {
        return Result.error('비속어를 사용할 수 없습니다.');
      }
      final resultsDto = await _api.getResults(query);
      final results = resultsDto.toResults();
      final photoList = results.photo;

      return Result.success(photoList);
    } catch (e) {
      return Result.error('알 수 없는 네트워크 에러');
    }

// return resultsDto.toResults();
  }
}
