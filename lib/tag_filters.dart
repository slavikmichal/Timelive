import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelive/models/tag.dart';
import 'package:timelive/themes/color_schemer.dart';

class TagFilters extends StatefulWidget {
  final List<Tag> allTags;

  const TagFilters({Key? key, required this.allTags}) : super(key: key);

  @override
  _TagFiltersState createState() => _TagFiltersState();
}

class _TagFiltersState extends State<TagFilters> {
  TextEditingController inputController = TextEditingController();
  List<Tag> selectedTags = [];
  List<Tag> notSelectedTags = [];
  List<Tag> showedTags = [];


  @override
  void initState() {
    super.initState();

    showedTags = widget.allTags;
    notSelectedTags = widget.allTags;
  }

  void _selectFilter(Tag tag) {
    setState(() {
      selectedTags.add(tag);
      notSelectedTags.removeWhere((t) => t.name == tag.name);
      showedTags = notSelectedTags;
    });
  }

  void _onType(List<Tag> allTags, String pattern) {
    setState(() {
      showedTags = notSelectedTags.where((tag) => tag.name.startsWith(pattern)).toList();
    });
  }

  void _onChipClick(String label) {
    setState(() {
      Tag tagToRemove = selectedTags.where((element) => element.name == label).first;

      notSelectedTags.add(tagToRemove);
      selectedTags.remove(tagToRemove);
      showedTags = notSelectedTags;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(children: [
        _buildTitle(),
        _buildTextForm((val) => _onType(widget.allTags, val)),
        _buildTagList(),
        _buildSelectedTags(),
        _buildApplyFiltersButton()
      ]),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        'Filters',
        style: GoogleFonts.ubuntu(
          fontSize: 18,
          color: ColorSchemer.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTagList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: showedTags.length,
      itemBuilder: (context, index) =>
          ListTile(
            onTap: () => _selectFilter(showedTags.elementAt(index)),
            title: Text(
              showedTags
                  .elementAt(index)
                  .name,
            ),
          ),
    );
  }

  Widget _buildTextForm(ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        onChanged: onChanged,
        controller: inputController,
        style: GoogleFonts.ubuntu(
          fontSize: 18,
          color: ColorSchemer.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSelectedTags() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6,
          runSpacing: 6,
          children: selectedTags.map((e) => _buildChip(e.name, Color(e.color))).toList(),
        )
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style: GoogleFonts.ubuntu(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(6.0),
      deleteIcon: const Icon(Icons.clear),
      onDeleted: () => _onChipClick(label),
    );
  }

  Widget _buildApplyFiltersButton() {
    return TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Apply filters"));
  }
}
