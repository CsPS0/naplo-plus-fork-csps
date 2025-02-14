class PremiumResult {
  final String sessionId;
  final List<String> scopes;
  final String login;
  final String responseId;

  PremiumResult({
    required this.sessionId,
    required this.scopes,
    required this.login,
    required this.responseId,
  });

  factory PremiumResult.fromJson(Map json) {
    return PremiumResult(
      sessionId: json["session_id"] ?? "",
      scopes: (json["scopes"] ?? []).cast<String>(),
      login: json["customer_id"] ?? "",
      responseId: json["response_id"] ?? "",
    );
  }
}
