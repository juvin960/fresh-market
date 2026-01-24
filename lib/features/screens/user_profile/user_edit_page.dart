import 'package:flutter/material.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  bool isDefault = false;

  final TextEditingController streetController =
  TextEditingController(text: "Mountain View Ave");
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController cityController =
  TextEditingController(text: "Westlands");
  final TextEditingController regionController =
  TextEditingController(text: "Nairobi");
  final TextEditingController postalController =
  TextEditingController(text: "10012");
  final TextEditingController phoneController =
  TextEditingController(text: "+1 (555) 000-0000");
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white.withOpacity(0.8)
                      : Colors.black.withOpacity(0.8),
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).dividerColor, width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back, size: 28)),
                  const Text(
                    'Edit Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Save',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map/Location Placeholder
                    Stack(
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.grey[300],
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuByuaRzr_gXxQH8yiswTXP7v5-kQN-xgIy-eWeCdoYznEWyAiNtga3NodMqPT886IQK83oY1ixlfqJX-f_QAgLq3mJSc2PsLLEzGZEboNgDoS4XhX6rqR0Ca_vzo3n7zvDbLJmp8xS28iGzylejr5H58EQx8F3WzM6wzYlOIZv_RSAESDw8xZ5HaUqdQeCX3ymag69lPlrVUIUtw7mNYNNuT0B-VHFLOc44WmiuaPB0P_QAaLx2cTi3r7hC7AVrTXMVc0nWaJDHZnU'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.my_location, size: 16),
                            label: const Text('Locate Me',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness ==
                                  Brightness.light
                                  ? Colors.white
                                  : Colors.grey[800],
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address Form
                    _buildLabelButtonRow(context),
                    const SizedBox(height: 12),
                    _buildTextField(
                        context, streetController, 'Street Address', Icons.home),
                    const SizedBox(height: 12),
                    _buildTextField(context, apartmentController,
                        'Apartment, Suite, etc. (Optional)', Icons.meeting_room),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(context, cityController, 'City',
                                Icons.location_city)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField(
                                context, regionController, 'Region', Icons.map)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                context, postalController, 'Postal Code', Icons.markunread_mailbox)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildTextField(
                                context, phoneController, 'Phone', Icons.phone)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTextArea(
                        context, noteController, 'Delivery Instructions'),
                    const SizedBox(height: 16),

                    // Default Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Set as Default Address',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(height: 2),
                            Text('Use this address for all future orders',
                                style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        Switch(
                            value: isDefault,
                            onChanged: (val) {
                              setState(() {
                                isDefault = val;
                              });
                            })
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Delete Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete Address'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelButtonRow(BuildContext context) {
    return Row(
      children: [
        _buildLabelButton('Home', true),
        const SizedBox(width: 8),
        _buildLabelButton('Work', false),
        const SizedBox(width: 8),
        _buildLabelButton('Other', false),
      ],
    );
  }

  Widget _buildLabelButton(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey[800],
          border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 12)),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller,
      String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[800]
                    : Colors.grey[300])),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey[900],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade300
                        : Colors.grey.shade700)),
          ),
        )
      ],
    );
  }

  Widget _buildTextArea(BuildContext context, TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[800]
                    : Colors.grey[300])),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey[900],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade300
                        : Colors.grey.shade700)),
          ),
        ),
      ],
    );
  }
}
//               hintText: 'Search for products',
//                 border: InputBorder.none,
//               ),           ),
//         ],
//       ),       );
//   }




//     );//   }
// }// }














