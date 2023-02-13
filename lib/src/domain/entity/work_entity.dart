class WorkEntity {
  final String title;
  final String created;
  final String img;
  final String descriptions;
  final String? linkGoogle;
  final String? linkApple;
  final String? link;

  const WorkEntity({
    required this.title,
    required this.created,
    required this.img,
    required this.descriptions,
    this.linkGoogle,
    this.linkApple,
    this.link,
  });
}
