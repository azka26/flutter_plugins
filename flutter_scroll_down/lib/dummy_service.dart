class DummyService {
  Future getDummys(int limit, int offset) {
    return Future.delayed(new Duration(seconds: 1)).then((data) {
      List<String> data = new List<String>();
      int maxData = limit + offset;
      for (int i = offset; i < maxData; i++) {
        data.add("Data Value " + i.toString());
      }
      return data;
    });
  }
}