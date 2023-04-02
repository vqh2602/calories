/// id : 1
/// height : 165
/// weight : 55
/// user_id : 1
/// created_at : "2023-04-02T10:16:53.000000Z"
/// updated_at : "2023-04-02T10:16:53.000000Z"

class UserBmi {
  UserBmi({
      num? id, 
      num? height, 
      num? weight, 
      num? userId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _height = height;
    _weight = weight;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  UserBmi.fromJson(dynamic json) {
    _id = json['id'];
    _height = json['height'];
    _weight = json['weight'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _height;
  num? _weight;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
UserBmi copyWith({  num? id,
  num? height,
  num? weight,
  num? userId,
  String? createdAt,
  String? updatedAt,
}) => UserBmi(  id: id ?? _id,
  height: height ?? _height,
  weight: weight ?? _weight,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get height => _height;
  num? get weight => _weight;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['height'] = _height;
    map['weight'] = _weight;
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}