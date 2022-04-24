import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelive/bloc/events_cubit.dart';
import 'package:timelive/bloc/filters_cubit.dart';
import 'package:timelive/models/tag.dart';
import 'package:timelive/themes/color_schemer.dart';

class TagFilters extends StatefulWidget {
  final List<Tag> allTags;
  final List<Tag> activeTags;

  const TagFilters({Key? key, required this.allTags, required this.activeTags}) : super(key: key);

  @override
  _TagFiltersState createState() => _TagFiltersState();
}

class _TagFiltersState extends State<TagFilters> {
  TextEditingController inputController = TextEditingController();
  ScrollController upperController = ScrollController();
  ScrollController lowerController = ScrollController();
  List<Tag> selectedTags = [];
  List<Tag> notSelectedTags = [];
  List<Tag> showedTags = [];

  @override
  void initState() {
    super.initState();

    showedTags =
        widget.allTags.where((element) => !widget.activeTags.map((e) => e.name).contains(element.name)).toList();
    selectedTags = widget.activeTags;
    notSelectedTags = widget.allTags;
  }

  void _selectFilter(Tag tag) {
    setState(() {
      selectedTags.add(tag);
      notSelectedTags.removeWhere((t) => t.name == tag.name);
      showedTags.removeWhere((element) => element.name == tag.name);
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
      showedTags.add(tagToRemove);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitle(),
          _buildTextForm((val) => _onType(widget.allTags, val)),
          _buildTagList(),
          _buildSelectedTags(),
          _buildApplyFiltersButton(selectedTags, context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
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
    return Container(
      decoration: _decoration(),
      height: 250,
      child: Scrollbar(
        controller: upperController,
        isAlwaysShown: true,
        child: ListView.builder(
          controller: upperController,
          shrinkWrap: true,
          itemCount: showedTags.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () => _selectFilter(showedTags.elementAt(index)),
            title: Text(
              showedTags.elementAt(index).name,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextForm(ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        onChanged: onChanged,
        controller: inputController,
        decoration: const InputDecoration(
          labelText: 'Fulltext search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        style: GoogleFonts.ubuntu(
          fontSize: 14,
          color: ColorSchemer.textColor,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSelectedTags() {
    return Container(
      decoration: _decoration(),
      height: 250,
      child: Scrollbar(
        controller: lowerController,
        isAlwaysShown: true,
        child: ListView(
          controller: lowerController,
          shrinkWrap: true,
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: selectedTags.map((e) => _buildChip(e.name, Color(e.color))).toList(),
                ))
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: ColorSchemer.buttonColor.withOpacity(0.3),
      ),
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

  Widget _buildApplyFiltersButton(List<Tag> activeFilters, BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton.icon(
        label: Text(
          "Apply filters",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.ubuntu(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(Icons.filter_alt),
        onPressed: () {
          context.read<FiltersCubit>().setFilters(activeFilters);
          context.read<EventsCubit>().refreshEvents(activeFilters);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
