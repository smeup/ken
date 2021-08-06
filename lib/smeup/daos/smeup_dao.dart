class SmeupDao {
  static dynamic getClientDataStructure(dynamic model) {
    switch (model.type) {
      case 'LAB':
        var newList = List.empty(growable: true);
        (model.clientData as List).forEach((element) {
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
                  'value': model.clientData,
                }
              ],
            };

          default:
            return model.clientData;
        }
        break;

      default:
        return {"rows": model.clientData};
    }
  }
}
