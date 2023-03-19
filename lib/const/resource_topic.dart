import 'package:flutter/widgets.dart'; 
import 'package:kannada_disco/resource/resource_card.dart';    
import 'package:kannada_disco/resource/resource_grid.dart';

const List<Widget> allCards = [
  ResourceGrid(type: "Reading & Pronunciation", cards: readingCards),
  SizedBox(height: 20,),
  ResourceGrid(type: "Vocabulary", cards: vocabCards), 
  SizedBox(height: 20,),
  ResourceGrid(type: "Grammar", cards: grammarCards),
  SizedBox(height: 20,),
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
  ResourceCard(topic: "more_verbs", resourceType: "vocabulary"),
  ResourceCard(topic: "directions", resourceType: "vocabulary"),
  ResourceCard(topic: "family", resourceType: "vocabulary"),
  ResourceCard(topic: "household_objects", resourceType: "vocabulary"),
  ResourceCard(topic: "fruits_and_vegetables", resourceType: "vocabulary"),
  ResourceCard(topic: "colors", resourceType: "vocabulary"),
  ResourceCard(topic: "animals", resourceType: "vocabulary"),
  ResourceCard(topic: "numbers", resourceType: "vocabulary"),
  ResourceCard(topic: "time_and_dates", resourceType: "vocabulary"),
  ResourceCard(topic: "swadesh_list", resourceType: "vocabulary"),
];

const List<ResourceCard> grammarCards = [
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
  // ResourceCard(topic: "self_introductions", resourceType: "conversation"),
  ResourceCard(topic: "self_introductions", resourceType: "conversation"),
  ResourceCard(topic: "using_a_cab", resourceType: "conversation"),
  ResourceCard(topic: "in_the_market", resourceType: "conversation"),
  ResourceCard(topic: "health_and_medicine", resourceType: "conversation"),
  ResourceCard(topic: "in_a_restaurant", resourceType: "conversation"),
  ResourceCard(topic: "speaking_with_traffic_cops", resourceType: "conversation"),
  ResourceCard(topic: "in_government_offices", resourceType: "conversation"),
];
