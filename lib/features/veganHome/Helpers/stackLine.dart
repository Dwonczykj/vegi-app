class StackLine {
  StackLine({
    this.className,
    this.functionName,
    this.fileName,
    this.lineNumber,
    this.characterNumber,
    this.stackTraceString,
  });

  final String? className;
  final String? functionName;
  final String? fileName;
  final String? lineNumber;
  final String? characterNumber;
  final String? stackTraceString;

  @override
  String toString() {
    return '$fileName [$lineNumber] (in $className.${functionName?.replaceAll('<anonymous closure>', '#')})';
  }
}
