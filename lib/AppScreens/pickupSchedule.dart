import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Schedule extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleState();
}

class ScheduleState extends State<Schedule> {
  CalendarController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Schedule'),
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0)),
        body: Container(
            child: Column(
          children: <Widget>[
            TableCalendar(
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Color.fromRGBO(240, 153, 18, 1.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events){
                nextPage(context, date.month, date.day);
              },
              calendarController: controller,
            ),
          ],
        )));
  }
}

class popUp extends StatelessWidget{
  var day;
  var month;
  popUp(this.month, this.day);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 50,
      height:50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: Text("Do you want to pick up the groceries on $month/$day?", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, decoration: TextDecoration.none)),

    );
  }
}

void nextPage(BuildContext context, month, day) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return popUp(month, day);
      });
}



