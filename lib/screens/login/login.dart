import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulador/screens/login/loginInput.dart';
import 'package:simulador/screens/login/styles.dart';
import 'package:simulador/screens/login/widgets.dart';
import 'package:simulador/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthService auth = AuthService();
  bool rememberMe = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    auth.getUser;

    if (auth.getUser != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfff2f1f6),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
                    child: this._buildBody()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
                                SizedBox(height: 24,),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
          'Iniciar Sesión',
          style: TextStyle(
            color: Colors.black,
            fontSize: 34.0,
            height: 1.5,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        SizedBox(height: 14),
        LoginInput(
          hintText: "Correo electrónico",
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          showLabel: true,
        ),

        SizedBox(height: 15),
        LoginInput(
          hintText: "Contraseña",
          icon: Icons.lock,
          keyboardType: TextInputType.visiblePassword,
          controller: _passwordController,
        ),        

        SizedBox(height: 15),
        _buildLoginBtn(),
      
        _uiText("- Métodos alternativos -"),
        AltLoginButton(imageUrl: "assets/search.png", text: "Continuar con Google", loginMethod: auth.googleSignIn),
    
        SizedBox(height: 15),
        AltLoginButton(imageUrl: "assets/facebook.png",text: "Continuar con Facebook", loginMethod: auth.signInWithFacebook),
        
        SizedBox(height: 15),
        FutureBuilder(
          future: auth.appleSignInAvailable,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return AltLoginButton(
                imageUrl: "assets/apple.png",
                text: "Continuar con Apple", 
                loginMethod: auth.appleSignIn
              );
            } else {
              return Container();
            }
          }
        ),

        SizedBox(height: 15),
        AltLoginButton(imageUrl: "assets/user.png",text: "Continuar como Invitado", loginMethod: auth.annLogin),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      decoration: kBoxDecorationStyle,
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
           elevation: 0,
          primary: Colors.white,
          padding: EdgeInsets.all(8),
        ),
        onPressed: () {
          auth.signInWithEmailAndPassword(
            email: _emailController.text, 
            password: _passwordController.text
          );
        },
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17.5,
            fontWeight: FontWeight.w500,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _uiText(String text) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          wordSpacing: 2,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'OpenSans',
        ),
      )
    );
  }
}