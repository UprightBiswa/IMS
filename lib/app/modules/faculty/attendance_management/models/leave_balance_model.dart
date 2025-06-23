class LeaveBalance {
  final int casual;
  final int earned;
  final int sick;

  LeaveBalance({
    required this.casual,
    required this.earned,
    required this.sick,
  });

  factory LeaveBalance.fromJson(Map<String, dynamic> json) {
    return LeaveBalance(
      casual: json['casual'] ?? 0,
      earned: json['earned'] ?? 0,
      sick: json['sick'] ?? 0,
    );
  }
}
