import 'package:portfolio/domain/entity/work_entity.dart';

class WorkModel {
  final String title;
  final String created;
  final String img;
  final String descriptions;
  final String? linkGoogle;
  final String? linkApple;
  final String? link;

  const WorkModel({
    required this.title,
    required this.created,
    required this.img,
    required this.descriptions,
    this.linkGoogle,
    this.linkApple,
    this.link,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
        title: json['title'] as String,
        created: json['created'] as String,
        img: json['img'] as String,
        descriptions: json['descriptions'] as String,
        linkGoogle: json['linkGoogle'] as String?,
        linkApple: json['linkApple'] as String?,
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'created': created,
        'descriptions': descriptions,
        'img': img,
        'link': link,
        'linkApple': linkApple,
        'linkGoogle': linkGoogle,
        'title': title,
      };

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
