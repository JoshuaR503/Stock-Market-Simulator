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
        color: Color(0xfff2f1f6),
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
                          action: 'Ver posiciones'
                        ),
                        SizedBox(height: 14,),
                        this._buildPortfolioCard(
                          title: "Cambio en la cartera:",
                          value: '+5.98%',
                          action: '',
                          color: Colors.green
                        ),
                        SizedBox(height: 24,),

                        this._buildPortfolioSubtitle(title: 'Lista de seguimiento'),

                        SizedBox(height: 16),
                        _buildWatchlistItem( image: 'netflix', ticker: 'NFLX', change: '2.48'),

                        SizedBox(height: 16),
                        _buildWatchlistItem( image: 'search', ticker: 'GOOG', change: '2.48'),

                        SizedBox(height: 16),
                        _buildWatchlistItem( image: 'facebook', ticker: 'FB', change: '2.48'),
                        
                        SizedBox(height: 24),

                        this._buildPortfolioSubtitle(title: 'Ganadores y Perdedores'),

                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: this._buildGainersAndLosers(
                              name: 'Apple',
                              image: 'apple',
                              change: 6.32,
                              price: '\$324.34'
                            ),),
                            SizedBox(width: 24),
                            Expanded(child: this._buildGainersAndLosers(
                              name: 'Facebook',
                              image: 'facebook2',
                              change: -2.32,
                              price: '\$254.74'
                            ),),
                          ],
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
    String action,
    Color color = Colors.black,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.5,
                  height: 1.5,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              FaIcon(
                FontAwesomeIcons.angleRight,
                color: Colors.grey,
                size: 24,
              ),
            ],
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

  Widget _buildPortfolioSubtitle({
    String title
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            height: 1.5,
            color: Colors.black,
            fontWeight: FontWeight.w700,
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
    );
  }

  Widget _buildGainersAndLosers({
    String image,
    String name,
    double change,
    String price
  }) {
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
              child: Image(image: AssetImage('assets/$image.png')),
            )
          ),

          SizedBox(height: 8),

          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              height: 1.5,
              letterSpacing: -1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 17.5,
              height: 1.5,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),

          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              color:  change > 0 ? Color(0xffdaf4e3) : Colors.red.shade100,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                change > 0 ? '+ ' + change.toString() : '- ${change.toString().replaceFirst(RegExp('-'), '')}',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                  letterSpacing: -1,
                  color: change > 0 ? Color(0xff51cd7b) : Colors.red,
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
              
              SizedBox(width: MediaQuery.of(context).size.width / 2 * .4),

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