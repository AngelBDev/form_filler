/* import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/domain/repositories/form_repository.dart';
import 'package:form_filler/features/form_fill/domain/use_cases/scan_bill.dart';
import 'package:mockito/mockito.dart';

class FormRepositoryMock extends Mock implements FormRepository {}

void main() {
  FormRepositoryMock formRepository;
  ScanBill useCase;
  Bill bill;
  File image;
  Uint8List imageBytes;
  String base64Image;

  setUp(() {
    formRepository = FormRepositoryMock();
    useCase = ScanBill(repository: formRepository);
    imageBytes = image.readAsBytesSync();
    base64Image = Base64Encoder().convert(imageBytes);
    bill = Bill(
      date: DateTime.now(),
      grossTotal: 1000,
      itbis: 180,
      ncf: '1111111',
      rnc: '2222222',
      paymentType: 2,
      transactionType: 1,
    );
  });

  test('should return the extracted data from the bill', () async {
    // arrange
    when(
      formRepository.scanBill(
        base64Image: argThat(isNotNull, named: 'base64Image'),
      ),
    ).thenAnswer(
      (_) async => Right(bill),
    );

    // assert
    final result = await useCase(ScanBillParams(base64Image: base64Image));

    expect(result, bill);
    verify(formRepository.scanBill(base64Image: base64Image));
    verifyNoMoreInteractions(formRepository);
  });
} */
