Follow the list of the attributes of the smeup_components_library widgets with their defaults.

<a name="Shared">
### Shared
</a>

- scaffoldBackgroundColor   :   color of the screen backgroundColor
- primaryColor              :   main color of the application (convenient way to get the main color in static components)
- errorColor                :   color of the SnackBar'sbackgroundColor in case of error


<a name="SmeupAppBar">
### SmeupAppBar
</a>

    The SmeupAppBar does not have any default. Its style depend on "appBarTheme"
        
<a name="SmeupButton">
### SmeupButton
</a>

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

<a name="SmeupCalendar">
### SmeupCalendar
</a>

    json_theme's supported attributes:
        TODO

    Others attributes:
        TODO

<a name="SmeupCarousel">
### SmeupCarousel
</a>

    json_theme's supported attributes:
    
    Others attributes:
    height                  :   100
    autoPlay                :   false

<a name="SmeupChart">
### SmeupChart
</a>

    json_theme's supported attributes:
    
    Others attributes:
    - chartType             :   ChartType.Bar
    - refresh               :   -1
    - width                 :   100
    - height                :   100
    - legend                :   true


<a name="SmeupCombo">
### SmeupCombo
</a>

    json_theme's supported attributes:
    - fontColor             :   textTheme.bodyText1.color
    - fontSize              :   textTheme.bodyText1.fontSize
    - fontBold              :   textTheme.bodyText1.fontWeight 
    - backColor             :   textTheme.bodyText1.backgroundColor

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

<a name="SmeupDashboard">
### SmeupDashboard
</a>

    json_theme's supported attributes:
    - fontColor             :   textTheme.headline3.color
    - fontSize              :   textTheme.headline3.fontSize
    - fontBold              :   textTheme.headline3.fontWeight 
    
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

<a name="SmeupDrawer">
### SmeupDrawer
</a>

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

<a name="SmeupDatePicker">
### SmeupDatePicker
</a>

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

<a name="SmeupGauge">
### SmeupGauge
</a>

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

<a name="SmeupImage">
### SmeupImage
</a>

    json_theme's supported attributes:
    
    
    Others attributes:
    - width                   :   40
    - height                  :   40
    - padding                 :   EdgeInsets.all(0)
    - isRemote                :   false

<a name="SmeupImageList">
### SmeupImageList
</a>

    json_theme's supported attributes:
    - backColor             :   cardTheme.color
    - borderColor           :   cardTheme.shape.side.color
    - borderWidth           :   cardTheme.shape.side.width
    - borderRadius          :   cardTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)
    
    - fontColor             :   textTheme.headline1.color
    - fontSize              :   textTheme.headline1.fontSize
    - fontBold              :   textTheme.headline1.fontWeight 

    - captionFontColor      :   textTheme.headline2.color
    - captionFontSize       :   textTheme.headline2.fontSize
    - captionFontBold       :   textTheme.headline2.fontWeight 
        
    Others attributes:
    - width                 :   0
    - height                :   300
    - padding               :   EdgeInsets.only(left: 5, right: 5)
    - columns               :   0
    - rows                  :   0
    - orientation           :   Axis.vertical
    - listHeight            :   0

<a name="SmeupLabel">
### SmeupLabel
</a>

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

<a name="SmeupLine">
### SmeupLine
</a>

    json_theme's supported attributes:
    - color                 :   dividerTheme.color
    - thickness             :   dividerTheme.thickness

    Others attributes:

<a name="SmeupListBox">
### SmeupListBox
</a>

    json_theme's supported attributes:

    - backColor             :   cardTheme.color
    - borderColor           :   cardTheme.shape.side.color
    - borderWidth           :   cardTheme.shape.side.width
    - borderRadius          :   cardTheme.shape.borderRadius (note: the button will be available only with a 'rectangle' shape)
    
    - fontColor             :   textTheme.headline1.color
    - fontSize              :   textTheme.headline1.fontSize
    - fontBold              :   textTheme.headline1.fontWeight 

    - captionFontColor      :   textTheme.headline2.color
    - captionFontSize       :   textTheme.headline2.fontSize
    - captionFontBold       :   textTheme.headline2.fontWeight 

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

<a name="SmeupProgressBar">
### SmeupProgressBar
</a>

    json_theme's supported attributes:
    - color                 :   progressIndicatorTheme.color
    - linearTrackColor      :   progressIndicatorTheme.linearTrackColor

    Others attributes:
    - valueField            :   'value'
    - progressBarMinimun    :   0
    - progressBarMaximun    :   0
    - height                :   10
    - padding               :   EdgeInsets.all(0)

<a name="SmeupProgressIndicator">
### SmeupProgressIndicator
</a>

    json_theme's supported attributes:
    - color                 :   progressIndicatorTheme.color
    - circularTrackColor    :   progressIndicatorTheme.circularTrackColor

    Others attributes:
    - defaultSize           :   30

<a name="SmeupQRCodeReader">
### SmeupQRCodeReader
</a>

    json_theme's supported attributes:
    
    
    Others attributes:
    - padding                :   5.0
    - size                   :   200
    - maxReads               :   1
    - dealyInMillis          :   0

<a name="SmeupRadioButton">
### SmeupRadioButton
</a>

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

<a name="SmeupSlider">
### SmeupSlider
</a>

    json_theme's supported attributes:
    - activeTrackColor      :   sliderTheme.activeTrackColor
    - thumbColor            :   sliderTheme.thumbColor
    - inactiveTrackColor    :   sliderTheme.inactiveTrackColor

    Others attributes:
    - defaultPadding        :   EdgeInsets.only(left: 10, right: 10)
    - defaultSldMin         :   0
    - defaultSldMax         :   100

<a name="SmeupSplash">
### SmeupSplash
</a>

    json_theme's supported attributes:
    - color                 :   splashColor
    
    Others attributes:

<a name="SmeupSwitch">
### SmeupSwitch
</a>

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

<a name="SmeupTextAutocomplete">
### SmeupTextAutocomplete
</a>

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

<a name="SmeupTextField">
### SmeupTextField
</a>

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

<a name="SmeupTextPassword">
### SmeupTextPassword
</a>

    json_theme's supported attributes:
        TODO

    Others attributes:
        TODO

<a name="SmeupTimePicker">
### SmeupTimePicker
</a>

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

<a name="SmeupWait">
### SmeupWait
</a>

   The SmeupWait contains the following two widgets. Read their documentation for further information about their defaults:
    - [SmeupSplash](#SmeupSplash)
    - [SmeupProgressIndicator](#SmeupProgressIndicator)



