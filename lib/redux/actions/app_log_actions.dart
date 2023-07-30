class AddAppLog {
  AddAppLog({
    required this.message,
    this.additionalInfo = const {},
  });

  final String message;
  final Map<String, dynamic> additionalInfo;

  @override
  String toString() {
    return 'AddAppLog : message:"$message"';
  }
}
