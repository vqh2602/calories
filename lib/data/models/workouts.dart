/// id : 1
/// title : "Bài tập toàn thân 1"
/// description : "Đây là một trong những bài tập thể dục hỗ trợ đốt cháy mỡ thừa, đốt cháy calo mạnh mẽ và tăng nhịp tim, tăng cường sức chịu đựng của tim mạch rất hiệu quả. Đây là bài tập thể dục giảm mỡ khá được ưa chuộng cho cả nam lẫn nữ."
/// image : "images/fullbody 1.jpeg"
/// time : 22
/// calo : 303
/// video : "videos/fullbody 1.mp4"
/// level : 2
/// created_at : "2023-03-23T14:03:37.000000Z"
/// updated_at : "2023-03-23T14:03:37.000000Z"
/// tags : [{"id":9,"name":"bụng","description":"bụng","pivot":{"workout_id":1,"tag_id":9}},{"id":10,"name":"tay","description":"tay","pivot":{"workout_id":1,"tag_id":10}},{"id":11,"name":"chân","description":"chân","pivot":{"workout_id":1,"tag_id":11}},{"id":12,"name":"toàn thân","description":"toàn thân","pivot":{"workout_id":1,"tag_id":12}},{"id":20,"name":"bmi thiếu cân","description":"bmi thiếu cân","pivot":{"workout_id":1,"tag_id":20}},{"id":21,"name":"bmi bình thường","description":"bmi bình thường","pivot":{"workout_id":1,"tag_id":21}}]

class Workout {
  Workout({
      num? id, 
      String? title, 
      String? description, 
      String? image, 
      num? time, 
      num? calo, 
      String? video, 
      num? level, 
      String? createdAt, 
      String? updatedAt, 
      List<Tags>? tags,}){
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _time = time;
    _calo = calo;
    _video = video;
    _level = level;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _tags = tags;
}

  Workout.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _time = json['time'];
    _calo = json['calo'];
    _video = json['video'];
    _level = json['level'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['tags'] != null) {
      _tags = [];
      json['tags'].forEach((v) {
        _tags?.add(Tags.fromJson(v));
      });
    }
  }
  num? _id;
  String? _title;
  String? _description;
  String? _image;
  num? _time;
  num? _calo;
  String? _video;
  num? _level;
  String? _createdAt;
  String? _updatedAt;
  List<Tags>? _tags;
Workout copyWith({  num? id,
  String? title,
  String? description,
  String? image,
  num? time,
  num? calo,
  String? video,
  num? level,
  String? createdAt,
  String? updatedAt,
  List<Tags>? tags,
}) => Workout(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  time: time ?? _time,
  calo: calo ?? _calo,
  video: video ?? _video,
  level: level ?? _level,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  tags: tags ?? _tags,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  num? get time => _time;
  num? get calo => _calo;
  String? get video => _video;
  num? get level => _level;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Tags>? get tags => _tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['time'] = _time;
    map['calo'] = _calo;
    map['video'] = _video;
    map['level'] = _level;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_tags != null) {
      map['tags'] = _tags?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 9
/// name : "bụng"
/// description : "bụng"
/// pivot : {"workout_id":1,"tag_id":9}

class Tags {
  Tags({
      num? id, 
      String? name, 
      String? description, 
      Pivot? pivot,}){
    _id = id;
    _name = name;
    _description = description;
    _pivot = pivot;
}

  Tags.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  num? _id;
  String? _name;
  String? _description;
  Pivot? _pivot;
Tags copyWith({  num? id,
  String? name,
  String? description,
  Pivot? pivot,
}) => Tags(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  pivot: pivot ?? _pivot,
);
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  Pivot? get pivot => _pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    if (_pivot != null) {
      map['pivot'] = _pivot?.toJson();
    }
    return map;
  }

}

/// workout_id : 1
/// tag_id : 9

class Pivot {
  Pivot({
      num? workoutId, 
      num? tagId,}){
    _workoutId = workoutId;
    _tagId = tagId;
}

  Pivot.fromJson(dynamic json) {
    _workoutId = json['workout_id'];
    _tagId = json['tag_id'];
  }
  num? _workoutId;
  num? _tagId;
Pivot copyWith({  num? workoutId,
  num? tagId,
}) => Pivot(  workoutId: workoutId ?? _workoutId,
  tagId: tagId ?? _tagId,
);
  num? get workoutId => _workoutId;
  num? get tagId => _tagId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workout_id'] = _workoutId;
    map['tag_id'] = _tagId;
    return map;
  }

}