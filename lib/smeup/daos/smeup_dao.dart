class SmeupDao {
  static dynamic getClientDataStructure(
      dynamic clientData, dynamic optionsDefault, dynamic data,
      {String fieldName = 'value'}) {
    if (optionsDefault == null) {
      return {
        "rows": [
          {
            fieldName: clientData,
          }
        ],
      };
    } else {
      switch (optionsDefault['type']) {
        case 'acp':
          return {
            "rows": [
              {
                fieldName: clientData,
              }
            ],
          };

          break;

        default:
          return data;
      }
    }
  }
}
