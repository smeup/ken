


# setState method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

void setState
([VoidCallback](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html) fn)

_override_



<p>Notify the framework that the internal state of this object has changed.</p>
<p>Whenever you change the internal state of a <a href="https://api.flutter.dev/flutter/widgets/State-class.html">State</a> object, make the
change in a function that you pass to <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/setState.md">setState</a>:</p>
<pre class="language-dart"><code class="language-dart">setState(() { _myState = newValue; });
</code></pre>
<p>The provided callback is immediately called synchronously. It must not
return a future (the callback cannot be <code>async</code>), since then it would be
unclear when the state was actually being set.</p>
<p>Calling <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/setState.md">setState</a> notifies the framework that the internal state of this
object has changed in a way that might impact the user interface in this
subtree, which causes the framework to schedule a <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/build.md">build</a> for this <a href="https://api.flutter.dev/flutter/widgets/State-class.html">State</a>
object.</p>
<p>If you just change the state directly without calling <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/setState.md">setState</a>, the
framework might not schedule a <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/build.md">build</a> and the user interface for this
subtree might not be updated to reflect the new state.</p>
<p>Generally it is recommended that the <code>setState</code> method only be used to
wrap the actual changes to the state, not any computation that might be
associated with the change. For example, here a value used by the <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/build.md">build</a>
function is incremented, and then the change is written to disk, but only
the increment is wrapped in the <code>setState</code>:</p>
<pre class="language-dart"><code class="language-dart">Future&lt;void&gt; _incrementCounter() async {
  setState(() {
    _counter++;
  });
  Directory directory = await getApplicationDocumentsDirectory();
  final String dirName = directory.path;
  await File('$dir/counter.txt').writeAsString('$_counter');
}
</code></pre>
<p>It is an error to call this method after the framework calls <a href="../../smeup_widgets_smeup_buttons/SmeupButtonsState/dispose.md">dispose</a>.
You can determine whether it is legal to call this method by checking
whether the <a href="https://api.flutter.dev/flutter/widgets/State/mounted.html">mounted</a> property is true.</p>



## Implementation

```dart
@override
void setState(fn) {
  if (mounted) {
    super.setState(fn);
  }
}
```







