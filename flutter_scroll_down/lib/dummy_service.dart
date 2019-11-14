class DummyService {
  Future<List<String>> getDummys(String otherParameter, int limit, int offset) {
    if (otherParameter == null) otherParameter = "TEST";
    return Future.delayed(new Duration(seconds: 1)).then((data) {
      List<String> data = new List<String>();
      int maxData = limit + offset;
      for (int i = offset; i < maxData; i++) {
        data.add("Data Value (" + otherParameter + ") " + i.toString());
      }
      return data;
    });
  }
}