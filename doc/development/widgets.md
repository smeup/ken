# ken widgets

In this document you can find all about ken widgets.

## null safety

The ken library does not support null safety yet. It will be converted soon.

Make sure to declare a compatible sdk in your `pubspec.yaml` file:

    ...
    environment:
      sdk: ">=2.11.0 <3.0.0"
    ...

Also disable the null safety in the debug configuration:

    "args": [
        "--no-sound-null-safety"
    ]

## Icons

Icons, in the ken library, are treated as numeric values. You can find further information about [IconData codes](https://api.flutter.dev/flutter/material/Icons-class.html#constants) in the flutter documentation

## Themes

The style of ken widgets depends on the [json_theme](https://pub.dev/packages/json_theme) library. You can define your custon style in a json file that must be placed in the folder `/assets/jsons/themes/` The name must be declared in the folder `/assets/jsons/config.json`

    {
        ..
        "theme": "app.json",
        ..
    }

If you don't declare a custom style, the ken library will use its [internal theme file](https://github.com/smeup/ken/blob/develop/assets/jsons/themes/smeup_theme.json).

## Widgets

This section will list all ken widgets with their coresponding parameters and style's default.

### Structure of a widget

Each ken widget has two constructors:

#### Static constructor

Is the canonical Flutter constructor. It receives all the parameters in the constructor.

            SmeupButton(
              data: 'Hi there',
            ),

#### Dynamic constructor

Is the constructor that lets you add a widget to a Smeupdynamic screen dynamically through a json file. in this case you won't send the parameter in the constructor but you will define it in a json which represents the entire form. The form is divided in sections.

A section has the following orientations: row and column. Each section might contains only one component (widget) except when you have to define a TabBar. In this case, each component represent a Tab.

      {
        "loaded": true,
        "layout": "column",
        "id": "testForm",
        "type": "EXD",
        "title": "[description]",
        "sections": [
          {
            "id": "S1",
            "components": [
              {
                "type": "BTN",
                "id": "buttons_1",
                "options": {
                  "BTN": {
                    "default": {
                      "horiz": "Yes",
                      "backColor": "R255G000B000",
                      "borderColor": "R000G000B000",
                      "fontColor": "R000G000B000",
                      "padding": { "right": 5 },
                      "height": 50,
                      "width" : 300,
                      "fontSize": 20
                    }
                  }
                },
                "data": {
                  "rows": [
                    { "value": "I am a button" },
                    { "value": "I am a button too" }
                  ]
                }
              }
            ]
          }
        ]
      }

You don't instantiate a widget through the dynamic constructor, but instead send a json containing the page structure and its components to SmeupDynamicScreen which will create all the widgets for you. The dynamic constructor of a widget receives in input the part of the json that it will use to create the instance. The json will be parsed and used to fill the same parameters that you can pass through the static constructor.

The json will be sent from the dynamic constructor into the widget model.

Each widget can receive the data in two different ways:

- compilation time: the "data" property into the json file will contain the data to use in the component
- run time: the "fun" property into the json file will contain the function to execute when the widget is loaded. The "fun" property contains a Smeup [script language](#fun_script_language) used to reduce the syntax of the function.

### fun script language

.. TODO

### SmeupAppBar

[SmeupAppBar](https://github.com/smeup/ken/blob/develop/doc/api/smeup_widgets_smeup_appBar/smeup_widgets_smeup_appBar-library.md).

In the documentation you can find the input parameters to define a SmeupAppBar in your static Scaffold.

This widget is used internally by SmeupDynamicScreen, to create the top AppBar when it receives the json of the form.

- The property "title" is used as Title
- The property "buttons" is used to create the "actions" in the appBar

```
    {
            "layout": "column",
            "id": "testForm",
            "type": "EXD",
            "title": "[description]",
            "sections": [
                ....
            ],
            "buttons": [
                {
                    "icon": "59110",
                    "text": "Static Widgets",
                    "flat": true,
                    "dynamisms": [
                        {
                            "event": "click",
                            "exec": "F(EXD;*ROUTE;) 2(;;StaticScreen)",
                            "async": false
                        }
                    ]
                }
    }
```

Its style depends on:

        - "appBarTheme" if the dynamicScreen is a form
        - "dialogTheme" if the dynamicScreen is a dialog.

### SmeupButton

    json_theme's supported attributes:
    - backColor             :   elevatedButtonTheme.style.backgroundColor
    - borderColor           :   elevatedButtonTheme.style.side.color
    - borderWidth           :   elevatedButtonTheme.style.side.width
    - borderRadius          :   elevatedButtonTheme.style.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)
    - elevation             :   elevatedButtonTheme.style.elevation

    - fontColor             :   textTheme.button.color
    - fontSize              :   textTheme.button.fontSize
    - fontBold              :   textTheme.button.fontWeight

    - iconSize              :   iconTheme.size
    - iconColor             :   iconTheme.color

    Others attributes:
    - width                 :   0
    - height                :   70
    - position              :   MainAxisAlignment.center
    - align                 :   Alignment.center
    - padding               :   EdgeInsets.all(5)
    - valueField            :   'value'
    - innerSpace            :   10.0
    - isLink                :   false
    - orientation           :   WidgetOrientation.Vertical
    - iconData              :   0

### SmeupCalendar

    json_theme's supported attributes:
    - dayFontSize           :   textTheme.bodyText2.fontSize
    - eventFontSize         :   textTheme.headline3.fontSize
    - titleFontSize         :   textTheme.bodyText2.fontSize
    - markerFontSize        :   appBarTheme.titleTextStyle.fontSize

    json_theme's not overridable attributes:
    - width                 :   0
    - height                :   0
    - showPeriodButtons     :   true
    - titleColumnName       :   'XXDESC'
    - columnName            :   'XXDAT1'
    - columnName            :   'XXGRAF'
    - initTimeColumnName    :   'init'
    - endTimeColumnName     :   'end'
    - showAsWeek            :   false
    - showNavigation        :   true
    - padding               :   EdgeInsets.all(0)


    Others attributes:
        TODO

### SmeupCarousel

    json_theme's supported attributes:

    Others attributes:
    - height                :   100
    - autoPlay              :   false

### SmeupChart

    json_theme's supported attributes:

    Others attributes:
    - chartType             :   ChartType.Bar
    - refresh               :   -1
    - width                 :   100
    - height                :   100
    - legend                :   true

### SmeupCombo

    json_theme's supported attributes:
    - fontColor             :   textTheme.bodyText1.color
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor

    - borderColor           :   timePickerTheme.dayPeriodBorderSide.color
    - borderWidth           :   timePickerTheme.dayPeriodBorderSide.width
    - borderRadius          :   timePickerTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)

    - iconSize              :   iconTheme.size
    - iconColor             :   iconTheme.color

    - captionFontColor      :   textTheme.caption.color
    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor

    Others attributes:
    - width                 :   100
    - height                :   20
    - valueField            :   'value'
    - descriptionField      :   'description'
    - padding               :   EdgeInsets.all(0)
    - label                 :   ''
    - align                 :   Alignment.centerLeft
    - innerSpace            :   10.0
    - underline             :   true
    - showBorder            :   false

### SmeupDashboard

    json_theme's supported attributes:
    - fontColor             :   textTheme.headline1.color
    - fontSize              :   textTheme.headline1.fontSize
    - fontBold              :   textTheme.headline1.fontWeight

    - captionFontColor      :   textTheme.caption.color
    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight

    - iconSize              :   iconTheme.size
    - iconColor             :   iconTheme.color

    Others attributes:
    - padding               :   EdgeInsets.all(0)
    - width                 :   120
    - height                :   120
    - valueColName          :   'value'
    - iconColName           :   'icon'
    - textColName           :   'description'
    - umColName             :   'um'
    - selectLayout          :   ''
    - forceText             :   ''
    - forceIcon             :   ''
    - forceValue            :   ''
    - forceUm               :   ''
    - numberFormat          :   '*;0'

### SmeupDynamicScreen

    json_theme's supported attributes:


    Others attributes:
    - isDialog              :   false
    - backButtonVisible     :   true

    The backgroundColor is "scaffoldBackgroundColor" if SmeupDynamicScreen is a form and "dialogTheme.backgroundColor" if it is a dialog.

### SmeupDrawer

    json_theme's supported attributes:

    - defaultAppBarBackColor:   appBarTheme.backgroundColor

    - titleFontColor        :   appBarTheme.titleTextStyle.color
    - titleFontSize         :   appBarTheme.titleTextStyle.fontSize
    - titleFontBold         :   appBarTheme.titleTextStyle.fontWeight

    - elementFontColor      :   appBarTheme.toolbarTextStyle.color
    - elementFontSize       :   appBarTheme.toolbarTextStyle.fontSize
    - elementFontBold       :   appBarTheme.toolbarTextStyle.fontWeight

    Others attributes:
    - imageWidth            :   40
    - imageHeight           :   40
    - showItemDivider       :   true

### SmeupDatePicker

    json_theme's supported attributes:
    - borderColor           :   timePickerTheme.dayPeriodBorderSide.color
    - borderWidth           :   timePickerTheme.dayPeriodBorderSide.width
    - borderRadius          :   timePickerTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)
    - backColor             :   timePickerTheme.backgroundColor

    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor

    - elevation             :   elevatedButtonTheme.style.elevation

    Others attributes:
    - label                 :   ''
    - width                 :   100
    - height                :   100
    - padding               :   EdgeInsets.all(0)
    - showBorder            :   false
    - valueField            :   'value'
    - displayedField        :   'display'
    - align                 :   Alignment.topCenter
    - innerSpace            :   10.0
    - underline             :   true

### SmeupForm

    The SmeupAppBar is an internal widget, it can be used only statically.

    json_theme's supported attributes:

    Others attributes:
    - padding               :   EdgeInsets.all(8)
    - layout                :   '1'
    - autoAdaptHeight       :   true

### SmeupGauge

    json_theme's supported attributes:

    Others attributes:
    - valColName            :   'value'
    - maxColName            :   'maxValue'
    - minColName            :   'minValue'
    - warningColName        :   'warning'
    - maxValue              :   100
    - minValue              :   0
    - warning               :   50
    - value                 :   0

### SmeupImage

    json_theme's supported attributes:


    Others attributes:
    - width                   :   40
    - height                  :   40
    - padding                 :   EdgeInsets.all(0)
    - isRemote                :   false

### SmeupImageList

    json_theme's supported attributes:
    - backColor             :   cardTheme.color
    - borderColor           :   cardTheme.shape.side.color
    - borderWidth           :   cardTheme.shape.side.width
    - borderRadius          :   cardTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)

    - fontColor             :   textTheme.headline4.color
    - fontSize              :   textTheme.headline4.fontSize
    - fontBold              :   textTheme.headline4.fontWeight

    - captionFontColor      :   textTheme.headline5.color
    - captionFontSize       :   textTheme.headline5.fontSize
    - captionFontBold       :   textTheme.headline5.fontWeight

    Others attributes:
    - width                 :   0
    - height                :   300
    - padding               :   EdgeInsets.only(left: 5, right: 5)
    - columns               :   0
    - rows                  :   0
    - orientation           :   Axis.vertical
    - listHeight            :   0

### SmeupLabel

    json_theme's supported attributes:
    - fontColor             :   textTheme.bodyText2.color
    - fontSize              :   textTheme.bodyText2.fontSize
    - fontBold              :   textTheme.bodyText2.fontWeight
    - backColor             :   textTheme.bodyText2.backgroundColor

    - iconSize              :   iconTheme.size
    - iconColor             :   iconTheme.color

    Others attributes:
    - padding               :   EdgeInsets.all(0)
    - align                 :   Alignment.center
    - width                 :   0
    - height                :   15
    - valColName            :   'value'

### SmeupLine

    json_theme's supported attributes:
    - color                 :   dividerTheme.color
    - thickness             :   dividerTheme.thickness

    Others attributes:

### SmeupListBox

    json_theme's supported attributes:

    - backColor             :   cardTheme.color
    - borderColor           :   cardTheme.shape.side.color
    - borderWidth           :   cardTheme.shape.side.width
    - borderRadius          :   cardTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)

    - fontColor             :   textTheme.headline4.color
    - fontSize              :   textTheme.headline4.fontSize
    - fontBold              :   textTheme.headline4.fontWeight

    - captionFontColor      :   textTheme.headline5.color
    - captionFontSize       :   textTheme.headline5.fontSize
    - captionFontBold       :   textTheme.headline5.fontWeight

    Others attributes:
    - width                 :   0
    - height                :   170
    - padding               :   EdgeInsets.only(left: 5, right: 5)
    - listType              :   SmeupListType.oriented
    - portraitColumns       :   1
    - landscapeColumns      :   1
    - layout                :   '1'
    - orientation           :   Axis.vertical
    - defaultSort           :   ''
    - backgroundColName     :   ''
    - showSelection         :   false
    - selectedRow           :   -1
    - listHeight            :   0

### SmeupProgressBar

    json_theme's supported attributes:
    - color                 :   progressIndicatorTheme.color
    - linearTrackColor      :   progressIndicatorTheme.linearTrackColor

    Others attributes:
    - valueField            :   'value'
    - progressBarMinimun    :   0
    - progressBarMaximun    :   0
    - height                :   10
    - padding               :   EdgeInsets.all(0)

### SmeupProgressIndicator

    json_theme's supported attributes:
    - color                 :   progressIndicatorTheme.color
    - circularTrackColor    :   progressIndicatorTheme.circularTrackColor

    Others attributes:
    - defaultSize           :   30

### SmeupQRCodeReader

    json_theme's supported attributes:


    Others attributes:
    - padding                :   5.0
    - size                   :   200
    - maxReads               :   1
    - dealyInMillis          :   0

### SmeupRadioButton

    json_theme's supported attributes:
    - radioButtonColor      :   radioTheme.fillColor

    - fontColor             :   textTheme.bodyText1.color
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor

    - captionFontColor      :   textTheme.caption.color
    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor

    Others attributes:
    - defaultValueField     :   'code'
    - defaultDisplayedField :   'value'
    - defaultAlign          :   Alignment.centerLeft
    - defaultWidth          :   100
    - defaultHeight         :   75
    - defaultPadding        :   EdgeInsets.all(0)
    - defaultColumns        :   1

### SmeupSection

    The SmeupSection is an internal widget, it can be used only statically.

    - dim                   :   0
    - layout                :   ''
    - autoAdaptHeight       :   inherithed from SmeupForm

### SmeupSlider

    json_theme's supported attributes:
    - activeTrackColor      :   sliderTheme.activeTrackColor
    - thumbColor            :   sliderTheme.thumbColor
    - inactiveTrackColor    :   sliderTheme.inactiveTrackColor

    Others attributes:
    - defaultPadding        :   EdgeInsets.only(left: 10, right: 10)
    - defaultSldMin         :   0
    - defaultSldMax         :   100

### SmeupSplash

    json_theme's supported attributes:
    - color                 :   splashColor

    Others attributes:

### SmeupSwitch

    json_theme's supported attributes:
    - thumbColor            :   switchTheme.thumbColor
    - trackColor            :   switchTheme.trackColor

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor
    - captionFontColor      :   textTheme.caption.color

    Others attributes:
    - width                 :   100
    - height                :   50
    - align                 :   Alignment.center
    - padding               :   EdgeInsets.all(0)

### SmeupTextAutocomplete

    json_theme's supported attributes:
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor
    - fontColor             :   textTheme.bodyText1.color

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor
    - captionFontColor      :   textTheme.caption.color

    - borderColor           :   timePickerTheme.dayPeriodBorderSide.color
    - borderWidth           :   timePickerTheme.dayPeriodBorderSide.width
    - borderRadius          :   timePickerTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)

    Others attributes:
    - label                 :   ''
    - width                 :   100
    - height                :   100
    - padding               :   EdgeInsets.all(0)
    - showBorder            :   false
    - autoFocus             :   false
    - underline             :   true
    - submitLabel           :   ''
    - showSubmit            :   false
    - iconData              :   0

### SmeupTextField

    json_theme's supported attributes:
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor
    - fontColor             :   textTheme.bodyText1.color

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor
    - captionFontColor      :   textTheme.caption.color

    - borderColor           :   timePickerTheme.dayPeriodBorderSide.color
    - borderWidth           :   timePickerTheme.dayPeriodBorderSide.width
    - borderRadius          :   timePickerTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)

    Others attributes:
    - label                 :   ''
    - submitLabel           :   ''
    - width                 :   100
    - height                :   100
    - padding               :   EdgeInsets.all(0)
    - showBorder            :   false
    - autoFocus             :   false
    - valueField            :   'value'
    - showSubmit            :   false
    - underline             :   true

### SmeupTextPassword

    json_theme's supported attributes:
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor
    - fontColor             :   textTheme.bodyText1.color

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor
    - captionFontColor      :   textTheme.caption.color

    - iconSize              :   iconTheme.size
    - iconColor             :   iconTheme.color
    - buttonBackColor       :   primaryColor

    - borderColor           :   timePickerTheme.dayPeriodBorderSide.color
    - borderWidth           :   timePickerTheme.dayPeriodBorderSide.width
    - borderRadius          :   timePickerTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)

    Others attributes:
    - label                 :   ''
    - submitLabel           :   ''
    - width                 :   100
    - height                :   100
    - padding               :   EdgeInsets.all(0)
    - showBorder            :   false
    - autoFocus             :   false
    - valueField            :   'value'
    - showSubmit            :   false
    - underline             :   true
    - showRules             :   true
    - showRulesIcon         :   true
    - checkRules            :   true

### SmeupTimePicker

    json_theme's supported attributes:
    - borderColor           :   timePickerTheme.dayPeriodBorderSide.color
    - borderWidth           :   timePickerTheme.dayPeriodBorderSide.width
    - borderRadius          :   timePickerTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)
    - backColor             :   timePickerTheme.backgroundColor

    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight
    - backColor             :   textTheme.bodyText1.backgroundColor

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight
    - captionBackColor      :   textTheme.caption.backgroundColor

    - elevation             :   elevatedButtonTheme.style.elevation

    Others attributes:
    - label                 :   ''
    - width                 :   100
    - height                :   100
    - padding               :   EdgeInsets.all(0)
    - showBorder            :   false
    - valueField            :   'value'
    - displayedField        :   'display'
    - align                 :   Alignment.topCenter
    - innerSpace            :   10.0
    - underline             :   true

### SmeupWait

The SmeupWait contains the following two widgets. Read their documentation for further information about their defaults: - [SmeupSplash](#SmeupSplash) - [SmeupProgressIndicator](#SmeupProgressIndicator)

json_theme's supported attributes:
    - splashColor           :   splashColor
    - loaderColor           :   splashColor
    - circularTrackColor    :   progressIndicatorTheme.circularTrackColor

    Others attributes:

### Shared default styles

- `scaffoldBackgroundColor` : color of the screen backgroundColor. It's a convenient way to get the main color in static components where there is not
  an attribute to define them or as default color: - SmeupForm default color - SmeupSection backgroundColor - Dialog backgroundColor - SmeupButton with isLink attribute as bacbroundColor and borderColor - SmeupDatePicker when the border is hidden - SmeupTimePicker when the border is hidden
- `primaryColor` : the main color of the application. It's a convenient way to get the main color in static components where there isn't
  an attribute to define them or as default color: - background of the buttons in SmeupTextAutocomplete - background of the buttons in SmeupTextPassword

- `errorColor` : color of the SnackBar's backgroundColor in case of error
