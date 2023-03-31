// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//   "id": 1,
//   "title": "title blog  1",
//   "description": "desscription blog 1",
//   "link": "images/fullbody1.jpeg",
//   "image": "images/fullbody1.jpeg",
//   "tag_id": 6,
//   "created_at": "2023-03-24T15:25:32.000000Z",
//   "updated_at": "2023-03-24T15:25:32.000000Z",
//   "tag": {
//     "id": 6,
//     "type": 2,
//     "name": "hình ảnh",
//     "description": "hình ảnh",
//     "created_at": "2023-03-24T15:25:31.000000Z",
//     "updated_at": "2023-03-24T15:25:31.000000Z"
//   }
// }

import 'package:calories/data/models/tag.dart';

class Blog {
  num? _id;
  String? _title;
  String? _description;
  String? _link;
  String? _image;
  num? _tagId;
  String? _createdAt;
  String? _updatedAt;
  Tag? _tag;

  Blog(
      {num? id,
      String? title,
      String? description,
      String? link,
      String? image,
      num? tagId,
      String? createdAt,
      String? updatedAt,
      Tag? tag}) {
    _id = id;

    _title = title;
    _description = description;
    _link = link;
    _image = image;
    _tagId = tagId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _tag = tag;
  }

  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get link => _link;
  String? get image => _image;
  num? get tagId => _tagId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Tag? get tag => _tag;

  Blog.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _link = json['link'];
    _image = json['image'];
    _tagId = json['tag_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _tag = json['tag'] != null ? Tag.fromJson(json['tag']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['description'] = _description;
    data['link'] = _link;
    data['image'] = _image;
    data['tag_id'] = _tagId;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    if (_tag != null) {
      data['tag'] = _tag!.toJson();
    }
    return data;
  }

  Blog copyWith({
    num? id,
    String? title,
    String? description,
    String? link,
    String? image,
    num? tagId,
    String? createdAt,
    String? updatedAt,
    Tag? tag,
  }) {
    return Blog(
      id: id ?? _id,
      title: title ?? _title,
      description: description ?? _description,
      link: _link ?? _link,
      image: _image ?? _image,
      tagId: _tagId ?? _tagId,
      createdAt: _createdAt ?? _createdAt,
      updatedAt: _updatedAt ?? _updatedAt,
      tag: _tag ?? _tag,
    );
  }
}
