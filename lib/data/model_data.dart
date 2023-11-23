class ModelData {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  ModelData({this.postId, this.id, this.name, this.email, this.body});

  ModelData.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}