// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calories/data/models/tag.dart';

class Food {
  num? _id;
  String? _name;
  String? _image;
  String? _description;
  num? _calo;
  String? _createdAt;
  String? _updatedAt;
  num? _tagId;
  Tag? _tag;

  Food({
    num? id,
    String? name,
    String? image,
    String? description,
    num? calo,
    String? createdAt,
    String? updatedAt,
    num? tagId,
    Tag? tag,
  }) {
    if (id != null) {
      _id = id;
      _name = name;
      _image = image;
      _description = description;
      _calo = calo;
      _createdAt = createdAt;
      _updatedAt = updatedAt;
      _tagId = tagId;
      _tag = tag;
    }
  }

  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get description => _description;
  num? get calo => _calo;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get tagId => _tagId;
  Tag? get tag => _tag;

  Food.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _description = json['description'];
    _calo = json['calo'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _tagId = json['tag_id'];
    _tag = json['tag'] != null ? Tag.fromJson(json['tag']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['image'] = _image;
    data['description'] = _description;
    data['calo'] = _calo;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['tag_id'] = _tagId;
    if (_tag != null) {
      data['tag'] = _tag!.toJson();
    }
    return data;
  }

  Food copyWith({
    num? id,
    String? name,
    String? image,
    String? description,
    num? calo,
    String? createdAt,
    String? updatedAt,
    num? tagId,
    Tag? tag,
  }) {
    return Food(
      id: _id ?? _id,
      name: _name ?? _name,
      image: _image ?? _image,
      description: _description ?? _description,
      calo: _calo ?? _calo,
      createdAt: _createdAt ?? _createdAt,
      updatedAt: _updatedAt ?? _updatedAt,
      tagId: _tagId ?? _tagId,
      tag: _tag ?? _tag,
    );
  }
}
