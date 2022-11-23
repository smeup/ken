


# SmeupScriptingServices class






    *[<Null safety>](https://dart.dev/null-safety)*



<p>JavaScript snippets supported</p>
<p>Read data</p>
<pre class="language-javascript"><code class="language-javascript">dataHelper.read(collectionName, filters);
</code></pre>
<p>In example below we read from a collection with name locked-surnames the first
document with attribute surname, equals to variables.surname.
The value returned is an empty map if the document is missing</p>
<pre class="language-javascript"><code class="language-javascript">var record = await dataHelper.read('locked-surnames', {surname: variables.surname});
</code></pre>
<p>Insert data</p>
<pre class="language-javascript"><code class="language-javascript">dataHelper.insert(collection, data);
</code></pre>
<p>In the example below we insert some data into a collection with name audit</p>
<pre class="language-javascript"><code class="language-javascript">dataHelper.insert('audit', {surname: variables.surname, time: Date.now(), operation: 'insert'});
</code></pre>
<p>Display a message from javascript</p>
<pre class="language-javascript"><code class="language-javascript">helper.snackBar(message);
</code></pre>
<p>In the example below we display a message to the user informing him
the object is locked</p>
<pre class="language-javascript"><code class="language-javascript">helper.snackBar("You can't modify this object because is locked");
</code></pre>
<p>Required fields</p>
<pre class="language-javascript"><code class="language-javascript">var validated = helper.validateRequiredField(field, variables);
</code></pre>
<p>How to implement a field validation script
All functions must have this signature and returns always a boolean value</p>
<pre class="language-javascript"><code class="language-javascript">async validate(field, variables);
</code></pre>
<p>fieldId is the field identifier, and variables is a map which contains all
form variables</p>
<p>In the example below we'll use all snippets previously described</p>
<pre class="language-javascript"><code class="language-javascript">async function validate(field, variables) {
  var validated = helper.validateRequiredField(field);
  if (validated) {
    var record = await dataHelper.read('locked-surnames', {surname: variables.surname});
    validated = record.surname != variables.surname;
    if (!validated) {
      helper.snackBar("You can't modify this customer, because " + record.surname + " is locked");
    } else {
      dataHelper.insert('audit', {surname: variables.surname, time: Date.now(), operation: 'insert'});
    }
  };
  return validated;
}
</code></pre>



## Constructors

[SmeupScriptingServices](../smeup_services_smeup_scripting_services/SmeupScriptingServices/SmeupScriptingServices.md) ()

    


## Properties

##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_




## Methods

##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_





## Static Methods

##### [validate](../smeup_services_smeup_scripting_services/SmeupScriptingServices/validate.md)({required [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, required [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)? field, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? script}) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)>



   










