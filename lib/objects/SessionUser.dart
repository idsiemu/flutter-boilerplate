// ignore_for_file: file_names

class SessionUser {
  SessionUser({
    required this.sessionKey,
    required this.sessionEmail,
    required this.sessionUserId,
  });

  String sessionUserId;
  String sessionEmail;
  String sessionKey;

  factory SessionUser.fromJson(Map<String, dynamic> json) => SessionUser(
    sessionUserId: json['user_id'],
    sessionEmail: json['email'],
    sessionKey: json['session_key'],
  );

}