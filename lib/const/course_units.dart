import 'package:kannada_disco/course/course_unit.dart';

const List<CourseUnit> allCourseCards = [
  CourseUnit(
      number: 1,
      heading: "vowels_and_consonants",
      subheading: "Reading Kannada Part 1"),
  CourseUnit(
      number: 2,
      heading: "diacritics_and_consonant_conjuncts",
      subheading: "Reading Kannada Part 2"),
  CourseUnit(
      number: 3,
      heading: "basic_phrases",
      subheading: "A few words and phrases to start you off"),
  CourseUnit(
      number: 4,
      heading: "pronouns",
      subheading: "Personal pronouns to refer to people"),
  CourseUnit(
      number: 5,
      heading: "question_words",
      subheading: "Asking for and clarifying information"),
  CourseUnit(
      number: 6, heading: "proximity_words", subheading: "A and I prefixes"),
  CourseUnit(
      number: 7,
      heading: "basic_sentence_structures",
      subheading: "Putting words together"),
  CourseUnit(
      number: 8, heading: "genitive_case", subheading: "Indicating possession"),
  CourseUnit(
      number: 9,
      heading: "locative_case",
      subheading: "Indicating the location of something"),
  CourseUnit(
      number: 10,
      heading: "dative_case",
      subheading: "Indicating motion towards something"),
  CourseUnit(
      number: 11,
      heading: "modal_verbs",
      subheading: "Expressing wants and desires"),
  CourseUnit(
      number: 12,
      heading: "verbs_and_the_imperative_mood",
      subheading: "Learning to use verbs"),
  CourseUnit(
      number: 13,
      heading: "present_future_tense",
      subheading: "Learning the present/future tense conjugation"),
  CourseUnit(
      number: 14,
      heading: "present_continuous_tense",
      subheading: "Learning the present continuous tense conjugation"),
  CourseUnit(
      number: 15,
      heading: "present_perfect_tense",
      subheading: "Learning the present perfect tense conjugation"),
  CourseUnit(
      number: 16,
      heading: "past_simple_tense",
      subheading: "Learning the past simple tense conjugation"),
  CourseUnit(
      number: 17,
      heading: "past_continuous_tense",
      subheading: "Learning the past continuous tense conjugation"),
  CourseUnit(
      number: 18,
      heading: "negating_verbs",
      subheading: "Negating verbs across all tenses"),
  CourseUnit(
      number: 19,
      heading: "modality_suffixes",
      subheading: "Expressing possibility and wishes through verbs"),
  CourseUnit(
      number: 20,
      heading: "verb_suffixes",
      subheading: "Further verb suffixes"),
];

const List<KidsUnit> grade1_2cards = [
  KidsUnit(
      heading: "Rhymes",
      kannadaHeading: "ಪದ್ಯಗಳು",
      topic: "rhymes",
      resourceType: "reading"),
  KidsUnit(
      heading: "Conversation",
      kannadaHeading: "ಸಂಭಾಷಣೆ",
      topic: "friendsconv",
      resourceType: "conversation"),
  // KidsUnit(heading: "Vowels", kannadaHeading: "ಸ್ವರಗಳು", topic: "vowels", resourceType: "reading"),
  // KidsUnit(heading: "Consonants", kannadaHeading: "ವ್ಯಂಜನಗಳು", topic: "consonants", resourceType: "reading"),
  // KidsUnit(heading: "Numbers", kannadaHeading: "ಸಂಖ್ಯೆಗಳು", topic: "digits", resourceType: "reading"),
  KidsUnit(
      heading: "Fruits",
      kannadaHeading: "ಹಣ್ಣುಗಳು",
      topic: "fruits",
      resourceType: "vocabulary"),
  KidsUnit(
      heading: "Vegetables",
      kannadaHeading: "ತರಕಾರಿಗಳು",
      topic: "vegetables",
      resourceType: "vocabulary"),
  KidsUnit(
      heading: "Colours",
      kannadaHeading: "ಬಣ್ಣಗಳು",
      topic: "colors",
      resourceType: "vocabulary"),
  KidsUnit(
      heading: "Flowers",
      kannadaHeading: "ಹೂಗಳು",
      topic: "flowers",
      resourceType: "vocabulary"),
  KidsUnit(
      heading: "Animals",
      kannadaHeading: "ಪ್ರಾಣಿಗಳು",
      topic: "animals",
      resourceType: "vocabulary"),
  KidsUnit(
    heading: "Birds",
    kannadaHeading: "ಪಕ್ಷಿಗಳು",
    topic: "birds",
    resourceType: "vocabulary",
  ),
  // KidsUnit(heading: "Verbs", kannadaHeading: "ಕ್ರಿಯಾಪದಗಳು", topic: "more_verbs", resourceType: "vocabulary"),
  KidsUnit(
      heading: "Parts of the body",
      kannadaHeading: "ದೇಹದ ಅಂಗಾಂಗಗಳು",
      topic: "body_parts",
      resourceType: "vocabulary"),
  // KidsUnit(heading: "Members of the family", kannadaHeading: "ಕುಟುಂಬದ ಸದಸ್ಯರು", topic: "family", resourceType: "vocabulary"),
  KidsUnit(
      heading: "Antonyms",
      kannadaHeading: "ವಿರುದ್ಧಾರ್ಥಕ ಪದಗಳು",
      topic: "antonyms",
      resourceType: "reading"),
];

// const List<KidsUnit> grade3_5cards = [

//   // KidsUnit(heading: "Conversation with Teacher", kannadaHeading: "ಶಿಕ್ಷಕರೊಂದಿಗೆ ಸಂಭಾಷಣೆ", topic: "teachersconv", resourceType: "conversation"),
//   // KidsUnit(heading: "Conversation with Family members", kannadaHeading: "ಕುಟುಂಬ ಸದಸ್ಯರೊಂದಿಗೆ ಸಂಭಾಷಣೆ", topic: "familyconv", resourceType: "conversation"),
//   // KidsUnit(heading: "Conversation with Neighbours", kannadaHeading: "ನೆರೆಹೊರೆಯವರೊಂದಿಗೆ ಸಂಭಾಷಣೆ", topic: "neighborscov", resourceType: "conversation"),
//   // KidsUnit(heading: "Conversation with Co-Passenger", kannadaHeading: "ಸಹ-ಪ್ರಯಾಣಿಕರೊಂದಿಗೆ ಸಂಭಾಷಣೆ", topic: "copassconv", resourceType: "conversation"),
//   // KidsUnit(heading: "Measurement", kannadaHeading: "ಅಳತೆ", topic: "measurement", resourceType: "reading"),
//   // KidsUnit(heading: "Time", kannadaHeading: "ಸಮಯ ", topic: "time", resourceType: "reading"),
//   // KidsUnit(heading: "Singular & Plural", kannadaHeading: "ಏಕವಚನ ಬಹುವಚನ", topic: "singularplural", resourceType: "grammar"),
//   // KidsUnit(heading: "Genders", kannadaHeading: "ಲಿಂಗಗಳು", topic: "gender", resourceType: "grammar"),
//   // KidsUnit(heading: "Nouns", kannadaHeading: "ನಾಮಪದಗಳು", topic: "nouns", resourceType: "grammar"),
//   // KidsUnit(heading: "Pronouns", kannadaHeading: "ಸರ್ವನಾಮ", topic: "pronouns", resourceType: "grammar")
// ];

const List<SubCardUnit> conversationSubCards = [
  SubCardUnit(
      heading: "Conversation with Friend",
      kannadaHeading: "ಸ್ನೇಹಿತನೊಂದಿಗೆ ಸಂಭಾಷಣೆ",
      topic: "friendsconv",
      resourceType: "conversation"),
  SubCardUnit(
      heading: "Conversation with Teacher",
      kannadaHeading: "ಶಿಕ್ಷಕರೊಂದಿಗೆ ಸಂಭಾಷಣೆ",
      topic: "teachersconv",
      resourceType: "conversation"),
  SubCardUnit(
      heading: "Conversation with Family members",
      kannadaHeading: "ಕುಟುಂಬ ಸದಸ್ಯರೊಂದಿಗೆ ಸಂಭಾಷಣೆ",
      topic: "familyconv",
      resourceType: "conversation"),
  SubCardUnit(
      heading: "Conversation with Neighbours",
      kannadaHeading: "ನೆರೆಹೊರೆಯವರೊಂದಿಗೆ ಸಂಭಾಷಣೆ",
      topic: "neighborscov",
      resourceType: "conversation"),
  SubCardUnit(
      heading: "Conversation with Co-Passenger",
      kannadaHeading: "ಸಹ-ಪ್ರಯಾಣಿಕರೊಂದಿಗೆ ಸಂಭಾಷಣೆ",
      topic: "copassconv",
      resourceType: "conversation"),
];
