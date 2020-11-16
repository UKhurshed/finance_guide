import 'package:finance_guide/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationBloc>().state.user;
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          _userAccountDrawerHeader(user.name, user.email),
          _drawerItem(icon: Icons.west, title: 'Sign Out', onTap: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()))
        ],
      ),
    );
  }

  Widget _userAccountDrawerHeader(String name, String email,) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [Colors.blue[800], Colors.blue[700], Colors.blue[400]],
          )),
      accountEmail: Text(email),
      accountName: Text(name ?? ''),
      currentAccountPicture: CircleAvatar(
        child: Text('${email[0]}', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget _drawerItem({IconData icon, String title, GestureTapCallback onTap}){
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(title),
          ),
        ],
      ),
      onTap: onTap,
    );

  }
}