class RadioData {
  final int? id;
  final String? name;
  final String? url;
  final String? img;

  RadioData({this.id, this.name, this.url, this.img});

  factory RadioData.fromJson(Map<String, dynamic> json) {
    return RadioData(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'url': url, 'img': img};
  }
}
