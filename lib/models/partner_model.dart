class PartnerModel {
  final int? id;
  final String name;
  final String phone;
  final String? companyName;
  final String? notes;

  const PartnerModel({
    this.id,
    required this.name,
    required this.phone,
    this.companyName,
    this.notes,
  });
}