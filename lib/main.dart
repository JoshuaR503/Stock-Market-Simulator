import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
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
        bottom: false,
        top: false,
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

  BoxDecoration kBoxDecorationStyle = BoxDecoration(
    color: Color(0xFFfbfdff),
    borderRadius: BorderRadius.circular(1.0),
    border: Border.all(color: Colors.black, width: 2.5),
    
  );

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Introducir credenciales:',
          style: kLabelStyle,
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
              prefixIcon: Icon(  Icons.email  ),
              hintText: 'Introduzca su correo electrónico',
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
              hintText: 'Introduzca su contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          '¿Ha olvidado su contraseña?',
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.5),
        
      ),
      width: double.infinity,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          elevation: 2,
          primary: Colors.white,
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        onPressed: () => print('Login Button Pressed'),
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.5),
        
      ),
      width: double.infinity,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.white,
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: () => print('Login Button Pressed'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl)
                  ),
                ),
              ),
            ),

            SizedBox(width: 20.0),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  fontSize: 18.0,
                  wordSpacing: -1,
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
    return Column(
      children: <Widget>[
         SizedBox(height: 10,),
        Text(
          '- O -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [
                //       Color(0xFF73AEF5),
                //       Color(0xFF61A4F1),
                //       Color(0xFF478DE0),
                //       Color(0xFF398AE5),
                //     ],
                //     stops: [0.1, 0.4, 0.6, 0.8],
                //   ),
                // ),
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
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8*6.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 24.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
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