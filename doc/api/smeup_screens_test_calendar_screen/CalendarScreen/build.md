


# build method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) build
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)

_override_



<p>Describes the part of the user interface represented by this widget.</p>
<p>The framework calls this method when this widget is inserted into the tree
in a given <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a> and when the dependencies of this widget change
(e.g., an <a href="https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html">InheritedWidget</a> referenced by this widget changes). This
method can potentially be called in every frame and should not have any side
effects beyond building a widget.</p>
<p>The framework replaces the subtree below this widget with the widget
returned by this method, either by updating the existing subtree or by
removing the subtree and inflating a new subtree, depending on whether the
widget returned by this method can update the root of the existing
subtree, as determined by calling <a href="https://api.flutter.dev/flutter/widgets/Widget/canUpdate.html">Widget.canUpdate</a>.</p>
<p>Typically implementations return a newly created constellation of widgets
that are configured with information from this widget's constructor and
from the given <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a>.</p>
<p>The given <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a> contains information about the location in the
tree at which this widget is being built. For example, the context
provides the set of inherited widgets for this location in the tree. A
given widget might be built with multiple different <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a>
arguments over time if the widget is moved around the tree or if the
widget is inserted into the tree in multiple places at once.</p>
<p>The implementation of this method must only depend on:</p>
<ul>
<li>the fields of the widget, which themselves must not change over time,
and</li>
<li>any ambient state obtained from the <code>context</code> using
<a href="https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html">BuildContext.dependOnInheritedWidgetOfExactType</a>.</li>
</ul>
<p>If a widget's <a href="../../smeup_screens_test_calendar_screen/CalendarScreen/build.md">build</a> method is to depend on anything else, use a
<a href="https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html">StatefulWidget</a> instead.</p>
<p>See also:</p>
<ul>
<li><a href="https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html">StatelessWidget</a>, which contains the discussion on performance considerations.</li>
</ul>



## Implementation

```dart
@override
Widget build(BuildContext context) {
  MediaQueryData deviceInfo = MediaQuery.of(context);
  return Theme(
    data: SmeupConfigurationService.getTheme(),
    child: Builder(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Calendar Screen')),
          actions: ShowCaseShared.getEmptyAction(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                    'Highly customizable, feature-packed calendar widget for Flutter'),
                SmeupCalendar(_scaffoldKey, _formKey,
                    id: 'calendar1',
                    width: deviceInfo.size.width,
                    height: deviceInfo.size.height,
                    initialFirstWork: DateTime(DateTime.now().year, 01, 01),
                    initialLastWork: DateTime(DateTime.now().year, 12, 31),
                    initialDate: DateTime(DateTime.now().year, 01, 01),
                    dataColumnName: "value",
                    titleColumnName: "title",
                    styleColumnName: "style",
                    showPeriodButtons: false,
                    data: [
                      {
                        "value": "${DateTime.now().year}-01-18",
                        "title": "Fase 2 project Alfa",
                        "init": "100000",
                        "end": "103000"
                      },
                      {
                        "value": "${DateTime.now().year}-01-18",
                        "title": "Metting call (13:20)",
                        "init": "132000",
                      },
                      {
                        "value": "${DateTime.now().year}-01-18",
                        "title": "Flutter Tutorial",
                        "init": "132000",
                      },
                      {
                        "value": "${DateTime.now().year}-01-18",
                        "title": "Meet the parents",
                        "init": "132000",
                      },
                      {
                        "value": "${DateTime.now().year}-01-18",
                        "title": "Meet the Fockers",
                        "init": "132000",
                      },
                      {
                        "value": "${DateTime.now().year}-01-20",
                        "title": "Get to Interstellar"
                      },
                      {
                        "value": "${DateTime.now().year}-01-21",
                        "title": "Choose a new avatar"
                      },
                      {
                        "value": "${DateTime.now().year}-02-21",
                        "title": "Phone call with the martian"
                      }
                    ], clientOnDaySelected: (DateTime day) {
                  SmeupUtilities.invokeScaffoldMessenger(
                      context, "my onDaySelected $day");
                }, clientOnChangeMonth: (DateTime focusedDay) {
                  SmeupUtilities.invokeScaffoldMessenger(
                      context, "my onChangeMonth. focusedDay $focusedDay");
                }, clientOnEventClick: (SmeupCalentarEventModel event) {
                  SmeupUtilities.invokeScaffoldMessenger(
                      context, "my onEventClick $event");
                })
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
```







