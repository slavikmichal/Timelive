import 'package:faker/faker.dart';
import 'package:timelive/controllers/event_controller.dart';
import 'package:timelive/models/event_form_state.dart';
import 'package:timelive/models/tag.dart';

class DataGenerator {

  static const int elementsCountToGenerate = 5;

  static List<Tag> allTags = [];
  static Faker get faker => Faker();

  static void generateSomeData() async {
    if (allTags.isEmpty) {
      allTags = await EventController.getAllTags();
    }

    for (int i = 0; i < elementsCountToGenerate; i++) {
      var generatedEvent = generateEvent();
      EventController.addEvent(generatedEvent);
    }
  }

  static EventFormState generateEvent() {
    EventFormState event = EventFormState();

    String eventName = '${faker.company.name()} ${faker.sport.name()}';
    String description = faker.lorem.sentences(faker.randomGenerator.integer(8, min: 3)).join(" ");
    DateTime eventDate = faker.date.dateTime(minYear: 2012, maxYear: 2022);

    event.name = eventName;
    event.description = description;
    event.date = eventDate;

    var tagsIndexes = faker.randomGenerator.numbers(allTags.length, faker.randomGenerator.integer(4, min: 1));

    for (int element in tagsIndexes) {
      event.tags.add(allTags[element].name);
    }

    return event;
  }
}
