import 'package:kannada_disco/resource/resource_card.dart';
import 'package:kannada_disco/resource/resource_grid.dart';

const List<ResourceGrid> allCards = [
  ResourceGrid(type: "Reading & Pronunciation", cards: readingCards),
  ResourceGrid(type: "Vocabulary", cards: vocabCards),
  ResourceGrid(type: "Grammar", cards: grammarCards),
  ResourceGrid(type: "Conversations", cards: conversationCards),
];

const List<ResourceCard> readingCards = [
  ResourceCard(topic: "vowels", resourceType: "reading"),
  ResourceCard(topic: "consonants", resourceType: "reading"),
  ResourceCard(topic: "diacritics", resourceType: "reading"),
  ResourceCard(topic: "digits", resourceType: "reading"),
];

const List<ResourceCard> vocabCards = [
  ResourceCard(topic: "pronouns", resourceType: "vocabulary"),
  ResourceCard(topic: "question_words", resourceType: "vocabulary"),
  ResourceCard(topic: "basic_verbs", resourceType: "vocabulary"),
  ResourceCard(topic: "numbers", resourceType: "vocabulary"),
  ResourceCard(topic: "family", resourceType: "vocabulary"),
  ResourceCard(topic: "time", resourceType: "vocabulary"),
  ResourceCard(topic: "swadesh_list", resourceType: "vocabulary"),
];

const List<ResourceCard> grammarCards = [
  ResourceCard(topic: "present_simple", resourceType: "grammar"),
  ResourceCard(topic: "present_continuous", resourceType: "grammar"),
  ResourceCard(topic: "past_simple", resourceType: "grammar"),
  ResourceCard(topic: "past_perfect", resourceType: "grammar"),
  ResourceCard(topic: "past_continuous", resourceType: "grammar"),
  ResourceCard(topic: "future_simple", resourceType: "grammar"),
  ResourceCard(topic: "negating_verbs", resourceType: "grammar"),
  ResourceCard(topic: "modality_suffixes", resourceType: "grammar"),
  ResourceCard(topic: "verb_suffixes", resourceType: "grammar"),
];

const List<ResourceCard> conversationCards = [
  ResourceCard(topic: "self_introductions", resourceType: "conversation"),
  ResourceCard(topic: "in_the_market", resourceType: "conversation"),
  ResourceCard(topic: "using_a_cab", resourceType: "conversation"),
];
