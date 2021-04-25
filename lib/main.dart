import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kHintTextStyle = TextStyle(
  color: Color(0xff7b7b7b),
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold
);

final kBoxDecorationStyle = BoxDecoration(
  border: Border.all(color: Colors.black, width: 1.5),
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        bottom: false,
        child: LoginScreen(),
      )
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Introducir credenciales:',
            style: TextStyle(
              color: Colors.black,
              wordSpacing: 2,
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle( fontFamily: 'OpenSans' ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email, 
                color: Colors.black,  
              ),
              hintText: 'Correo electrónico',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      decoration: kBoxDecorationStyle,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
           elevation: 2,
          primary: Colors.white,
          padding: EdgeInsets.all(16),
        ),
        onPressed: () => print('Login Button Pressed'),
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            wordSpacing: -2,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildAlternativeLoginBtn({
    @required String imageUrl,
    @required String text,
  }) {
    return Container(
      decoration: kBoxDecorationStyle,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.white,
          padding: EdgeInsets.all(16),
        ),
        onPressed: () => print('Login Button Pressed'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 22.0,
                width: 22.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl)
                  ),
                ),
              ),
            ),

            SizedBox(width: 15.0),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  wordSpacing: -2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        '- Métodos alternativos -',
        style: TextStyle(
          color: Colors.black,
          wordSpacing: 2,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Simulador de Bolsa: Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      _buildEmailTF(),
                      SizedBox(
                        height: 24.0,
                      ),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 24.0,
                      ),

                      // _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                    
                      _buildSignInWithText(),
                      SizedBox(height: 10,),
                      _buildAlternativeLoginBtn(
                        imageUrl: 'assets/search.png',
                        text: 'Continuar con Google'
                      ),
                      
                      SizedBox(height: 10,),
                      _buildAlternativeLoginBtn(
                        imageUrl: 'assets/facebook.png',
                        text: 'Continuar con Facebook'
                      ),

                      SizedBox(height: 10,),
                      _buildAlternativeLoginBtn(
                        imageUrl: 'assets/apple.png',
                        text: 'Continuar con Apple'
                      ),

                      
                      // _buildSocialBtnRow(),
                      // _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}