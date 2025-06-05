import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class UnitsOfMeasure extends StatefulWidget {
  const UnitsOfMeasure({super.key});

  @override
  State<UnitsOfMeasure> createState() => _UnitsOfMeasureState();
}

class _UnitsOfMeasureState extends State<UnitsOfMeasure> {
  bool _isMetricSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Units of Measure',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUnitOption(
              'Metric',
              isSelected: _isMetricSelected,
              onTap: () => setState(() => _isMetricSelected = true),
            ),
            _buildDivider(),
            _buildUnitOption(
              'Imperial',
              isSelected: !_isMetricSelected,
              onTap: () => setState(() => _isMetricSelected = false),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitOption(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Icon(
              Icons.album,
              color: isSelected ? PrimaryColor : Colors.grey[600],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.15),
      thickness: 2,
      height: 16,
    );
  }
}
