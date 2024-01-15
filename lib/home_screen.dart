import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flood_guard/app/app_toast.dart';
import 'package:flood_guard/flood_alert_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FloodAlertModel alertModel = FloodAlertModel();
  final floodAlertRef = FirebaseFirestore.instance
      .collection('FloodAlerts')
      .withConverter<FloodAlertModel>(
        fromFirestore: (snapshot, _) =>
            FloodAlertModel.fromJson(snapshot.data()),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Future<void> uploadFloodAlert({required FloodAlertModel floodAlertModel}) {
    return floodAlertRef.add(FloodAlertModel()).then((value) {
      print("User Added");
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => MapScreen(
      //         name: name,
      //         startLoc: startLoc,
      //         endLoc: endLoc,
      //       ),
      //     ));
    }).catchError((error) {
      AppToast.showErrorMessage(
          context, 'Something went wrong. Please try again.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: floodAlertRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              FloodAlertModel item = document as FloodAlertModel;
              bool isAlert = false;
              if (item.title != null) {
                isAlert = item.title == 'ALERT';
              }
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: isAlert
                      ? Icon(
                          Icons.warning_rounded,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                ),
                title: Text('${item.title}'),
                subtitle: Text('${item.message}'),
                trailing: Text('${item.location}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final DocumentSnapshot data;

  DetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['field_name']), // replace 'field_name'
      ),
      body: Center(
        // Display more details of the data here
        child: Text(data['detail_field']), // replace 'detail_field'
      ),
    );
  }
}
