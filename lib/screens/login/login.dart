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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    auth.getUser;

    if (auth.getUser != null) {
      Navigator.pushReplacementNamed(context, '/profile');
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
        color: Colors.white,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 120.0),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Simulador de Bolsa: Iniciar Sesión',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontSize: 32.0,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 28),
        LoginInput(
          hintText: "Correo electrónico",
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          showLabel: true,
        ),

        SizedBox(height: 20.0),
        LoginInput(
          hintText: "Contraseña",
          icon: Icons.lock,
          keyboardType: TextInputType.visiblePassword,
          controller: _passwordController,
        ),

        SizedBox(height: 20.0),
        _buildLoginBtn(),
      
        _altLoginText(),

        AltLoginButton(imageUrl: 'assets/search.png', text: 'Continuar con Google', loginMethod: auth.googleSignIn),
    
        SizedBox(height: 10,),
        AltLoginButton(imageUrl: 'assets/facebook.png',text: 'Continuar con Facebook', loginMethod: auth.signInWithFacebook),
        
        SizedBox(height: 15,),
        FutureBuilder(
          future: auth.appleSignInAvailable,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return AltLoginButton(
                imageUrl: 'assets/apple.png',
                text: 'Continuar con Apple', 
                loginMethod: auth.appleSignIn
              );
            } else {
              return Container();
            }
          }
        ),
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
           elevation: 2,
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

  Widget _altLoginText() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Text(
        '- Métodos alternativos -',
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