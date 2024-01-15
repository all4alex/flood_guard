// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FloodAlertModel {
  final String? id;
  final String? title;
  final String? message;
  final String? location;
  final int? timestamp;

  FloodAlertModel(
      {this.id, this.title, this.message, this.location, this.timestamp});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'location': location,
      'timestamp': timestamp,
    };
  }

  factory FloodAlertModel.fromMap(Map<String, Object?> map) {
    return FloodAlertModel(
      id: map['id'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
      location: map['location'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  factory FloodAlertModel.fromJson(dynamic source) =>
      FloodAlertModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
