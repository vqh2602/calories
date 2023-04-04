// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calories/data/models/workouts.dart';

class TrainingPlan {
  num? _id;
  num? _date;
  num? _userId;
  num? _workoutId;
  num? _tagId;
  num? _status;
  Workout? _workout;

  TrainingPlan({
    num? id,
    num? date,
    num? userId,
    num? workoutId,
    num? tagId,
    num? status,
    Workout? workout,
  }) {
    if (id != null) {
      _id = id;
      _date = date;
      _userId = userId;
      _workoutId = workoutId;
      _tagId = tagId;
      _status = status;
      _workout = workout;
    }
  }

  num? get id => _id;
  num? get date => _date;
  num? get userId => _userId;
  num? get workoutId => _workoutId;
  num? get tagId => _tagId;
  num? get status => _status;
  Workout? get workout => _workout;

  TrainingPlan copyWith({
    num? id,
    num? date,
    num? userId,
    num? workoutId,
    num? tagId,
    num? status,
    Workout? workout,
  }) {
    return TrainingPlan(
      id: _id ?? _id,
      date: _date ?? _date,
      userId: _userId ?? _userId,
      workoutId: _workoutId ?? _workoutId,
      tagId: _tagId ?? _tagId,
      status: _status ?? _status,
      workout: _workout ?? _workout,
    );
  }

  TrainingPlan.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _date = json['date'];
    _userId = json['user_id'];
    _workoutId = json['workout_id'];
    _tagId = json['tag_id'];
    _status = json['status'];
    _workout =
        json['workout'] != null ? Workout.fromJson(json['workout']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = _id;
    data['date'] = _date;
    data['user_id'] = _userId;
    data['workout_id'] = _workoutId;
    data['tag_id'] = _tagId;
    data['status'] = _status;
    if (_workout != null) {
      data['workout'] = _workout!.toJson();
    }
    return data;
  }
}
