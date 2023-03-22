import 'package:get_it/get_it.dart';
import 'package:portfolio/src/data/datasources/api_source_dio.dart';
import 'package:portfolio/src/data/repositories/work_repository_impl.dart';
import 'package:portfolio/src/domain/repositories/work_repository.dart';

Future<void> setupGetIt() async {
  final apiSource = ApiSourceDio(baseUrl: '');
  final workRepository = WorkRepositoryImpl(apiSource: apiSource);

  GetIt.I.registerSingleton<WorkRepository>(workRepository);
}
