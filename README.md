# mobile-components-library
Smeup mobile widgets' library is a set of widgets built on top of Flutter widgets.

## Icons

- Images and icons generator for ios
    https://easyappicon.com/   

- IconData codes
    https://api.flutter.dev/flutter/material/Icons-class.html#constants
    https://raw.githubusercontent.com/flutter/flutter/flutter-1.22-candidate.13/packages/flutter/lib/src/material/icons.dart
    
## Dependencies:
- dio:                      https://pub.dev/packages/dio
- provider:                 https://pub.dev/packages/provider
- permission_handler:       https://pub.dev/packages/permission_handler
- path_provider:            https://pub.dev/packages/path_provider
- flutter_speedometer:      https://pub.dev/packages/flutter_speedometer
- carousel_slider:          https://pub.dev/packages/carousel_slider
- table_calendar:           https://pub.dev/packages/table_calendar
- charts_flutter:           https://pub.dev/packages/charts_flutter
- expandable:               https://pub.dev/packages/expandable
- url_launcher:             https://pub.dev/packages/url_launcher
- flutter_datetime_picker:  https://pub.dev/packages/flutter_datetime_picker/
- intl:                     https://pub.dev/packages/intl

## Permissions

- storage

## Widgets default values
Follow the list of the attributes of the smeup_components_library widgets with their defaults.

<a name="SmeupButton">
### SmeupButton
</a>

    json_theme's supported attributes:
    - backColor             :   elevatedButtonTheme.style.backgroundColor
    - borderColor           :   elevatedButtonTheme.style.side.color
    - borderWidth           :   elevatedButtonTheme.style.side.width
    - borderRadius          :   elevatedButtonTheme.style.shape.borderRadius (note: the button will be avalable only with a 'rectangle' shape)
    - elevation             :   elevatedButtonTheme.style.elevation

    - fontColor             :   textTheme.button.color
    - fontSize              :   textTheme.button.fontSize
    - fontBold              :   textTheme.button.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - underline             :   the underline attribute is a boolean and decides wheter or not a SmeupLine should be shown under the SmeupDatePicker. 

   Notes:
    See [SmeupLine](#SmeupLine) for further information about SmeupLine. 

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

<a name="SmeupLabel">
### SmeupLabel
</a>

    json_theme's supported attributes:
    - fontColor             :   textTheme.bodyText2.color
    - fontSize              :   textTheme.bodyText2.fontSize
    - fontBold              :   textTheme.bodyText2.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - backColor             :   textTheme.bodyText2.backgroundColor

    - iconSize              :   iconTheme.size
    - iconColor             :   iconTheme.color

    Others attributes:
    - padding               :   EdgeInsets.all(0)
    - align                 :   Alignment.center
    - width                 :   0
    - height                :   15
    - valColName            :   'value'

<a name="SmeupDatePicker">
### SmeupDatePicker
</a>

    json_theme's supported attributes:
    - borderColor           :   timePickerThemeData.dayPeriodBorderSide.color
    - borderWidth           :   timePickerThemeData.dayPeriodBorderSide.width
    - borderRadius          :   timePickerThemeData.shape.borderRadius (note: the button will be avalable only with a 'rectangle' shape)
    - backColor             :   timePickerThemeData.backgroundColor

    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - backColor             :   textTheme.bodyText1.backgroundColor

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - captionBackColor      :   textTheme.caption.backgroundColor

    - elevation             :   elevatedButtonTheme.style.elevation

    - underline             :   the underline attribute is a boolean and decides wheter or not a SmeupLine should be shown under the SmeupDatePicker. 

   Notes:
    See [SmeupLine](#SmeupLine) for further information about SmeupLine. 

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

<a name="SmeupLine">
### SmeupLine
</a>

    json_theme's supported attributes:
    - color                 :   textTheme.caption.color

    Others attributes:
    - defaultThickness      :   1
    
<a name="SmeupRadioButton">
### SmeupRadioButton
</a>

    json_theme's supported attributes:
    - radioButtonColor      :   radioTheme.fillColor

    - fontColor             :   textTheme.bodyText1.color
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - backColor             :   textTheme.bodyText1.backgroundColor

    - captionFontColor      :   textTheme.caption.color
    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - captionBackColor      :   textTheme.caption.backgroundColor

    Others attributes:
    - defaultValueField     :   'code'
    - defaultDisplayedField :   'value'
    - defaultAlign          :   Alignment.centerLeft
    - defaultWidth          :   100
    - defaultHeight         :   75
    - defaultPadding        :   EdgeInsets.all(0)
    - defaultColumns        :   1


<a name="SmeupTimePicker">
### SmeupTimePicker
</a>

    json_theme's supported attributes:
    - borderColor           :   timePickerThemeData.dayPeriodBorderSide.color
    - borderWidth           :   timePickerThemeData.dayPeriodBorderSide.width
    - borderRadius          :   timePickerThemeData.shape.borderRadius (note: the button will be avalable only with a 'rectangle' shape)
    - backColor             :   timePickerThemeData.backgroundColor

    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - backColor             :   textTheme.bodyText1.backgroundColor

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - captionBackColor      :   textTheme.caption.backgroundColor

    - elevation             :   elevatedButtonTheme.style.elevation

    - underline             :   the underline attribute is a boolean and decides wheter or not a SmeupLine should be shown under the SmeupDatePicker. 

   Notes:
    See [SmeupLine](#SmeupLine) for further information about SmeupLine. 

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

<a name="SmeupSwitch">
### SmeupSwitch
</a>

    json_theme's supported attributes:
    - thumbColor            :   switchTheme.thumbColor
    - trackColor            :   switchTheme.trackColor

    - captionFontSize       :   textTheme.caption.fontSize
    - captionFontBold       :   textTheme.caption.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - captionBackColor      :   textTheme.caption.backgroundColor
    - captionFontColor      :   textTheme.caption.color

    Others attributes:
    - width                 :   100
    - height                :   50
    - align                 :   Alignment.center
    - padding               :   EdgeInsets.all(0)