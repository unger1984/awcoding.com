import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/src/domain/entity/work_entity.dart';
import 'package:portfolio/src/domain/repositories/work_repository.dart';

part 'work_bloc.freezed.dart';

@freezed
class WorkEvent with _$WorkEvent {
  const WorkEvent._();
  const factory WorkEvent.init() = InitWorkEvent;
}

@freezed
class WorkState with _$WorkState {
  const WorkState._();
  const factory WorkState.loading() = LoadingWorkState;
  const factory WorkState.success(List<WorkEntity> list) = SuccessWorkState;
}

class WorkBLoC extends Bloc<WorkEvent, WorkState> {
  final WorkRepository _workRepository;

  WorkBLoC({required WorkRepository workRepository})
      : _workRepository = workRepository,
        super(const LoadingWorkState()) {
    on<WorkEvent>(
      (event, emitter) => event.map(
        init: (event) => _init(event, emitter),
      ),
    );
    add(const InitWorkEvent());
  }

  Future<void> _init(_, Emitter<WorkState> emitter) async {
    emitter(const LoadingWorkState());
    final works = await _workRepository.get();
    emitter(SuccessWorkState(works));
  }
}
