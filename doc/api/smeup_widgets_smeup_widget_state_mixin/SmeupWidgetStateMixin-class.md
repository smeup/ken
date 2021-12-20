


# SmeupWidgetStateMixin class














**Implementers**

- [SmeupButtonsState](../smeup_widgets_smeup_buttons/SmeupButtonsState-class.md)
- [SmeupCalendarState](../smeup_widgets_smeup_calendar/SmeupCalendarState-class.md)



## Constructors

[SmeupWidgetStateMixin](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/SmeupWidgetStateMixin.md) ()

    


## Properties

##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_



##### [widgetLoadType](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/widgetLoadType.md) &#8596; [LoadType](../smeup_models_widgets_smeup_model/LoadType.md)



   
_read / write_




## Methods

##### [getChildren](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/getChildren.md)() [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupWidgetBuilderResponse](../smeup_models_smeupWidgetBuilderResponse/SmeupWidgetBuilderResponse-class.md)>



   




##### [getDataLoaded](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/getDataLoaded.md)(dynamic id) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



   




##### [getFunErrorResponse](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/getFunErrorResponse.md)([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [SmeupModel](../smeup_models_widgets_smeup_model/SmeupModel-class.md) model) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupWidgetBuilderResponse](../smeup_models_smeupWidgetBuilderResponse/SmeupWidgetBuilderResponse-class.md)>



   




##### [getInitialdataLoaded](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/getInitialdataLoaded.md)([SmeupModel](../smeup_models_widgets_smeup_model/SmeupModel-class.md) model) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



return the information if data has been loaded
static constructor: always false (because in this case the widget will receive the data directly)
dynamic constrctor: true if the model is not null and contains data   




##### [hasData](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/hasData.md)([SmeupModel](../smeup_models_widgets_smeup_model/SmeupModel-class.md) model) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



   




##### [hasSections](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/hasSections.md)([SmeupModel](../smeup_models_widgets_smeup_model/SmeupModel-class.md) model) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



   




##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [notifyError](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/notifyError.md)(dynamic context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) error) void



   




##### [runBuild](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/runBuild.md)([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) initialDataLoad, {[Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) notifierFunction}) [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html)



   




##### [runDispose](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/runDispose.md)([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id) void



   




##### [setDataLoad](../smeup_widgets_smeup_widget_state_mixin/SmeupWidgetStateMixin/setDataLoad.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) value) void



   




##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_











