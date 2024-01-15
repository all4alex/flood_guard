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

  FloodAlertModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] != null ? json['id'] as String : 'No Data',
          title: json['title'] != null ? json['title'] as String : 'No Data',
          message:
              json['message'] != null ? json['message'] as String : 'No Data',
          location:
              json['location'] != null ? json['location'] as String : 'No Data',
          timestamp:
              json['timestamp'] != null ? json['timestamp'] as int : 0000,
        );
}
