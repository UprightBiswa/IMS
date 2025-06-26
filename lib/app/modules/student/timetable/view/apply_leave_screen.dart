import 'package:flutter/material.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final TextEditingController _dateRangeController = TextEditingController();
  String? _selectedLeaveType;
  final TextEditingController _reasonController = TextEditingController();

  // Dummy list for leave types
  final List<String> _leaveTypes = ['Casual Leave', 'Sick Leave', 'Annual Leave', 'Maternity Leave'];

  @override
  void initState() {
    super.initState();
    // Initialize date range with today's date if applicable, or a default
    _dateRangeController.text = 'May 18, 2025'; // As per the image
  }

  @override
  void dispose() {
    _dateRangeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    // This is a simplified date picker for a single date or date range.
    // For actual date range selection, you'd use showDateRangePicker.
    // For a single date, use showDatePicker.
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateRangeController.text = _formatDate(picked); // Update with selected date
      });
    }
  }

  String _formatDate(DateTime date) {
    // Simple formatting for demonstration
    final List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background
      appBar: AppBar(
        title: const Text('Apply for Leave'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Apply for Leave',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fill out this form to submit a leave request to your department',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // Date Range Section
            _buildSectionTitle('Date Range'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDateRange(context),
                      child: AbsorbPointer(
                        // Prevents direct keyboard input to the TextField
                        child: TextField(
                          controller: _dateRangeController,
                          decoration: const InputDecoration(
                            hintText: 'Select Date Range',
                            border: InputBorder.none, // Remove default border
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          readOnly: true, // Make it read-only
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle "1 Day" button logic
                        print('1 Day button tapped');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700], // Darker blue
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        minimumSize: Size.zero, // Remove minimum size constraints
                      ),
                      child: const Text('1 Day'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Leave Type Section
            _buildSectionTitle('Leave Type'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLeaveType,
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Select Leave type',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLeaveType = newValue;
                    });
                  },
                  items: _leaveTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Reason for Leave Section
            _buildSectionTitle('Reason for Leave'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _reasonController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write here....',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16.0),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Supporting Documents Section
            _buildSectionTitle('Supporting Documents (Optional)'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Click to upload or drag and drop',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'PDF, JPG, PNG (max. 5MB)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Handle "Choose File" button tap
                      print('Choose File tapped');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Choose File'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Note Section
            const Text(
              'Note: By submitting this leave request, you acknowledge that:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            _buildNotePoint('Faculty may require additional documentation for leaves exceeding 3 days'),
            _buildNotePoint('Approval is subject to departmental policies and attendance requirements'),
            _buildNotePoint('Leaves during examination periods require special approval'),
            const SizedBox(height: 32),

            // Action Buttons (Cancel, Submit Request)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle Cancel button tap
                      print('Cancel tapped');
                      Navigator.pop(context); // Go back
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Submit Request button tap
                      print('Submit Request tapped');
                      print('Date Range: ${_dateRangeController.text}');
                      print('Leave Type: $_selectedLeaveType');
                      print('Reason: ${_reasonController.text}');
                      // Implement submission logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700], // Darker blue
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Submit Request'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildNotePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}