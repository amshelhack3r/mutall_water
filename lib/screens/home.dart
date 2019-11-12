import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mutall_water/screens/ReadingInput.dart';
import 'package:mutall_water/util/db.dart';
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
    return FutureBuilder(future: provider.queryMeters(widget.type), builder: (context, snapshot){
//      print(snapshot.data);
    if(snapshot.connectionState == ConnectionState.none && snapshot.hasData==null){
      return Container();
    }
      return ListView.builder(
          itemCount: snapshot.data.length,
          padding: EdgeInsets.all(20.0),
          itemBuilder: (BuildContext _context, int i) {
            return _buildRow(snapshot.data[i]);
          });
    },);
  }

  Widget _buildRow(Meter meter) {
    print(meter);
    String mNum = meter?.number ?? "No meter";
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
      subtitle: Text(mNum),
      isThreeLine: true,
      onTap: () {
        print(meter.name);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReadingInput(meter)));
      },
    ));
  }
}
