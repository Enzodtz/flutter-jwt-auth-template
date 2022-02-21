class FormFieldsException implements Exception {
  final Map<String, dynamic> errors;

  FormFieldsException({
    required this.errors,
  });
}

class FormGeneralException implements Exception {
  final String message;

  FormGeneralException({
    required this.message,
  });
}

Exception handleFormErrors(Map<String, dynamic> json) {
  if (json['detail'] != null) {
    return FormGeneralException(message: json['detail']);
  } else {
    return FormFieldsException(errors: json);
  }
}
