import 'package:thanhhoa_garden/models/contract/contact.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ListContactSuccess extends ContactState {
  final List<Contact>? listContact;
  ListContactSuccess({required this.listContact});
}

class ListContactDetailSuccess extends ContactState {
  final List<ContactDetail>? listContactDetail;
  ListContactDetailSuccess({required this.listContactDetail});
}

class ContactSuccess extends ContactState {
  final Contact? contact;
  ContactSuccess({required this.contact});
}

class ContactFailure extends ContactState {
  final String errorMessage;
  ContactFailure({required this.errorMessage});
}
