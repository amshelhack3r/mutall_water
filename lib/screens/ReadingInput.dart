import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutall_water/State/ListProvider.dart';
import 'package:mutall_water/models/Input.dart';
import 'package:mutall_water/util/fetch.dart';
import 'package:provider/provider.dart';
import '../models/Meter.dart';
import 'package:http/http.dart' as http;

class ReadingInput extends StatelessWidget {
  final Meter meter;
  TextEditingController controller = new TextEditingController();
  var url = 'http://mutall.co.ke/readings/insert_reading';

  ReadingInput(@required this.meter);

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ENTER READING"),
      ),
      body: Container(child: _inputBox(context)),
    );
  }

  Widget valueInput() {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "Enter Value",
          labelText: "Enter Value",
          border: OutlineInputBorder()),
    );
  }

  Widget _inputBox(BuildContext context) {
    return Center(
      child: Card(
          elevation: 4,
          child: SizedBox(
            width: 350,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  meter.name,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(meter.number,
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w200)),
                Container(width: 250, child: valueInput()),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () async {
                    Fetch fetch = Fetch();
                    if (await fetch.uploadReading(
                        Input(meter.primary, controller.text, meter.type))) {
                      Fluttertoast.showToast(
                          msg: "record inserted",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.greenAccent[400],
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Provider.of<ListProvider>(context).removeMeter(meter);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Error occured",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Text("UPLOAD"),
                )
              ],
            ),
          )),
    );
  }
}
