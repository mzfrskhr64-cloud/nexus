import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexus/models/partner_model.dart';
import 'partner_state.dart';

class PartnerCubit extends Cubit<PartnerState> {
  PartnerCubit() : super(const PartnerState());

  void addPartner(PartnerModel partner) {
    final newPartner = PartnerModel(
      id: partner.id ?? DateTime.now().microsecondsSinceEpoch,
      name: partner.name,
      phone: partner.phone,
      companyName: partner.companyName,
      notes: partner.notes,
    );

    emit(
      PartnerState(
        partners: [
          ...state.partners,
          newPartner,
        ],
      ),
    );
  }

  void deletePartner(int id) {
    emit(
      PartnerState(
        partners: state.partners
            .where((partner) => partner.id != id)
            .toList(),
      ),
    );
  }
}