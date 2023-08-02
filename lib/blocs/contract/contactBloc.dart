import 'dart:async';

import 'package:thanhhoa_garden/blocs/contract/contactEvent.dart';
import 'package:thanhhoa_garden/blocs/contract/contactState.dart';
import 'package:thanhhoa_garden/models/contract/contact.dart';
import 'package:thanhhoa_garden/providers/contact/contact_provider.dart';

class ContactBloc {
  final ContactProvider _ContactProvider;
  final StreamController<ContactState> _ContactStateController =
      StreamController<ContactState>();

  Stream<ContactState> get authStateStream =>
      _ContactStateController.stream.asBroadcastStream();
  StreamController<ContactState> get authStateController =>
      _ContactStateController;

  ContactBloc({required ContactProvider ContactProvider})
      : _ContactProvider = ContactProvider {
    _ContactStateController.add(ContactInitial());
  }
  void send(ContactEvent event) async {
    switch (event.runtimeType) {
      case GetAllContactEvent:
        if (event.pageNo == 0) {
          _ContactStateController.add(ContactLoading());
        }
        await _ContactProvider.getContactList(event).then((value) {
          if (value) {
            final listContact = _ContactProvider.list;
            List<Contact> fetchContactList = [
              ...event.listContact!,
              ...listContact!
            ];
            _ContactStateController.add(
                ListContactSuccess(listContact: fetchContactList));
          } else {
            _ContactStateController.add(
                ContactFailure(errorMessage: 'Tải hợp đồng thất bại'));
          }
        });
        break;
      case GetAllContactDetailEvent:
        if (event.pageNo == 0) {
          _ContactStateController.add(ContactLoading());
        }
        await _ContactProvider.getContactDetailList(event).then((value) {
          if (value) {
            final listContactDetial = _ContactProvider.listDetail;
            List<ContactDetail> fetchContactDetailList = [
              ...event.listContactDetail!,
              ...listContactDetial!
            ];
            _ContactStateController.add(ListContactDetailSuccess(
                listContactDetail: fetchContactDetailList));
          } else {
            _ContactStateController.add(
                ContactFailure(errorMessage: 'Tải dịch vụ thất bại'));
          }
        });
        break;
    }
  }

  void dispose() {
    _ContactStateController.close();
  }
}
