// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num?)?.toInt(),
      programId: (json['program_id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      cost: (json['cost'] as num?)?.toInt(),
      duration: json['duration'] as String?,
      schedule: json['schedule'] as String?,
      venue: json['venue'] as String?,
      evaLink: json['eval_link'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('program_id', instance.programId);
  writeNotNull('trainer_id', instance.trainerId);
  writeNotNull('eval_link', instance.evaLink);
  val['title'] = instance.title;
  writeNotNull('description', instance.description);
  writeNotNull('cost', instance.cost);
  writeNotNull('duration', instance.duration);
  writeNotNull('schedule', instance.schedule);
  writeNotNull('venue', instance.venue);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  return val;
}
