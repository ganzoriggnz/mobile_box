class Operator {
  String imgPath;
  String name;
  List<Unit> units;
  Operator({this.imgPath, this.name, this.units});
}

final List<Operator> operators = [
  Operator(imgPath: 'assets/operators/unitel.png', name: 'UNITEL', units: unitel),
  Operator(imgPath: 'assets/operators/skytel.png', name: 'SKYTEL', units: skytel),
  Operator(imgPath: 'assets/operators/gmobile.png', name: 'GMOBILE', units: gmobile)
];

class Unit {
  String type;
  String price;
  String reward;
  Unit({this.type, this.price, this.reward});
}

final List<Unit> unitel = [
  Unit(
    type: 'unit',
    price: '3000',
    reward: '3000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '5000',
    reward: '5000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '6000',
    reward: '6000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '8000',
    reward: '8000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '10000',
    reward: '10000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '15000',
    reward: '15000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '20000',
    reward: '20000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '25000',
    reward: '25000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '50000',
    reward: '50000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '70000',
    reward: '70000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '120000',
    reward: '120000 нэгж'
  ),
  Unit(
    type: 'data',
    price: '1500',
    reward: '1GB / 1 days'
  ),
  Unit(
    type: 'data',
    price: '2000',
    reward: 'Gaming 1GB / 7 days'
  ),
  Unit(
    type: 'data',
    price: '2500',
    reward: '1.5GB / 3 days'
  ),
  Unit(
    type: 'data',
    price: '2500',
    reward: '2GB / 2 days'
  ),
  Unit(
    type: 'data',
    price: '2900',
    reward: 'LookTV / 30 days'
  ),
  Unit(
    type: 'data',
    price: '5000',
    reward: '2.5GB / 10 days'
  ),
  Unit(
    type: 'data',
    price: '10000',
    reward: '3GB / 30 days'
  ),
  Unit(
    type: 'data',
    price: '10000',
    reward: '9GB / 7 days'
  ),
  Unit(
    type: 'data',
    price: '15000',
    reward: 'Steaming 20GB / 30 days'
  ),
  Unit(
    type: 'data',
    price: '20000',
    reward: '20GB / 10 days'
  ),
  Unit(
    type: 'data',
    price: '20000',
    reward: '8GB / 30 days'
  ),
  Unit(
    type: 'data',
    price: '25000',
    reward: '50GB / 30 days'
  ),
  Unit(
    type: 'data',
    price: '32000',
    reward: '15GB / 30 days'
  ),
];

final List<Unit> skytel = [
  Unit(
    type: 'unit',
    price: '1000',
    reward: '1000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '2000',
    reward: '2000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '3000',
    reward: '3000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '5000',
    reward: '5000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '6000',
    reward: '6000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '10000',
    reward: '10000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '10000',
    reward: '247 card / 5000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '15000',
    reward: '15000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '50000',
    reward: '50000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '90000',
    reward: '90000 нэгж'
  ),
  Unit(
    type: 'data',
    price: '25000',
    reward: 'LTE25000 card / 25GB / 30 days'
  ),
  Unit(
    type: 'data',
    price: '30000',
    reward: 'LTE30000 card / 25GB / 30 days'
  ),
];

final List<Unit> gmobile = [
  Unit(
    type: 'unit',
    price: '1000',
    reward: '1000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '2000',
    reward: '2000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '5000',
    reward: '5000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '6000',
    reward: '6000 нэгж / 60 хоног'
  ),
  Unit(
    type: 'unit',
    price: '10000',
    reward: '10000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '11000',
    reward: '11000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '20000',
    reward: '5000 нэгж / 30 хоног'
  ),
  Unit(
    type: 'unit',
    price: '30000',
    reward: '30000 нэгж'
  ),
  Unit(
    type: 'unit',
    price: '60000',
    reward: '12000 нэгж / 50 хоног'
  ),
  Unit(
    type: 'data',
    price: '1000',
    reward: '100mb / 3 days'
  ),
  Unit(
    type: 'data',
    price: '1000',
    reward: 'Дата хязгааргүй / 1 day'
  ),
  Unit(
    type: 'data',
    price: '3000',
    reward: 'Дата хязгааргүй / 3 days'
  ),
  Unit(
    type: 'data',
    price: '4000',
    reward: '500 mb / 8 days'
  ),
  Unit(
    type: 'data',
    price: '7000',
    reward: 'Дата хязгааргүй / 7 days'
  ),
  Unit(
    type: 'data',
    price: '13000',
    reward: 'Дата хязгааргүй / 14 days'
  ),
  Unit(
    type: 'data',
    price: '25000',
    reward: 'Дата хязгааргүй / 30 days'
  ),
  Unit(
    type: 'data',
    price: '75000',
    reward: 'Дата хязгааргүй / 90 days'
  ),
  Unit(
    type: 'data',
    price: '240000',
    reward: '120GB / 365 days'
  ),
  Unit(
    type: 'data',
    price: '240000',
    reward: 'Дата хязгааргүй / 365 days'
  ),
];
