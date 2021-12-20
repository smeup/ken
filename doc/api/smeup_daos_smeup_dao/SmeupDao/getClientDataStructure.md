


# getClientDataStructure method








dynamic getClientDataStructure
(dynamic model)








## Implementation

```dart
static dynamic getClientDataStructure(dynamic model) {
  switch (model.type) {
    case 'LAB':
      var newList = List.empty(growable: true);
      (model.data as List).forEach((element) {
        newList.add({
          'value': element,
        });
      });
      return newList;
      break;

    case 'FLD':
      switch (model.optionsDefault['type']) {
        case 'itx':
        case 'acp':
          return {
            "rows": [
              {
                'value': model.data,
              }
            ],
          };

        default:
          return model.data;
      }
      break;

    default:
      return {"rows": model.data};
  }
}
```







