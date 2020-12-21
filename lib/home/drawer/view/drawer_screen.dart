import 'package:finance_guide/authentication/bloc/authentication_bloc.dart';
import 'package:finance_guide/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationBloc>().state.user;
    var index = user.email.isEmpty;
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
            _userAccountDrawerHeader(user.name, index ? '' :  user.email, context),
            _drawerItem(icon: Icons.west, title: index ? '' : 'Sign Out', onTap: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()), context:context)
        ],
      ),
    );
  }

  Widget _userAccountDrawerHeader(String name, String email, BuildContext context) {
    if(email.isEmpty){
      return Container(
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Colors.blue[800], Colors.blue[700], Colors.blue[400]],
            )),
      );
    }else{
      return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Colors.blue[800], Colors.blue[700], Colors.blue[400]],
            )),
        accountEmail: Text(email ?? ''),
        accountName: Text(name ?? ''),
        currentAccountPicture: CircleAvatar(
            child: email != '' ? Text('${email[0]}', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold), ) : Text('')
        ),
      );
    }
  }

  Widget _drawerItem({IconData icon, String title, GestureTapCallback onTap, BuildContext context}){
    if(title.isEmpty){
      return ListTile(
        title: Row(
          children: [
            Icon(Icons.login),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text('Login'),
            ),
          ],
        ),
        onTap: (){
          Navigator.pushAndRemoveUntil(context, LoginScreen.route(), (route) => false);
        }
      );
    }else{
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
}

/*
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
 */