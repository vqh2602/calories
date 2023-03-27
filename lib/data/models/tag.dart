/// id : 1
/// type : 1
/// name : "rau củ quả"
/// description : "rau củ quả"
/// created_at : "2023-03-23T14:03:37.000000Z"
/// updated_at : "2023-03-23T14:03:37.000000Z"

class Tag {
  Tag({
    num? id,
    num? type,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _type = type;
    _name = name;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Tag.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _type;
  String? _name;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  Tag copyWith({
    num? id,
    num? type,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      Tag(
        id: id ?? _id,
        type: type ?? _type,
        name: name ?? _name,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get type => _type;
  String? get name => _name;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['name'] = _name;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
