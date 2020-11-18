import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/domain/entities/bill.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/date_picker.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/dropdown_button_variant.dart';
import 'package:form_filler/features/form_fill/presentation/atoms/text_field_variant.dart';

class BillForm extends StatelessWidget {
  BillForm({
    @required this.bill,
    @required this.rncController,
    @required this.ncfController,
    @required this.grossTotalController,
    @required this.itbisController,
    @required this.transactionType,
    @required this.paymentType,
    @required this.date,
    @required this.onTapTransactionType,
    @required this.onChangeTransactionType,
    @required this.onTapPaymentType,
    @required this.onChangePaymentType,
    @required this.onChangeDate,
  });

  final Bill bill;
  final TextEditingController rncController;
  final TextEditingController ncfController;
  final TextEditingController grossTotalController;
  final TextEditingController itbisController;
  final int transactionType;
  final int paymentType;
  final DateTime date;
  final void Function() onTapTransactionType;
  final void Function(int value) onChangeTransactionType;
  final void Function() onTapPaymentType;
  final void Function(int value) onChangePaymentType;
  final void Function(DateTime date) onChangeDate;

  final transationTypeOptions = {
    1: '01-GASTOS DE PERSONAL ',
    2: '02-GASTOS POR TRABAJOS, SUMINISTROS Y SERVICIOS ',
    3: '03-ARRENDAMIENTOS ',
    4: '04-GASTOS DE ACTIVOS FIJO ',
    5: '05 -GASTOS DE REPRESENTACIÓN ',
    6: '06 -OTRAS DEDUCCIONES ADMITIDAS ',
    7: '07 -GASTOS FINANCIEROS ',
    8: '08 -GASTOS EXTRAORDINARIOS ',
    9: '09 -COMPRAS Y GASTOS QUE FORMARAN PARTE DEL COSTO DE VENTA ',
    10: '10 -ADQUISICIONES DE ACTIVOS ',
    11: '11- GASTOS DE SEGUROS'
  };
  final paymentTypeOptions = {
    1: '01 - EFECTIVO',
    2: '02 - CHEQUES/TRANSFERENCIAS/DEPÓSITO',
    3: '03 - TARJETA CRÉDITO/DÉBITO',
    4: '04 - COMPRA A CREDITO',
    5: '05 -  PERMUTA',
    6: '06 - NOTA DE CREDITO',
    7: '07 - MIXTO'
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldVariant(
          controller: rncController,
          hintText: 'RNC',
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldVariant(
          controller: ncfController,
          hintText: 'NFC',
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldVariant(
          controller: grossTotalController,
          hintText: 'Total bruto',
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldVariant(
          controller: itbisController,
          hintText: 'ITBIS',
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20,
        ),
        DatePicker(
          onChange: onChangeDate,
          dateSelected: date,
          labelText: 'Fecha',
          maxYear: 2025,
          minYear: 1950,
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButtonVariant<int>(
          hint: Text('Tipo de transaccion'),
          items: _buildDropdownMenuItem<int>(
            context,
            items: transationTypeOptions,
          ),
          onChanged: onChangeTransactionType,
          value: transactionType,
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButtonVariant<int>(
          hint: Text('Tipo de pago'),
          items: _buildDropdownMenuItem<int>(
            context,
            items: paymentTypeOptions,
          ),
          onChanged: onChangePaymentType,
          value: paymentType,
        ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownMenuItem<T>(
    BuildContext context, {
    @required Map<T, String> items,
    Function() onTap,
  }) {
    return items.entries
        .map(
          (entry) => DropdownMenuItem(
            value: entry.key,
            onTap: onTap,
            child: Text(
              '${entry.value}',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        )
        .toList();
  }
}
