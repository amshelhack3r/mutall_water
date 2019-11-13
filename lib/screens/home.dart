import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mutall_water/State/ListProvider.dart';
import 'package:mutall_water/screens/ReadingInput.dart';
import 'package:mutall_water/util/db.dart';
import 'package:provider/provider.dart';
import '../models/Meter.dart';
import 'ReadingInput.dart';

class Home extends StatelessWidget {
  String type;
  Home(this.type);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Mutall Water Meter"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ClientList(type),
      ),
    );
  }
}

class ClientList extends StatefulWidget {
  String type;
  ClientList(this.type);
  @override
  State<StatefulWidget> createState() => _listState();
}

class _listState extends State<ClientList> {
  DatabaseProvider provider;
  @override
  initState() {
    super.initState();
    provider = new DatabaseProvider();
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ListProvider>(
      builder: (BuildContext context, ListProvider value, Widget child) =>ListView.builder(
          itemCount: value.getMeters(widget.type).length,
          padding: EdgeInsets.all(20.0),
          itemBuilder: (BuildContext _context, int i) {
            return _buildRow(value.getMeters(widget.type)[i]);
          }
      ),
    );
  }

  Widget _buildRow(Meter meter) {
    var leadingIcon;
    if(meter.type == "stima"){
      leadingIcon = Icon(FontAwesomeIcons.lightbulb);
    }else{
      leadingIcon = Icon(FontAwesomeIcons.tint);
    }
    return Card(
        child: ListTile(
      leading: leadingIcon,
      title: Text(meter.name),
      subtitle: Text(meter.number),
      isThreeLine: true,
      onTap: () {
        print(meter.name);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReadingInput(meter)));
      },
    ));
  }
}
