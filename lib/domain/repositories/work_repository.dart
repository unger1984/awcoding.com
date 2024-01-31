import 'package:portfolio/domain/entity/work_entity.dart';

abstract class WorkRepository {
  Future<List<WorkEntity>> get();
}
