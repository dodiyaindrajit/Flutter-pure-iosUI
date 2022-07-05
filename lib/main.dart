import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

enum Sky { midnight, viridian, cerulean }

Map skyColors = {
  Sky.midnight: Colors.blueAccent,
  Sky.viridian: const Color(0xff5fc9a6),
  Sky.cerulean: const Color(0xff39bae8),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'CupertinoSliverNavigationBar Sample';

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: _title,
      home: CupertinoNavBarSample(),
    );
  }
}

class CupertinoNavBarSample extends StatefulWidget {
  const CupertinoNavBarSample({Key? key}) : super(key: key);

  @override
  State<CupertinoNavBarSample> createState() => _CupertinoNavBarSampleState();
}

class _CupertinoNavBarSampleState extends State<CupertinoNavBarSample> {
  Sky _selectedSegment = Sky.midnight;
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  DateTime dateTime = DateTime.now();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: skyColors[_selectedSegment],
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
          // A ScrollView that creates custom scroll effects using slivers.
          child: CustomScrollView(
            // A list of sliver widgets.
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                leading: const Icon(CupertinoIcons.person_2),
                // This title is visible in both collapsed and expanded states.
                // When the "middle" parameter is omitted, the widget provided
                // in the "largeTitle" parameter is used instead in the collapsed state.
                largeTitle: const Text('Contract'),
                trailing: CupertinoButton(
                  onPressed: () => _showAlertDialog(context),
                  child: const Icon(CupertinoIcons.add_circled),
                ),
              ),
              // This widget fills the remaining space in the viewport.
              // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
              SliverFillRemaining(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: () {
                    Form.of(primaryFocus!.context!)?.save();
                  },
                  child: CupertinoFormSection.insetGrouped(
                    header: const Text('User Information', textScaleFactor: 1.4),
                    margin: const EdgeInsets.all(10),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CupertinoContextMenu(
                          actions: <Widget>[
                            CupertinoContextMenuAction(
                              child: const Text('Upload Image'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoContextMenuAction(
                              child: const Text('Take Image'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                          child: Image.network(
                            "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Picture.png",
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      CupertinoTextFormFieldRow(
                        prefix: const Icon(CupertinoIcons.person),
                        placeholder: 'Enter Your Name',
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        validator: (String? value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Please enter valid name';
                          // }
                          return null;
                        },
                      ),
                      Card(
                        elevation: 0,
                        child: ListTile(
                          horizontalTitleGap: 0,
                          minLeadingWidth: 30,
                          leading: const Icon(
                            CupertinoIcons.bag,
                            color: Colors.blueAccent,
                          ),
                          title: const Text("Ready For Work ?"),
                          trailing: CupertinoSwitch(
                            value: true,
                            activeColor: Colors.blueAccent,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Joining Date"),
                            CupertinoButton(
                              // Display a CupertinoDatePicker in date picker mode.
                              onPressed: () => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: date,
                                  mode: CupertinoDatePickerMode.date,
                                  dateOrder: DatePickerDateOrder.dmy,
                                  // This is called when the user changes the date.
                                  onDateTimeChanged: (DateTime newDate) {
                                    setState(() => date = newDate);
                                  },
                                ),
                              ),
                              // In this example, the date value is formatted manually. You can use intl package
                              // to format the value based on user's locale settings.
                              child: Text(
                                '${date.month}-${date.day}-${date.year}',
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Starting Time"),
                            CupertinoButton(
                              // Display a CupertinoDatePicker in time picker mode.
                              onPressed: () => _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: time,
                                  mode: CupertinoDatePickerMode.time,
                                  dateOrder: DatePickerDateOrder.dmy,
                                  use24hFormat: false,
                                  // This is called when the user changes the time.
                                  onDateTimeChanged: (DateTime newTime) {
                                    setState(() => time = newTime);
                                  },
                                ),
                              ),
                              // In this example, the time value is formatted manually. You can use intl package to
                              // format the value based on the user's locale settings.
                              child: Text(
                                '${time.hour}:${time.minute}',
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Choose Employee Type"),
                            const SizedBox(height: 10),
                            CupertinoSlidingSegmentedControl<Sky>(
                              backgroundColor: CupertinoColors.systemGrey2,
                              thumbColor: skyColors[_selectedSegment]!,
                              // This represents the currently selected segmented control.
                              groupValue: _selectedSegment,
                              // Callback that sets the selected segmented control.
                              onValueChanged: (Sky? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedSegment = value;
                                  });
                                }
                              },
                              children: const <Sky, Widget>{
                                Sky.midnight: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Text(
                                    'Intern',
                                    style: TextStyle(color: CupertinoColors.white),
                                  ),
                                ),
                                Sky.viridian: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Freshers',
                                    style: TextStyle(color: CupertinoColors.white),
                                  ),
                                ),
                                Sky.cerulean: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    'Employee',
                                    style: TextStyle(color: CupertinoColors.white),
                                  ),
                                ),
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: CupertinoSlider(
                            key: const Key('slider'),
                            value: 10,
                            divisions: 10,
                            max: 100,
                            activeColor: Colors.blueAccent,
                            thumbColor: Colors.blueAccent,
                            onChanged: (double value) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CupertinoButton.filled(
                          onPressed: () {
                            Navigator.push(context,
                                CupertinoPageRoute<Widget>(builder: (BuildContext context) {
                              return const NextPage();
                            }));
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showAlter() {}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = CupertinoTheme.brightnessOf(context);
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            backgroundColor: CupertinoColors.systemYellow,
            border: Border(
              bottom: BorderSide(
                color:
                    brightness == Brightness.light ? CupertinoColors.black : CupertinoColors.white,
              ),
            ),
            // The middle widget is visible in both collapsed and expanded states.
            middle: const Text('Contacts Group'),
            // When the "middle" parameter is implemented, the larget title is only visible
            // when the CupertinoSliverNavigationBar is fully expanded.
            largeTitle: const Text('Family'),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text('Drag me up', textAlign: TextAlign.center),
                // When the "leading" parameter is omitted on a route that has a previous page,
                // the back button is automatically added to the leading position.
                Text('Tap on the leading button to navigate back', textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
