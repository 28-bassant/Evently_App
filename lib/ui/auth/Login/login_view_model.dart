import 'package:evently_app/ui/auth/Login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  //todo: hold data - handle logic
  TextEditingController emailController = TextEditingController(
    text: 'bassant20@gmail.com',
  );
  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  var formKey = GlobalKey<FormState>();

  late LoginNavigator navigator;

  void Login() async {
    if (formKey.currentState?.validate() == true) {
      //todo: show loading
      navigator.showLoading('Loading...');
      try {
        //todo: signIn in firebase auth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        // //todo:read user from fireStore
        // var user = await FirebaseUtils.readUserFromFireStore(
        //     credential.user?.uid ?? '');
        // if (user == null) {
        //   return;
        // }
        // //todo: save user in provider
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.updateUser(user);
        // var eventListProvider = Provider.of<EventListProvider>(
        //     context, listen: false);
        // eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        // eventListProvider.getAllFavouriteEventsFromFireStore(
        //     userProvider.currentUser!.id);
        //todo: hide loading
        navigator.hideLoading();
        //todo: show message success
        navigator.showMessage('Login Successfully');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'network-request-failed') {
          //todo: hide loading
          navigator.hideLoading();
          //todo: show message success
          navigator.showMessage(
            'A network error such as (timeout - interrupted connection or unreachable host) has occured.',
          );
        } else if (e.code == 'invalid-credential') {
          navigator.hideLoading();
          navigator.showMessage('User not found or Password is wrong .');
        }
      } catch (e) {
        navigator.hideLoading();
        navigator.showMessage(e.toString());
      }
    }
  }
}
