/// id : 2
/// workout_realtime : 470
/// calo_real : 900
/// user_id : 1
/// workout_id : 2
/// created_at : "2023-03-26T00:00:00.000000Z"
/// updated_at : "2023-03-26T00:00:00.000000Z"

class UserWorkout {
  UserWorkout({
    num? id,
    num? workoutRealtime,
    num? caloReal,
    num? userId,
    num? workoutId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _workoutRealtime = workoutRealtime;
    _caloReal = caloReal;
    _userId = userId;
    _workoutId = workoutId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserWorkout.fromJson(dynamic json) {
    _id = json['id'];
    _workoutRealtime = json['workout_realtime'];
    _caloReal = json['calo_real'];
    _userId = json['user_id'];
    _workoutId = json['workout_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _workoutRealtime;
  num? _caloReal;
  num? _userId;
  num? _workoutId;
  String? _createdAt;
  String? _updatedAt;
  UserWorkout copyWith({
    num? id,
    num? workoutRealtime,
    num? caloReal,
    num? userId,
    num? workoutId,
    String? createdAt,
    String? updatedAt,
  }) =>
      UserWorkout(
        id: id ?? _id,
        workoutRealtime: workoutRealtime ?? _workoutRealtime,
        caloReal: caloReal ?? _caloReal,
        userId: userId ?? _userId,
        workoutId: workoutId ?? _workoutId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get workoutRealtime => _workoutRealtime;
  num? get caloReal => _caloReal;
  num? get userId => _userId;
  num? get workoutId => _workoutId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['workout_realtime'] = _workoutRealtime;
    map['calo_real'] = _caloReal;
    map['user_id'] = _userId;
    map['workout_id'] = _workoutId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
