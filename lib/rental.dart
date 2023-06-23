import 'package:flutter/material.dart';

class RentalDateSelector extends StatefulWidget {
  final double jetCostPerWeek;

  RentalDateSelector({required this.jetCostPerWeek});

  @override
  _RentalDateSelectorState createState() => _RentalDateSelectorState();
}

class _RentalDateSelectorState extends State<RentalDateSelector> {
  DateTime? _startDate;
  DateTime? _endDate;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();

  Future<void> _selectDates(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  int _calculateRentalDurationInWeeks() {
    if (_startDate != null && _endDate != null) {
      final difference = _endDate!.difference(_startDate!);
      final weeks = difference.inDays ~/ 7;
      return weeks;
    }
    return 0;
  }

  double _calculateRentalCost() {
    final rentalDurationInWeeks = _calculateRentalDurationInWeeks();
    return rentalDurationInWeeks * widget.jetCostPerWeek;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Fecha de inicio: ${_startDate != null ? _startDate.toString() : 'Seleccionar'}',
              style: TextStyle(fontWeight: FontWeight.bold, ),

            ),
            SizedBox(height: 8),
            Text(
              'Fecha de término: ${_endDate != null ? _endDate.toString() : 'Seleccionar'}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDates(context),
              child: Text('Seleccionar fechas'),
            ),
            SizedBox(height: 16),
            if (_startDate != null && _endDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duración de la renta: ${_calculateRentalDurationInWeeks()} semanas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Costo total de la renta: \$${_calculateRentalCost().toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Detalles del cliente:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Número de teléfono',
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _detailsController,
                    decoration: InputDecoration(
                      labelText: 'Detalles adicionales',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Acción al hacer clic en el botón "Enviar"
                      String name = _nameController.text;
                      String phone = _phoneController.text;
                      String details = _detailsController.text;
                      // Aquí puedes realizar acciones con los datos del cliente, como enviarlos a través de una API o almacenarlos localmente
                    },
                    child: Text('Enviar'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
