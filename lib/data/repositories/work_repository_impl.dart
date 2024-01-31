// ignore_for_file: avoid-dynamic

import 'package:logging/logging.dart';
import 'package:portfolio/data/models/work_model.dart';
import 'package:portfolio/domain/datasources/api_source.dart';
import 'package:portfolio/domain/entity/work_entity.dart';
import 'package:portfolio/domain/repositories/work_repository.dart';

class WorkRepositoryImpl extends WorkRepository {
  static final _log = Logger('WorkRepositoryImpl');
  final ApiSource _apiSource;

  WorkRepositoryImpl({required ApiSource apiSource}) : _apiSource = apiSource;

  @override
  Future<List<WorkEntity>> get() async {
    try {
      final res = await _apiSource.get<List<dynamic>>('/work.json');
      if (res != null) {
        return res.cast<Map<String, dynamic>>().map((json) => WorkModel.fromJson(json).toEntity()).toList();
      }
    } catch (exception, stack) {
      _log.severe('get', exception, stack);
    }

    return [];
  }
}
