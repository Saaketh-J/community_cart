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
        backgroundColor: Color.fromRGBO(3,168,147,1.0),
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
              onDaySelected: (date, events) {
                nextPage(context, date.month, date.day);
              },
              calendarController: controller,
            ),
            Container(padding: EdgeInsets.only(bottom: 20.0)),
            Align(
              alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child:Container(
                margin: EdgeInsets.only(left:10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )
                ),
                child: DataTable(
              columns: [
                DataColumn(label: Text("Name", style: TextStyle(fontSize: 15))),
                DataColumn(label: Text("Date", style: TextStyle(fontSize: 15))),
              ],
              rows: [
                DataRow(
                    cells: [DataCell(Text("Daniel", style: TextStyle(fontSize: 15))), DataCell(Text("4/7", style: TextStyle(fontSize: 15)))]),
                DataRow(
                    cells: [DataCell(Text("Lewis", style: TextStyle(fontSize: 15))), DataCell(Text("4/14", style: TextStyle(fontSize: 15)))]),
                DataRow(cells: [
                  DataCell(Text("Sebastian", style: TextStyle(fontSize: 15))),
                  DataCell(Text("4/21", style: TextStyle(fontSize: 15)))
                ]),
              ],
            ))))
          ],
        )));
  }
}

class popUp extends StatelessWidget {
  var day;
  var month;

  popUp(this.month, this.day);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new AlertDialog(
      backgroundColor: Color.fromRGBO(240, 153, 18, 1.0),
      title: Text("Do you want to pick up the groceries on $month/$day?",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(58, 66, 86, 1.0),
              decoration: TextDecoration.none)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      actions: [
        FlatButton(
          onPressed: () {},
          child: Text("Yes", style: TextStyle(color: Colors.white)),
        ),
        FlatButton(
          onPressed: () {},
          child: Text("No", style: TextStyle(color: Colors.white)),
        )
      ],
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
