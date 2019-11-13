import 'package:flutter/foundation.dart';
import 'package:mutall_water/models/Meter.dart';
import 'package:mutall_water/util/db.dart';

class ListProvider extends ChangeNotifier {
  List<Meter> _meters;
  var provider = DatabaseProvider();
  ListProvider() {
    init();
  
  }

  getMeters(type) => _meters.where((meter) => meter.type == type).toList();

  void removeMeter(Meter meter) {
    _meters.removeAt(_meters.indexOf(meter));
    notifyListeners();
  }

  void init() async {
    _meters = await provider.queryMeters();
      print("Database finished fetching");
      
  }
}
