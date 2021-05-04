

import 'package:flutter/material.dart';
import 'package:simulador/services/auth.dart';
import 'package:simulador/shared/login_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthService auth = AuthService();

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      auth.getUser;

      if (auth.getUser != null) {
        Navigator.pushReplacementNamed(context, '/profile');
      }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,


          children: [

            FlutterLogo(size: 150,),
            Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),

            Text('Your tagline'),
            LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: FontAwesomeIcons.google,
              color: Colors.black45,
              loginMethod: auth.googleSignIn,
            ),


            // LoginButton(
            //   text: 'LOGIN WITH APPLE',
            //   icon: FontAwesomeIcons.apple,
            //   color: Colors.black45,
            //   loginMethod: auth.appleSignIn,
            // ),

            FutureBuilder(
                future: auth.appleSignInAvailable,
                builder: (context, snapshot) {
                
                if (snapshot.data == true) {
                    return AppleSignInButton(
                      onPressed: () async { 
                        User user = await auth.appleSignIn();
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/profile');
                        }
                      },
                    );
                } else {
                    return Container();
                }
              },
            ),


          ],
        )
      )
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:simulador/screens/login/styles.dart';
// import 'package:simulador/screens/login/widgets.dart';

// final kHintTextStyle = TextStyle(
//   color: Color(0xff7b7b7b),
//   fontFamily: 'OpenSans',
//   fontWeight: FontWeight.bold
// );

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Stack(
//         children: <Widget>[
          
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             color: Colors.white,
//           ),
          
//           Container(
//             height: double.infinity,
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 120.0),
//               child: this._buildBody()
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           'Simulador de Bolsa: Iniciar Sesión',
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'OpenSans',
//             fontSize: 30.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         SizedBox(height: 40),
//         _buildEmailInput(),

//         SizedBox(height: 24.0),
//         _buildPasswordInput(),

//         SizedBox(height: 24.0),
//         _buildLoginBtn(),
      
//         _buildSignInWithText(),

//         SizedBox(height: 10),
//         AltLoginButton(imageUrl: 'assets/search.png', text: 'Continuar con Google'),
    
//         SizedBox(height: 10,),
//         AltLoginButton(imageUrl: 'assets/facebook.png',text: 'Continuar con Facebook'),

//         SizedBox(height: 10,),
//         AltLoginButton(imageUrl: 'assets/apple.png',text: 'Continuar con Apple'),
//       ],
//     );
//   }

//   Widget _buildEmailInput() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(bottom: 8),
//           child: Text(
//             'Introducir credenciales:',
//             style: TextStyle(
//               color: Colors.black,
//               wordSpacing: 2,
//               fontSize: 16.5,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'OpenSans',
//             ),
//           ),
//         ),
//         SizedBox(height: 10.0),
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             keyboardType: TextInputType.emailAddress,
//             style: TextStyle( fontFamily: 'OpenSans' ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.email, 
//                 color: Colors.black,  
//               ),
//               hintText: 'Correo electrónico',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordInput() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           alignment: Alignment.centerLeft,
//           decoration: kBoxDecorationStyle,
//           height: 60.0,
//           child: TextField(
//             obscureText: true,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'OpenSans',
//             ),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(top: 14.0),
//               prefixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.black,
//               ),
//               hintText: 'Contraseña',
//               hintStyle: kHintTextStyle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoginBtn() {
//     return Container(
//       decoration: kBoxDecorationStyle,
//       height: 58,
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//            elevation: 2,
//           primary: Colors.white,
//           padding: EdgeInsets.all(8),
//         ),
//         onPressed: () => print('Login Button Pressed'),
//         child: Text(
//           'Iniciar sesión',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18.0,
//             wordSpacing: -2,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'OpenSans',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSignInWithText() {
//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: Text(
//         '- Métodos alternativos -',
//         style: TextStyle(
//           color: Colors.black,
//           wordSpacing: 2,
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'OpenSans',
//         ),
//       )
//     );
//   }
// }