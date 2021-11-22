# mobile-components-library
Smeup mobile widgets' library 

[_TOC_]

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

## Widgets 
Follow the list of the json_theme's style supported by the smeup_components_library widgets.

### SmeupButton
    - backColor         :   elevatedButtonTheme.style.backgroundColor
    - borderColor       :   elevatedButtonTheme.style.side.color
    - borderWidth       :   elevatedButtonTheme.style.side.width
    - borderRadius      :   elevatedButtonTheme.style.shape.borderRadius (note: the button will be avalable only with a 'rectangle' shape)
    - elevation         :   elevatedButtonTheme.style.elevation

    - fontColor         :   textTheme.button.color
    - fontSize          :   textTheme.button.fontSize
    - fontBold          :   textTheme.button.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - underline         :   textTheme.button.decoration (values: ['lineThrough', 'none', 'overline', 'underline'])

    - iconSize          :   iconTheme.size
    - iconColor         :   iconTheme.color

### SmeupLabel
    - fontColor         :   textTheme.bodyText2.color
    - fontSize          :   textTheme.bodyText2.fontSize
    - fontBold          :   textTheme.bodyText2.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - backColor         :   textTheme.bodyText2.backgroundColor

    - iconSize          :   iconTheme.size
    - iconColor         :   iconTheme.color

### SmeupDatePicker
    - borderColor       :   timePickerThemeData.dayPeriodBorderSide.color
    - borderWidth       :   timePickerThemeData.dayPeriodBorderSide.width
    - borderRadius      :   timePickerThemeData.shape.borderRadius (note: the button will be avalable only with a 'rectangle' shape)
    - backColor         :   timePickerThemeData.backgroundColor

    - fontSize          :   textTheme.bodyText1.fontSize
    - fontBold          :   textTheme.bodyText1.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - backColor         :   textTheme.bodyText1.backgroundColor

    - captionFontSize   :   textTheme.caption.fontSize
    - captionFontBold   :   textTheme.caption.fontWeight (values: ['bold','normal','w100','w200','w300','w400','w500','w600','w700','w800','w900'])
    - captionBackColor  :   textTheme.caption.backgroundColor

    - elevation         :   elevatedButtonTheme.style.elevation

    - underline         :   the underline attribute is a boolean and decides wheter or not a SmeupLine should be shown under the SmeupDatePicker. 

   Notes:
   See [SmeupLine](#SmeupLine) for further information about SmeupLine. 

<a name="SmeupLine">
### SmeupLine
</a>

    - color         :   textTheme.caption.color
    