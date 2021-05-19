class StockStats {
  final String companyName;
  final int marketcap;
  final double week52high;
  final double week52low;
  final double sharesOutstanding;
  final double avg30Volume;
  final double avg10Volume;
  final double ttmEPS;
  final double peRatio;
  final double beta;


  StockStats({
    this.companyName,
    this.marketcap,
    this.week52high,
    this.week52low,
    this.sharesOutstanding,
    this.avg30Volume,
    this.avg10Volume,
    this.ttmEPS,
    this.peRatio,
    this.beta,
  });


  factory StockStats.fromJson(Map<String, dynamic> json) {

    return StockStats(
      companyName: json['companyName'],
      marketcap:  json['marketcap'],
      week52high:  double.tryParse(json['week52high'].toString()),
      week52low:  double.tryParse(json['week52low'].toString()),
      sharesOutstanding:  double.tryParse(json['sharesOutstanding'].toString()),
      avg30Volume:  double.tryParse(json['avg30Volume'].toString()),
      avg10Volume:  double.tryParse(json['avg10Volume'].toString()),
      ttmEPS:  double.tryParse(json['ttmEPS'].toString()),
      peRatio:  double.tryParse(json['peRatio'].toString()),
      beta:  double.tryParse(json['beta'].toString()),

    );
  }
}