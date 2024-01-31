import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/domain/entity/work_entity.dart';
import 'package:portfolio/domain/repositories/work_repository.dart';

sealed class WorkEvent {
  const WorkEvent();
  const factory WorkEvent.init() = _InitWorkEvent;
}

class _InitWorkEvent extends WorkEvent {
  const _InitWorkEvent();
}

sealed class WorkState {
  const WorkState();
  const factory WorkState.loading() = LoadingWorkState;
  const factory WorkState.success(List<WorkEntity> list) = SuccessWorkState;
}

class LoadingWorkState extends WorkState {
  const LoadingWorkState();
}

class SuccessWorkState extends WorkState {
  final List<WorkEntity> list;
  const SuccessWorkState(this.list);
}

class WorkBLoC extends Bloc<WorkEvent, WorkState> {
  final WorkRepository _workRepository;

  WorkBLoC({required WorkRepository workRepository})
      : _workRepository = workRepository,
        super(const WorkState.loading()) {
    on<WorkEvent>(
      (event, emitter) => switch (event) {
        _InitWorkEvent() => _init(emitter),
      },
    );
    add(const WorkEvent.init());
  }

  Future<void> _init(Emitter<WorkState> emitter) async {
    emitter(const WorkState.loading());
    final works = await _workRepository.get();
    emitter(WorkState.success(works));
  }
}
