import 'package:evently_app/ui/auth/Register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  //todo: hold data - handle logic

  late RegisterNavigator registerNavigator;

  void register(String email, String password) async {
    //todo : show loading
    registerNavigator.showLoading('Loading...');
    try {
      //todo : sign up in firebase auth
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //todo: ave user in fireStore
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text);
      // await FirebaseUtils.addUserToFireStore(myUser);
      // //todo: save user in provider
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUser(myUser);
      // var eventListProvider = Provider.of<EventListProvider>(
      //     context, listen: false);
      // eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      // eventListProvider.getAllFavouriteEventsFromFireStore(
      //     userProvider.currentUser!.id);

      //todo: hide loading
      registerNavigator.hideLoading();
      //todo: show message success
      registerNavigator.showMessage('Register Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //todo: hide loading
        registerNavigator.hideLoading();
        //todo: show message
        registerNavigator.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //todo: hide loading
        registerNavigator.hideLoading();
        //todo: show message
        registerNavigator.showMessage(
          'The account already exists for that email.',
        );
      } else if (e.code == 'network-request-failed') {
        //todo: hide loading
        registerNavigator.hideLoading();
        //todo: show message
        registerNavigator.showMessage(
          'A network error such as (timeout - interrupted connection or unreachable host) has occured.',
        );
      }
    } catch (e) {
      registerNavigator.hideLoading();

      //todo: show message
      registerNavigator.showMessage(e.toString());
    }
  }
}
