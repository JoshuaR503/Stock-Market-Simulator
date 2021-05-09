import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffedf3f7),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        
                        Text(
                          'Simulador de Bolsa: Cartera',
                          style: TextStyle(
                            fontSize: 34.0,
                            height: 1.5,
                            letterSpacing: -1,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16,),
                        this._buildPortfolioCard(
                          title: "Valor de la cartera:",
                          value: '\$5,439,00',
                        ),
                        SizedBox(height: 14,),
                        this._buildPortfolioCard(
                          title: "Cambio en la cartera:",
                          value: '+583 (+5.98%)',
                          color: Colors.green
                        ),
                        SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: Text(
                              'Ganadores y Perdedores',
                              style: TextStyle(
                                fontSize: 20.0,
                                height: 1.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            )),

                            Text(
                              'Ver todos',
                              style: TextStyle(
                                fontSize: 16.0,
                                height: 1.5,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: this._buildGainersAndLosers(),),
                            SizedBox(width: 20,),
                            Expanded(child: this._buildGainersAndLosers(),),
                          ],
                        ),
                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: Text(
                          'Lista de seguimiento',
                          style: TextStyle(
                            fontSize: 20.0,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),),

                            Text(
                              'Ver todos',
                              style: TextStyle(
                                fontSize: 16.0,
                                height: 1.5,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),
                        _buildWatchlistItem(
                          image: 'netflix',
                          ticker: 'NFLX',
                          change: '2.48'
                        ),

                        SizedBox(height: 16),
                        _buildWatchlistItem(
                          image: 'search',
                          ticker: 'GOOG',
                          change: '2.48'
                        ),

                        SizedBox(height: 16),
                        _buildWatchlistItem(
                          image: 'facebook',
                          ticker: 'FB',
                          change: '2.48'
                        ),
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioCard({
    String title,
    String value,
    Color color = Colors.black,
  }) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              height: 1.5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: 28.0,
              height: 1.5,
              letterSpacing: -1,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGainersAndLosers() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 54.0,
            width: 54.0,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3.0,
                color: Colors.grey.shade200
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),

            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image(image: AssetImage('assets/apple.png')),
            )
          ),

          SizedBox(height: 8),

          Text(
            'Apple',
            style: TextStyle(
              fontSize: 20.0,
              height: 1.5,
              letterSpacing: -1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            '\$148.09',
            style: TextStyle(
              fontSize: 18.0,
              height: 1.5,
              letterSpacing: -1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8,),

          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Color(0xffdaf4e3),
              borderRadius: BorderRadius.all(
                Radius.circular(8)
              ),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Text(
                '+ 15.18 ',
                style: TextStyle(
                  fontSize: 18.0,
                  height: 1.5,
                  letterSpacing: -1,
                  color: Color(0xff51cd7b),
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistItem({String image, String ticker, String change}) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(
          Radius.circular(8)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              FaIcon(
                FontAwesomeIcons.solidStar,
                color: Colors.orange,
                size: 24,
              ),
              SizedBox(width: 16,),

            
              Container(
                height: 48.0,
                width: 48.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3.0,
                    color: Colors.grey.shade200
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
    
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image(image: AssetImage('assets/$image.png')),
                )
              ),

              SizedBox(width: 16,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticker.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '+$change%',
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              SizedBox(width: 80,),

              Text(
                '\$328',
                style: TextStyle(
                  fontSize: 18.0,
                  height: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(width: 16,),
              FaIcon(
                FontAwesomeIcons.ellipsisV,
                color: Colors.black,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}