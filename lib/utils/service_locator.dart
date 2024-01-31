import 'package:get_it/get_it.dart';
import 'package:portfolio/data/datasources/api_source_dio.dart';
import 'package:portfolio/data/repositories/work_repository_impl.dart';
import 'package:portfolio/domain/repositories/work_repository.dart';

class ServiceLocator {
  static void setup() {
    final apiSource = ApiSourceDio(baseUrl: '');
    final workRepository = WorkRepositoryImpl(apiSource: apiSource);

    GetIt.I.registerSingleton<WorkRepository>(workRepository);
  }
}
