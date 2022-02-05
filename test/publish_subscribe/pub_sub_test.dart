import 'package:flutter_test/flutter_test.dart';
import 'package:ocean/ocean.dart';

void main() {
  group('PubSub', () {
    test('Subcriber receives correct message value.', () async {
      // arrange
      final sut = PubSub<int>();
      final Subscriber<int> subscriber = sut;
      const int publishedValue = 1;
      const String publishedErrorMessage = 'errorMessage';
      bool wasCalled = false;
      subscriber.subscribe(
        expectAsync1<void, int>(
          (value) {
            expect(value, publishedValue);
          },
        ),
        onError: expectAsync1<void, dynamic>(
          (value) {
            expect(value, publishedErrorMessage);
          },
        ),
        onDone: expectAsync0<void>(
          () {
            wasCalled = true;
            expect(wasCalled, true);
          },
        ),
      );

      // act
      sut.publish(publishedValue);
      sut.publishError(publishedErrorMessage);
      sut.close();

      // assert
    });
  });
}
