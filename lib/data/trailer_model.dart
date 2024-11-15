class TrailerModel {
  final String? name;
  final String? key;
  final String? site;
  final String? type;
  final bool? official;

  TrailerModel(
      {required this.name,
      required this.key,
      required this.site,
      required this.type,
      required this.official});

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
        name: json['name'],
        key: json['key'],
        site: json['site'],
        type: json['type'],
        official: json['official']);
  }
}
