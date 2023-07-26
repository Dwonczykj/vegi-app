class StackLine {
  StackLine({
    this.className,
    this.functionName,
    this.fileName,
    this.lineNumber,
    this.characterNumber,
  });

  final String? className;
  final String? functionName;
  final String? fileName;
  final String? lineNumber;
  final String? characterNumber;

  @override
  String toString() {
    return '$fileName [$lineNumber] (in $className.$functionName)';
  }
}
