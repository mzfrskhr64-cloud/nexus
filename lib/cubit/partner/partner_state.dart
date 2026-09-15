import 'package:nexus/models/partner_model.dart';

class PartnerState {
  final bool isLoading;
  final List<PartnerModel> partners;
  final String? errorMessage;

  const PartnerState({
    this.isLoading = false,
    this.partners = const [],
    this.errorMessage,
  });
}