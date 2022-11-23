import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_calendar_event_model.dart';
import 'package:ken/smeup/screens/test/showcase_shared.dart';
import 'package:ken/smeup/widgets/ken_calendar.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_theme_configuration_service.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/CalendarScreen';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Theme(
      data: KenThemeConfigurationService.getTheme()!,
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
                  KenCalendar(_scaffoldKey, _formKey,
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
                    KenUtilities.invokeScaffoldMessenger(
                        context, "my onDaySelected $day");
                  }, clientOnChangeMonth: (DateTime focusedDay) {
                    KenUtilities.invokeScaffoldMessenger(
                        context, "my onChangeMonth. focusedDay $focusedDay");
                  }, clientOnEventClick: (KenCalendarEventModel event) {
                    KenUtilities.invokeScaffoldMessenger(
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
}
