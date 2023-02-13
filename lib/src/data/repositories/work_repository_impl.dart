import 'package:portfolio/src/data/models/work_model.dart';
import 'package:portfolio/src/domain/datasources/api_source.dart';
import 'package:portfolio/src/domain/entity/work_entity.dart';
import 'package:portfolio/src/domain/repositories/work_repository.dart';
import 'package:portfolio/src/utils/logger.dart';

class WorkRepositoryImpl extends WorkRepository {
  final ApiSource _apiSource;

  WorkRepositoryImpl({required ApiSource apiSource}) : _apiSource = apiSource;

  @override
  Future<List<WorkEntity>> get() async {
    try {
      final res = await _apiSource.get<List<dynamic>>('/work.json');
      if (res != null) {
        return res.cast<Map<String, dynamic>>().map((json) => WorkModel.fromJson(json)).toList();
      }
    } catch (exc, stack) {
      logger.e(exc, stack);
    }

    return [];
  }
}
