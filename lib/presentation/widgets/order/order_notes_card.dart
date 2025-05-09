import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderNotesCard extends StatefulWidget {
  const OrderNotesCard({Key? key}) : super(key: key);

  @override
  State<OrderNotesCard> createState() => _OrderNotesCardState();
}

class _OrderNotesCardState extends State<OrderNotesCard> {
  final TextEditingController _notesController = TextEditingController();
  bool _isAddingNote = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: Icon(
                    _isAddingNote ? Icons.close : Icons.add,
                  ),
                  onPressed: () {
                    setState(() {
                      _isAddingNote = !_isAddingNote;
                      if (!_isAddingNote) {
                        _notesController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
            if (_isAddingNote) ...[
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  hintText: 'Add a note...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement note saving
                  setState(() {
                    _isAddingNote = false;
                    _notesController.clear();
                  });
                },
                child: const Text('Save Note'),
              ),
            ],
            const Divider(),
            // TODO: Implement notes list
            const Text('No notes yet'),
          ],
        ),
      ),
    );
  }
}
