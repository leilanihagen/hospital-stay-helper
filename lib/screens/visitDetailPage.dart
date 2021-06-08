import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hospital_stay_helper/class/visit.dart';
import 'package:hospital_stay_helper/components/tapEditBox.dart';
import 'package:hospital_stay_helper/main.dart';

class VisitDetailPage extends StatefulWidget {
  final Visit visit;
  final Function createNewNote, updateVisitFunction, updateNoteFunction;
  VisitDetailPage(
      {Key key,
      this.visit,
      this.createNewNote,
      this.updateVisitFunction,
      this.updateNoteFunction})
      : super(key: key);

  @override
  _VisitDetailPageState createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage> {
  final String purpleTheme = "#66558E";
  final String lightPinkTheme = "#FDEBF1";
  final String darkPinkTheme = "#ED558C";
  final String blueTheme = "#44B5CD";
  // final String darkGreenTheme = "#758C20";
  final String lightGreenTheme = "#A1BF36";

  getNotes() {
    return ListView.builder(
        itemCount: widget.visit.notes.length,
        itemBuilder: (context, index) {
          return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              // Title and note body:
              child: Wrap(
                children: [
                  // Title line:

                  // Note title:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TapEditBox(
                        visit: widget.visit,
                        inputData: widget.visit.notes[index].title,
                        dataType: 'title',
                        defaultText: "Enter title",
                        isEditingVisit: false,
                        updateFunction: widget.updateNoteFunction,
                        noteIndex: index,
                      ),
                      // Expanded(
                      //     // TODO: Replace placeholder:
                      //     child: RichText(
                      //         text: TextSpan(
                      //             text: '${widget.visit.notes[index].title}',
                      //             style:
                      //                 Theme.of(context).textTheme.headline6))),

                      // Note date/time:
                      Container(
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            // TODO: Replace placeholders:
                            TapEditBox(
                              visit: widget.visit,
                              dataType: 'time',
                              inputData: widget.visit.notes[index].time,
                              defaultText: 'Visit time',
                              isEditingVisit: false,
                              updateFunction: widget.updateNoteFunction,
                              noteIndex: index,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: 26.0,
                              width: 100.0,
                              margin: 1.0,
                              padding: 3.0,
                            ),
                            TapEditBox(
                              visit: widget.visit,
                              dataType: 'date',
                              inputData: widget.visit.notes[index].date,
                              defaultText: 'Visit date',
                              isEditingVisit: false,
                              updateFunction: widget.updateNoteFunction,
                              noteIndex: index,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(),
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: 26.0,
                              width: 100.0,
                              margin: 1.0,
                              padding: 3.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor(lightGreenTheme),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor(purpleTheme),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.createNewNote(widget.visit);
            });
            print("NOTE COUNT: " + '${widget.visit.notes.length}');
          },
        ),
        body: Column(
          children: [
            // Visit date and patientName line:
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 25.0, 2.0, 5.0),
              child: RichText(
                  text: TextSpan(
                      text: "${widget.visit.date}'s Visit",
                      style: Theme.of(context)
                          .textTheme
                          .apply(
                            bodyColor: Colors.white,
                            displayColor: Colors.white,
                          )
                          .headline4)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Visit date:
                TapEditBox(
                  visit: widget.visit,
                  dataType: 'date',
                  inputData: widget.visit.date,
                  defaultText: 'Visit date',
                  isEditingVisit: true,
                  updateFunction: widget.updateVisitFunction,
                  boxDecoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0)),
                  height: 32.0,
                  width: 120.0,
                ),
                // Visit patientName
                Container(
                  alignment: Alignment.centerRight,
                  child: TapEditBox(
                    visit: widget.visit,
                    dataType: 'patientName',
                    inputData: widget.visit.patientName,
                    defaultText: "Patient's name",
                    isEditingVisit: true,
                    updateFunction: widget.updateVisitFunction,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(8.0)),
                    height: 32.0,
                    width: 140.0,
                  ),
                ),
              ],
            ),

            // Add media buttons:
            // TODO (after first release): Enable Add media buttons:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.createNewNote(widget.visit);
                      });
                      print("NOTE COUNT: " + '${widget.visit.notes.length}');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: HexColor(purpleTheme)),
                    child: Row(
                      children: [
                        // Icon(Icons.add),
                        Icon(Icons.note_add),
                      ],
                    ))
                //     IconButton(
                //         icon: Icon(Icons.camera_alt),
                //         color: Colors.white,
                //         onPressed: () => {}),
                //     IconButton(
                //         icon: Icon(Icons.mic),
                //         color: Colors.white,
                //         onPressed: () => {})
              ],
            ),

            Expanded(child: getNotes()),
            ElevatedButton(
              child: ListTile(
                  leading: Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.white, size: 27),
                  title: Padding(
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    padding: EdgeInsets.fromLTRB(80, 0, 50, 0),
                  )),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return HexColor(blueTheme);
                    return HexColor(blueTheme); // Use the component's default.
                  },
                ),
              ),
            ), // Use Expanded to take up remaining space on screen
          ],
        ));
  }
}
