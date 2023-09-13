class SearchResultModel {
  int? id;
  int? uid;
  String? name;
  String? cover;
  int? status;
  double? distance;

  SearchResultModel(
      {this.id, this.uid, this.name, this.cover, this.status, this.distance});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    uid = int.parse(json['uid'].toString());
    name = json['name'];
    cover = json['cover'];
    status = int.parse(json['status'].toString());
    distance = double.parse(json['distance'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['cover'] = cover;
    data['status'] = status;
    data['distance'] = distance;
    return data;
  }
}
