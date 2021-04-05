import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_app/src/data/data.dart';
import 'package:horoscope_app/src/data/models/person_model.dart';
import 'package:horoscope_app/src/services/person_service.dart';
import 'package:horoscope_app/src/ui/modals/loading_dialog.dart';
import 'package:horoscope_app/src/utility/assets.dart';
import 'package:horoscope_app/src/utility/constants.dart';
import 'package:horoscope_app/src/utility/validators.dart';

class SignInPage extends StatefulWidget {
  final Function callBack;

  SignInPage({@required this.callBack});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  var _person = Person();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Sign In'),
      ),
      body: Center(
        child: AppData().getSignIn()
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.checkmark_seal_fill,
                    color: kPrimaryColor,
                    size: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'You are signed in as',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    AppData().getEmail(),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.appLogo,
                        width: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: Validators.emailValidator,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => _person.email = value,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(CupertinoIcons.mail_solid),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: AppPasswordField(
                          onSaved: (value) => _person.password = value,
                          validator: Validators.passwordValidator,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: _performSignIn,
                          child: Text(
                            'Sign In'.toUpperCase(),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _performSignIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      openLoadingDialog(context, 'Please Wait');
      if ((await PersonService().fetchOnePerson(_person.email)) != null) {
        final result =
            await PersonService().checkLogin(_person.email, _person.password);
        if (result != null) {
          AppData().setEmail(result.email);
          AppData().setIsSignIn(true);
          AppData().setHasPayed(result.hasPaid);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wrong email or password'),
            ),
          );
        }
      } else {
        _person.hasPaid = false;
        _person = await PersonService().addPerson(person: _person);
        AppData().setEmail(_person.email);
        AppData().setIsSignIn(true);
        AppData().setHasPayed(_person.hasPaid);
      }
      Navigator.of(context).pop();
      widget.callBack();
      setState(() {});
    } else
      setState(() => _autoValidateMode = AutovalidateMode.onUserInteraction);
  }
}

class AppPasswordField extends StatefulWidget {
  final Function(String) onSaved;
  final Function(String) validator;

  AppPasswordField({
    @required this.onSaved,
    @required this.validator,
  });

  @override
  _AppPasswordFieldState createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _show,
      keyboardType: TextInputType.text,
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: kInputDecoration.copyWith(
        hintText: 'Password',
        prefixIcon: Icon(CupertinoIcons.lock_circle_fill),
        suffixIcon: InkWell(
          onTap: () => setState(() => _show = !_show),
          child: Icon(_show ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
        ),
      ),
    );
  }
}
