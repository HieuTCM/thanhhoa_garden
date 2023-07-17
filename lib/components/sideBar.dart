// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_bloc.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_event.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/screens/authentication/loginPage.dart';
import 'package:thanhhoa_garden/screens/order/orderHistoryScreen.dart';
import 'package:thanhhoa_garden/screens/store/storeScreen.dart';

class SideBar extends StatefulWidget {
  User user;
  SideBar({super.key, required this.user});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(gradient: narBarBackgroud),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(
                  widget.user.fullName,
                  style: const TextStyle(color: lightText),
                ),
                accountEmail: Text(widget.user.email,
                    style: const TextStyle(color: lightText)),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      widget.user.avatar,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                )),
            _listTile(
                'Xem cây cảnh',
                () {},
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
            _listTile(
                'Xem Dịch Vụ',
                () {},
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
            _listTile('Lịch Sử Mua Hàng', () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderHistoryScreen(),
              ));
            },
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
            _listTile(
                'Đánh Giá Của Tôi',
                () {},
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
            _listTile(
                'Thông Báo',
                () {},
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
            _listTile('Cơ Sở Thanh Hóa', () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StoreScreen(),
              ));
            },
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
            _listTile('Đăng Xuất', () {
              authBloc.send(LogoutEvent());
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
                const Icon(
                  Icons.abc,
                  size: 40,
                )),
          ],
        ),
      ),
    );
  }

  Widget _listTile(String title, onTap, icon) {
    return ListTile(
      leading: icon,
      title:
          Text(title, style: const TextStyle(color: lightText, fontSize: 17)),
      onTap: onTap,
      trailing: title != 'Thông Báo'
          ? null
          : ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                    child: Text(
                  '10',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )),
              ),
            ),
    );
  }
}
