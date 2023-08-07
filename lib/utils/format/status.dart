

import 'package:flutter/material.dart';

String formatStatus (status) {
  String fStatus = '';
  switch (status) {
    case 'WAITING' : fStatus = 'Chờ duyệt';
    break;
    case 'DENIED' : fStatus = 'Quản lý huỷ';
    break;
    case 'STAFFCANCELED' : fStatus = 'Nhân viên huỷ';
    break;
    case 'CUSTOMERCANCELED' : fStatus = 'Khách hàng huỷ';
    break;
    case 'SIGNED' : fStatus = 'Đã ký';
    break;
    case 'WORKING' : fStatus = 'Đang hoạt động';
    break;
    case 'DONE' : fStatus = 'Hoàn thành';
    break;
    default : fStatus = 'Đang cập nhật';
  }

  return fStatus;
}

String formatReport (report) {
  String fReport = '';
  switch (report) {
    case 'NEW' : fReport = 'Đã gửi';
    break;
    case 'ACTIVE' : fReport = 'Đã duyệt';
    break;
    case 'CANCEL' : fReport = 'Đã huỷ';
    break;
    default : fReport = 'Đang cập nhật';
  }

  return fReport;
}
