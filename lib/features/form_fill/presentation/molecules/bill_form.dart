import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/data/models/bill_response.dart';
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
    @required this.onPressedRncOption,
    @required this.onPressedNcfOption,
    @required this.onPressedGrossTotalOption,
    @required this.onPressedItbisOption,
    @required this.onPressedDateOption,
    @required this.onTapTransactionType,
    @required this.onChangeTransactionType,
    @required this.onTapPaymentType,
    @required this.onChangePaymentType,
    @required this.onChangeDate,
    this.billResponse,
  })  : rncOptions = billResponse.rnc
            .map(
              (option) => ResponseOptionItem(
                label: option,
                value: option,
              ),
            )
            .toList(),
        nfcOptions = billResponse.ncf
            .map(
              (option) => ResponseOptionItem(
                label: option,
                value: option,
              ),
            )
            .toList(),
        grossTotalOptions = billResponse.grossTotal
            .map(
              (option) => ResponseOptionItem(
                label: '$option',
                value: option,
              ),
            )
            .toList(),
        itbisOptions = billResponse.itbis
            .map(
              (option) => ResponseOptionItem(
                label: '$option',
                value: option,
              ),
            )
            .toList(),
        dateOptions = billResponse.date
            .map(
              (option) => ResponseOptionItem(
                label: option.toString(),
                value: option,
              ),
            )
            .toList();

  final Bill bill;
  final BillResponse billResponse;
  final TextEditingController rncController;
  final TextEditingController ncfController;
  final TextEditingController grossTotalController;
  final TextEditingController itbisController;
  final int transactionType;
  final int paymentType;
  final DateTime date;
  final void Function(String) onPressedRncOption;
  final void Function(String) onPressedNcfOption;
  final void Function(num) onPressedGrossTotalOption;
  final void Function(num) onPressedItbisOption;
  final void Function(DateTime) onPressedDateOption;
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

  final List<ResponseOptionItem> rncOptions;

  final List<ResponseOptionItem> nfcOptions;

  final List<ResponseOptionItem> grossTotalOptions;

  final List<ResponseOptionItem> itbisOptions;

  final List<ResponseOptionItem> dateOptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldVariant(
          controller: rncController,
          hintText: 'RNC',
        ),
        SizedBox(
          height: 10,
        ),
        _buildOptions<String>(
          context,
          options: rncOptions,
          onPressed: onPressedRncOption,
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldVariant(
          controller: ncfController,
          hintText: 'NCF',
        ),
        SizedBox(
          height: 10,
        ),
        _buildOptions<String>(
          context,
          options: nfcOptions,
          onPressed: onPressedNcfOption,
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
          height: 10,
        ),
        _buildOptions<num>(
          context,
          options: grossTotalOptions,
          onPressed: onPressedGrossTotalOption,
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
          height: 10,
        ),
        _buildOptions<num>(
          context,
          options: itbisOptions,
          onPressed: onPressedItbisOption,
        ),
        SizedBox(
          height: 20,
        ),
        DatePicker(
          onChange: onChangeDate,
          dateSelected: date,
          labelText: 'Fecha',
          maxYear: DateTime.now().year,
          minYear: 1950,
        ),
        SizedBox(
          height: 10,
        ),
        _buildOptions<DateTime>(
          context,
          options: dateOptions,
          onPressed: onPressedDateOption,
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
                color: Colors.white,
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildOptions<T>(
    BuildContext context, {
    @required List<ResponseOptionItem> options,
    @required void Function(T value) onPressed,
    bool selected = false,
  }) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: options.isNotEmpty
          ? Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final option in options)
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: InputChip(
                        backgroundColor: Colors.brown.withOpacity(.7),
                        selected: selected,
                        onPressed: () => onPressed(option.value),
                        padding: EdgeInsets.all(5),
                        label: Text(
                          option.label,
                        ),
                      ),
                    ),
                ],
              ),
            )
          : Container(),
    );
  }
}

class ResponseOptionItem<T> {
  ResponseOptionItem({
    this.value,
    this.label,
  });

  final T value;
  final String label;
}
