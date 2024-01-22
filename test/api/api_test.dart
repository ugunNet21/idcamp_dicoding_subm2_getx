import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiService', () {
    late ApiService apiService;

    setUp(() {
      apiService = ApiService();
    });

    test('fetchData - GET request', () async {
      try {
        await apiService.fetchData('/nonexistent-endpoint');
        fail('Exception should be thrown');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), contains('Failed to load data: Status code: 404'));
      }
    });

    test('fetchData - POST request', () async {
      final body = {'key': 'value'};
      try {
        await apiService.fetchData('/sample-endpoint',
            body: body, method: 'POST');
        fail('Exception should be thrown');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), contains('Failed to load data: Status code: 404'));
      }
    });

    test('addReview', () async {
      try {
        await apiService.addReview('sample-restaurant-id', 'sample-name', '');
        fail('Exception should be thrown');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(
            e.toString(), contains('Failed to add review. Status code: 400'));
      }
    });
  });
}
