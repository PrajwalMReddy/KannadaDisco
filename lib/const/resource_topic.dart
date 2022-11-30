import 'package:kannada_disco/element/resource_card.dart';
import 'package:kannada_disco/element/resource_grid.dart';

const List<ResourceGrid> allCards = [
  ResourceGrid(type: "Reading & Pronunciation", cards: readingCards),
  ResourceGrid(type: "Vocabulary", cards: vocabCards),
  ResourceGrid(type: "Tenses", cards: tenseCards),
  ResourceGrid(type: "Grammar", cards: grammarCards),
];

const List<ResourceCard> readingCards = [
  ResourceCard(topic: "vowels", resourceType: "reading"),
  ResourceCard(topic: "consonants", resourceType: "reading"),
  ResourceCard(topic: "diacritics", resourceType: "reading"),
];

const List<ResourceCard> vocabCards = [
  ResourceCard(topic: "pronouns", resourceType: "vocabulary"),
  ResourceCard(topic: "basic_verbs", resourceType: "vocabulary"),
  ResourceCard(topic: "numbers", resourceType: "vocabulary"),
  ResourceCard(topic: "family", resourceType: "vocabulary"),
  ResourceCard(topic: "time_phrases", resourceType: "vocabulary"),
];

const List<ResourceCard> tenseCards = [
  ResourceCard(topic: "present_simple", resourceType: "tense"),
  ResourceCard(topic: "present_continuous", resourceType: "tense"),
  ResourceCard(topic: "past_simple", resourceType: "tense"),
  ResourceCard(topic: "past_perfect", resourceType: "tense"),
  ResourceCard(topic: "past_continuous", resourceType: "tense"),
  ResourceCard(topic: "future_simple", resourceType: "tense"),
];

const List<ResourceCard> grammarCards = [
  ResourceCard(topic: "negating_verbs", resourceType: "grammar"),
  ResourceCard(topic: "verb_suffixes", resourceType: "grammar"),
  ResourceCard(topic: "other_verb_suffixes", resourceType: "grammar"),
];
