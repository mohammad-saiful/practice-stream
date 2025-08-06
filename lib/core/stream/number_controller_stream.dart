import 'dart:async';

class NumberControllerStream {
  NumberControllerStream() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      add(_count++);
      if (_count == 10) {
        close();
        timer.cancel();
      }
    });
  }

  var _count = 0;
  final StreamController<int> _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;
  void add(int number) => _controller.sink.add(number);
  void close() => _controller.close();
}
