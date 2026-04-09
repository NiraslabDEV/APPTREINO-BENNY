import '../constants/app_constants.dart';

/// Validações client-side — apenas UX, a real validação está no backend
class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo obrigatório';
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value.trim())) return 'E-mail inválido';
    if (value.length > 254) return 'E-mail muito longo';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (value.length < 8) return 'Mínimo 8 caracteres';
    if (value.length > 128) return 'Senha muito longa';
    return null;
  }

  static String? requiredText(String? value, {int? maxLength}) {
    if (value == null || value.trim().isEmpty) return 'Campo obrigatório';
    final max = maxLength ?? AppConstants.maxNameLength;
    if (value.length > max) return 'Máximo $max caracteres';
    return null;
  }

  static String? optionalText(String? value, {int? maxLength}) {
    if (value == null || value.isEmpty) return null;
    final max = maxLength ?? AppConstants.maxDescriptionLength;
    if (value.length > max) return 'Máximo $max caracteres';
    return null;
  }

  static String? weight(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo obrigatório';
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null) return 'Valor inválido';
    if (parsed <= 0 || parsed > 999) return 'Peso inválido';
    return null;
  }

  static String? reps(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo obrigatório';
    final parsed = int.tryParse(value);
    if (parsed == null) return 'Valor inválido';
    if (parsed <= 0 || parsed > 999) return 'Reps inválidas';
    return null;
  }
}
