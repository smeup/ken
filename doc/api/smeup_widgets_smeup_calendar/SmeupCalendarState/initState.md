


# initState method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

void initState
()

_override_



<p>Called when this object is inserted into the tree.</p>
<p>The framework will call this method exactly once for each <a href="https://api.flutter.dev/flutter/widgets/State-class.html">State</a> object
it creates.</p>
<p>Override this method to perform initialization that depends on the
location at which this object was inserted into the tree (i.e., <a href="https://api.flutter.dev/flutter/widgets/State/context.html">context</a>)
or on the widget used to configure this object (i.e., <a href="https://api.flutter.dev/flutter/widgets/State/widget.html">widget</a>).</p>
<p>If a <a href="https://api.flutter.dev/flutter/widgets/State-class.html">State</a>'s <a href="../../smeup_widgets_smeup_calendar/SmeupCalendarState/build.md">build</a> method depends on an object that can itself
change state, for example a <a href="https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html">ChangeNotifier</a> or <a href="https://api.flutter.dev/flutter/dart-async/Stream-class.html">Stream</a>, or some
other object to which one can subscribe to receive notifications, then
be sure to subscribe and unsubscribe properly in <a href="../../smeup_widgets_smeup_calendar/SmeupCalendarState/initState.md">initState</a>,
<a href="https://api.flutter.dev/flutter/widgets/State/didUpdateWidget.html">didUpdateWidget</a>, and <a href="../../smeup_widgets_smeup_calendar/SmeupCalendarState/dispose.md">dispose</a>:</p>
<ul>
<li>In <a href="../../smeup_widgets_smeup_calendar/SmeupCalendarState/initState.md">initState</a>, subscribe to the object.</li>
<li>In <a href="https://api.flutter.dev/flutter/widgets/State/didUpdateWidget.html">didUpdateWidget</a> unsubscribe from the old object and subscribe
to the new one if the updated widget configuration requires
replacing the object.</li>
<li>In <a href="../../smeup_widgets_smeup_calendar/SmeupCalendarState/dispose.md">dispose</a>, unsubscribe from the object.</li>
</ul>
<p>You cannot use <a href="https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html">BuildContext.dependOnInheritedWidgetOfExactType</a> from this
method. However, <a href="https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html">didChangeDependencies</a> will be called immediately
following this method, and <a href="https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html">BuildContext.dependOnInheritedWidgetOfExactType</a> can
be used there.</p>
<p>Implementations of this method should start with a call to the inherited
method, as in <code>super.initState()</code>.</p>



## Implementation

```dart
@override
void initState() {
  super.initState();
  _selectedEvents = ValueNotifier([]);
  _model = widget.model;
  _data = widget.data;
  _firstWork = widget.initialFirstWork;
  _lastWork = widget.initialLastWork;
  startFunDate = SmeupCalendarModel.getStartFunDate(widget.initialDate);
  endFunDate = SmeupCalendarModel.getEndFunDate(widget.initialDate);
  _events = Map<DateTime, List<SmeupCalentarEventModel>>();
  _focusDay = widget.initialDate ?? DateTime.now();
  _selectedDay = widget.initialDate ?? DateTime.now();
  _calendarFormat =
      widget.showAsWeek ? CalendarFormat.week : CalendarFormat.month;
}
```







