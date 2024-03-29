import 'package:flutter/widgets.dart';
import 'package:kannada_disco/resource/resource_card.dart';
import 'package:kannada_disco/resource/resource_grid.dart';

const List<Widget> allCards = [
  ResourceGrid(type: "Reading & Pronunciation", cards: readingCards),
  ResourceGrid(type: "Vocabulary", cards: vocabCards),
  ResourceGrid(type: "Grammar", cards: grammarCards),
  ResourceGrid(type: "Conversation Phrasebook", cards: conversationCards),
];

const List<ResourceCard> readingCards = [
  ResourceCard(topic: "vowels", resourceType: "reading"),
  ResourceCard(topic: "consonants", resourceType: "reading"),
  ResourceCard(topic: "diacritics", resourceType: "reading"),
  ResourceCard(topic: "conjuncts", resourceType: "reading"),
  ResourceCard(topic: "digits", resourceType: "reading"),
];

const List<ResourceCard> vocabCards = [
  ResourceCard(topic: "pronouns", resourceType: "vocabulary"),
  ResourceCard(topic: "question_words", resourceType: "vocabulary"),
  ResourceCard(topic: "basic_verbs", resourceType: "vocabulary"),
  ResourceCard(topic: "modality_verbs", resourceType: "vocabulary"),
  ResourceCard(topic: "more_verbs", resourceType: "vocabulary"),
  ResourceCard(topic: "family", resourceType: "vocabulary"),
  ResourceCard(topic: "household_objects", resourceType: "vocabulary"),
  ResourceCard(topic: "fruits", resourceType: "vocabulary"),
  ResourceCard(topic: "vegetables", resourceType: "vocabulary"),
  ResourceCard(topic: "body_parts", resourceType: "vocabulary"),
  ResourceCard(topic: "colors", resourceType: "vocabulary"),
  ResourceCard(topic: "animals", resourceType: "vocabulary"),
  ResourceCard(topic: "directions", resourceType: "vocabulary"),
  ResourceCard(topic: "numbers", resourceType: "vocabulary"),
  ResourceCard(topic: "time_and_dates", resourceType: "vocabulary"),
  ResourceCard(topic: "swadesh_list", resourceType: "vocabulary"),
];

const List<ResourceCard> grammarCards = [
  // ResourceCard(topic: "case_endings", resourceType: "grammar"),
  ResourceCard(topic: "present_and_future", resourceType: "grammar"),
  ResourceCard(topic: "present_perfect", resourceType: "grammar"),
  ResourceCard(topic: "present_continuous", resourceType: "grammar"),
  ResourceCard(topic: "past_simple", resourceType: "grammar"),
  ResourceCard(topic: "past_continuous", resourceType: "grammar"),
  ResourceCard(topic: "negating_verbs", resourceType: "grammar"),
  ResourceCard(topic: "modality_suffixes", resourceType: "grammar"),
  ResourceCard(topic: "verb_suffixes", resourceType: "grammar"),
];

const List<ResourceCard> conversationCards = [
  ResourceCard(topic: "self_introductions", resourceType: "conversation"),
  ResourceCard(topic: "using_a_cab", resourceType: "conversation"),
  ResourceCard(topic: "the_market", resourceType: "conversation"),
  ResourceCard(topic: "health_and_medicine", resourceType: "conversation"),
  ResourceCard(topic: "in_a_restaurant", resourceType: "conversation"),
  ResourceCard(topic: "traffic_cops", resourceType: "conversation"),
  ResourceCard(topic: "government_offices", resourceType: "conversation"),
  ResourceCard(topic: "sightseeing", resourceType: "conversation"),
  ResourceCard(topic: "colloquial_language", resourceType: "conversation"),
];
