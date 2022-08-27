# Wasteagram
Final project for CS 492 (Intro to Mobile Development) course at Oregon State University.

## About
Wasteagram is a mobile app used by a hypothetical restaurant employee to track the number of food items wasted on a given day at the restaurant. The user can make "posts" with information on the number of items wasted, photo of the food item, date, and location.

## Video Demo
- https://youtu.be/24BBKnBBxeE
  - Turn on volume to max if you want voiceover, read description of video on Youtube

## Technologies Used
- Written in Dart with Flutter framework.
- Stored data for user posts with Google Firebase (non-relational database)
- Tested app locally in Android Emulator (although this should work for iOS too, as Flutter is cross-platform)
- Error reporting with Sentry (proof of concept, didn't implement on entire app)
- Implemented unit tests on the data model

## Detailed Specifications
- Show loading screen when no posts are present
- Allow user to create posts. User will be asked to enter a photo of the wasted food and number of food items wasted. Date and location of the post will be assigned automatically.
- The user should be able to view all the posts in a list with simplified information (just number of items and food photos)
- When the user selects a specific post, all the post information should be displayed (including location and date as well)
- A running total of the number of wasted items (of all foods) is maintained above the list of posts
- The user can press a button to trigger an intentional "error" that will be caught be Sentry for error tracking
- The app has unit tests that can be run either in the terminal or in Visual Studio Code.
