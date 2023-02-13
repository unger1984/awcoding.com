import 'package:portfolio/src/domain/entity/work_entity.dart';

abstract class WorkRepository {
  Future<List<WorkEntity>> get();
}
