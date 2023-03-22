import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/src/domain/entity/work_entity.dart';

part 'work_model.freezed.dart';
part 'work_model.g.dart';

@freezed
class WorkModel with _$WorkModel {
  const WorkModel._();

  const factory WorkModel({
    required String title,
    required String created,
    required String img,
    required String descriptions,
    String? linkGoogle,
    String? linkApple,
    String? link,
  }) = _WorkModel;

  factory WorkModel.fromJson(Map<String, dynamic> json) => _$WorkModelFromJson(json);

  WorkEntity toEntity() => WorkEntity(
        title: title,
        created: created,
        img: img,
        descriptions: descriptions,
        linkGoogle: linkGoogle,
        linkApple: linkApple,
        link: link,
      );
}
