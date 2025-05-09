final asciiRegex = RegExp(r'^[\x00-\x7F]*$');
final base64Regex = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
final base64UrlRegex = RegExp(r'^[A-Za-z0-9\-_]*={0,2}$');
final hexRegex = RegExp(r'^[0-9a-fA-F]*$');
