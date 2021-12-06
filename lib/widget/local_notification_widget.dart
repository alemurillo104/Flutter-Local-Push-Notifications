import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localpushnotifications/screen/second_screen.dart';
import 'package:localpushnotifications/utils/local_notification_helper.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    //Android Settings
    //here to parse the app icon that is in the folder : android/app/src/main/res/drawable
    final settingsAndroid = AndroidInitializationSettings('app_icon');

    //iOS Settings
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(payload)
    );

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification
    ); //the action when click the notification
  }

  Future onSelectNotification(String payload) async => 
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(payload: payload)),
    );

  Widget title(String text) => Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Text( text,
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          title('Basics Title'),
          ElevatedButton(
            child: Text(
              'Show notification',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () => showOngoingNotification(notifications,
                title: 'Title', body: 'Body'),
          ),

          ElevatedButton(
            child: Text(
              'Replace notification',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () => showOngoingNotification(notifications,
                title: 'ReplacedTitle', body: 'ReplacedBody'),
          ),

          //Other notification with a different id
          ElevatedButton(
            child: Text(
              'Other notification',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () => showOngoingNotification(notifications,
                title: 'OtherTitle', body: 'OtherBody', id: 20),
          ),
          SizedBox(height: 32),
          
          title('Feautures'),
          ElevatedButton(
            child: Text(
              'Silent notification',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () => showSilentNotification(notifications,
                title: 'SilentTitle', body: 'SilentBody', id: 30),
          ),

          SizedBox(height: 32),
         
          title('Cancel'),
          ElevatedButton(
            child: Text(
              'Cancel all notification',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: notifications.cancelAll,
          ),
        ],
      ),
    );
  }
}
