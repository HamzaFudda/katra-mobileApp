
import 'dart:async';

class OnBoardingBloc {
  final _streamPageChange = StreamController<int>();
  StreamSink<int> get pageChangeSink => _streamPageChange.sink;
  Stream<int> get pageChangeStream => _streamPageChange.stream;
  OnBoardingBloc() {
    pageChangeSink.add(0);
  }
}