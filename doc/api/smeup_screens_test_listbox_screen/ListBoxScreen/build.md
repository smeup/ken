


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
<p>If a widget's <a href="../../smeup_screens_test_listbox_screen/ListBoxScreen/build.md">build</a> method is to depend on anything else, use a
<a href="https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html">StatefulWidget</a> instead.</p>
<p>See also:</p>
<ul>
<li><a href="https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html">StatelessWidget</a>, which contains the discussion on performance considerations.</li>
</ul>



## Implementation

```dart
@override
Widget build(BuildContext context) {
  return Theme(
    data: SmeupConfigurationService.getTheme(),
    child: Builder(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text('ListBox Screen')),
          actions: ShowCaseShared.getEmptyAction(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                  child: Column(
                children: [
                  ShowCaseShared.getTestLabel(_scaffoldKey, _formKey,
                      'This widget is a list of boxes whose format is predetermined by a layout. It is also possible to decide the number of columns'),
                  SmeupListBox(
                      _scaffoldKey,
                      _formKey,
                      {
                        "rows": [
                          {
                            "code": "wine production information:",
                            "description": "Italy 200.000L",
                            "info": "Information ford code 1",
                            "back": "R006G140B154"
                          },
                          {
                            "code": "wine production information:",
                            "description": "France 180.000L",
                            "info": "Information for code 2",
                            "back": "R006G140B154"
                          },
                          {
                            "code": "wine production information:",
                            "description": "Germany 90.000L",
                            "info": "Information for code 3",
                            "back": "R006G140B154"
                          }
                        ],
                        "columns": [
                          {"code": "code", "text": "codice", "IO": "O"},
                          {
                            "code": "description",
                            "text": "descrizione",
                            "IO": "O"
                          },
                          {"code": "info", "text": "informazioni", "IO": "H"},
                          {
                            "code": "back",
                            "text": "background color",
                            "IO": "H"
                          }
                        ]
                      },
                      height: 100,
                      listHeight: 300,
                      listType: SmeupListType.oriented,
                      fontSize: 16.0,
                      backColor: Colors.white,
                      showSelection: false,
                      selectedRow: 1,
                      id: 'listbox1', clientOnItemTap: (item) {
                    SmeupUtilities.invokeScaffoldMessenger(
                        context, 'item clicked: $item');
                  })
                ],
              )),
            ),
          ),
        ),
      ),
    ),
  );
}
```







