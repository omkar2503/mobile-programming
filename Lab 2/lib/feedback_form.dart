import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  String _selectedGender = "Male";
  double _rating = 1.0;

  // Email validation regex
  String? _emailValidator(String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Phone number validation regex
  String? _phoneValidator(String? value) {
    final regex = RegExp(r'^\+?[1-9]\d{1,14}$'); // E.164 international format
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.blue[50],
          title: Text(
            "Thank You, ${_nameController.text}!",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                const TextSpan(text: "Your Review:\n", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "${_reviewController.text}\n\n"),
                const TextSpan(text: "Your Rating:\n", style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "$_rating stars"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Form"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(_nameController, "Name"),
                  _buildTextField(_surnameController, "Surname"),
                  _buildTextField(_addressController, "Address"),
                  _buildTextField(
                    _emailController,
                    "Email",
                    type: TextInputType.emailAddress,
                    validator: _emailValidator,
                  ),
                  _buildTextField(
                    _phoneController,
                    "Phone Number",
                    type: TextInputType.phone,
                    validator: _phoneValidator,
                  ),
                  _buildDropdown(),
                  _buildTextField(_reviewController, "Review", type: TextInputType.text, maxLines: 3),
                  const SizedBox(height: 10),
                  const Text(
                    "Rating:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  _buildRatingBar(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: Colors.orangeAccent,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                    ),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType type = TextInputType.text, int maxLines = 1, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
        validator: validator ??
                (value) => value!.isEmpty ? "Please enter $label" : null, // Default validation
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        decoration: InputDecoration(
          labelText: "Gender",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        items: ["Male", "Female"]
            .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
            .toList(),
        onChanged: (value) => setState(() => _selectedGender = value!),
      ),
    );
  }

  Widget _buildRatingBar() {
    return RatingBar.builder(
      initialRating: _rating,
      minRating: 1,
      allowHalfRating: true,
      itemCount: 5,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: index < _rating.floor() ? Colors.orange : (index < _rating ? Colors.orangeAccent : Colors.grey),
      ),
      onRatingUpdate: (rating) => setState(() => _rating = rating),
    );
  }
}
