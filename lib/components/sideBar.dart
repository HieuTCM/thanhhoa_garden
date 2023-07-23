// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_bloc.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_event.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/main.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart';
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';
import 'package:thanhhoa_garden/screens/authentication/loginPage.dart';
import 'package:thanhhoa_garden/screens/bonsai/searchScreen.dart';
import 'package:thanhhoa_garden/screens/feedback/listFeedbackScreen.dart';
import 'package:thanhhoa_garden/screens/home/homePage.dart';
import 'package:thanhhoa_garden/screens/order/orderHistoryScreen.dart';
import 'package:thanhhoa_garden/screens/store/storeScreen.dart';
import 'package:thanhhoa_garden/screens/order/mapScreen.dart';
import 'package:thanhhoa_garden/models/authentication/user.dart' as UserObj;
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

class SideBar extends StatefulWidget {
  // User user;
  SideBar({
    super.key,
    //  required this.user
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  AuthenticationProvider _authenticationProvider = AuthenticationProvider();
  UserObj.User user = getCuctomerIDFromSharedPrefs();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                  user.fullName,
                  style: const TextStyle(color: lightText),
                ),
                accountEmail:
                    Text(user.email, style: const TextStyle(color: lightText)),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      user.avatar,
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
            _listTile('Trang chủ', () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                  (Route<dynamic> route) => false);
            },
                const Icon(
                  Icons.home,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile('Xem cây cảnh', () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
            },
                const Icon(
                  Icons.yard,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile(
                'Xem Dịch Vụ',
                () {},
                const Icon(
                  Icons.cleaning_services_outlined,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile('Lịch Sử Mua Hàng', () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderHistoryScreen(),
              ));
            },
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile('Đánh Giá Của Tôi', () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ListFeedbackScreen(),
              ));
            },
                const Icon(
                  Icons.feedback_outlined,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile(
                'Thông Báo',
                () {},
                const Icon(
                  Icons.notifications_none_outlined,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile('Cơ Sở Thanh Hóa', () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const StoreScreen(),
              ));
            },
                const Icon(
                  Icons.location_on,
                  size: 30,
                  color: buttonColor,
                )),
            _listTile('Đăng Xuất', () {
              authBloc.send(LogoutEvent());
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
                const Icon(
                  Icons.arrow_circle_left_outlined,
                  size: 30,
                  color: buttonColor,
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
          Text(title, style: const TextStyle(color: lightText, fontSize: 18)),
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
