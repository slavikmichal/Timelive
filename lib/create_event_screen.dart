import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:timelive/models/event_form_state.dart';
import 'package:timelive/models/timeline_zoom.dart';
import 'package:timelive/themes/color_schemer.dart';
import 'package:timelive/tile.dart';

import 'controllers/event_controller.dart';
import 'icon_indicator.dart';
import 'line_painter.dart';
import 'models/event.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formState = EventFormState();
  static const textShift = 0.19988425925925924769188314471879;
  final _textController = TextEditingController(text: '');

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headline(),
                _sideLine(screenWidth, context),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: (0.15 * MediaQuery.of(context).size.width), right: 50),
              child: Column(
                children: [
                  _addName(),
                  const SizedBox(height: 20),
                  _addDescription(),
                  const SizedBox(height: 20),
                  _addDate(context),
                  const SizedBox(height: 20),
                  _addTags(context),
                  const SizedBox(height: 20),
                  _uploadImages(),
                  const SizedBox(height: 20),
                  _saveEvent(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addTags(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _addTag(),
            SizedBox(height: (MediaQuery.of(context).size.height * 0.01)),
            _addTagButton(),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[for (var item in _formState.tags) Text('#' + item)],
        ),
      ],
    );
  }

  Widget _addTagButton() {
    return ElevatedButton(
      child: const Text("Add Tag"),
      onPressed: () {
        if (_textController.value.text != '') {
          setState(() {
            _formState.tags.add(_textController.value.text);
            _textController.clear();
          });
        }
      },
    );
  }

  Widget _saveEvent(BuildContext context) {
    return ElevatedButton(
      child: Text("Create event".toUpperCase()),
      onPressed: () {
        EventController.addEvent(_formState);
        //TODO confirmation
        Navigator.of(context).pop();
      },
    );
  }

  TextFormField _addName() {
    return TextFormField(
      initialValue: '',
      decoration: _inputDecoration('Event name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter name of the event';
        }
        return null;
      },
      onChanged: (value) {
        _formState.name = value;
      },
    );
  }

  Widget _addTag() {
    return TextFormField(
      controller: _textController,
      decoration: _inputDecoration('#tag'),
    );
  }

  TextFormField _addDescription() {
    return TextFormField(
      minLines: 4,
      // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: '',
      decoration: _inputDecoration('Event description'),
      onChanged: (value) {
        _formState.description = value;
      },
    );
  }

  Widget _headline() {
    return Tile(
      indicator: const IconIndicator(
        iconData: Icons.circle,
        size: 20,
      ),
      isFirst: false,
      isLast: false,
      event: Event(null, 'Create new event', '', DateTime.now(), []),
      showDate: false,
      zoom: TimelineZoom.shortDescription,
    );
  }

  Widget _sideLine(double screenWidth, BuildContext context) {
    return SizedBox(
      width: screenWidth * textShift,
      child: CustomPaint(
        painter: LinePainter(
          MediaQuery.of(context).size.height - 50,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {String helper = ''}) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      hintText: helper == '' ? null : helper,
    );
  }

  TextFormField _addDate(BuildContext context) {
    return TextFormField(
      initialValue: _formatDateTime(_formState.date),
      decoration: _inputDecoration('Event date'),
      onChanged: (value) {
        _formState.date = DateTime.parse(value);
      },
      //onTap: _selectDate(context),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != _formState.date) {
      setState(() {
        _formState.date = selected;
      });
    }
  }

  String _formatDateTime(DateTime date) {
    var day = date.day.toString().padLeft(2, '0');
    var month = date.month.toString().padLeft(2, '0');
    var year = date.year.toString();
    return "$day.$month.$year";
  }

  Widget _uploadImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Upload images'.toUpperCase(),
              textAlign: TextAlign.center,
              // overflow: TextOverflow,
              style: GoogleFonts.ubuntu(
                fontSize: 20,
                color: ColorSchemer.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Gallery"),
              onPressed: () {
                _getFromGallery();
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              child: const Text("Camera"),
              onPressed: () {
                _getFromCamera();
              },
            ),
          ],
        ),
        const Divider(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[for (var item in _formState.images) Text(basename(item.path))],
        ),
      ],
    );
  }

  _getFromGallery() async {
    List<XFile>? files = await ImagePicker().pickMultiImage();
    if (files != null) {
      setState(() {
        files.forEach((file) {
          _formState.images.add(File(file.path));
        });
      });
    }
  }

  _getFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        _formState.images.add(File(file.path));
      });
    }
  }
}
