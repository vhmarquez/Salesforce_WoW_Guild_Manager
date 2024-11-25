# About the Author

Hey there, thanks for your interest! My name is [Victor Marquez, I'm a Senior Salesforce Admin and Developer](https://www.linkedin.com/in/victorhmarquez/).
One of my hobbies is playing a video game called World of Warcraft. I've made many long lasting friendships, and in fact met my wife through WoW.

## Salesforce World of Warcraft Guild Manager

I've managed several "Guild" groups, as well as lead many "Raids" throughout the years and have found that there are many systems in Salesforce that can be used in order to help many facets of Guild leading.

- Marketing Campaigns & Sales Pipelines: In WoW, advertising your Guild whether it be in-game or through social media and websites is an important part of keeping your Guild functioning properly. Marketing Campaigns can help us keep track of where our leads are coming from, and help us understand where to focus our recruitment and sales. Sales Pipelines can be used for managing the life cycle of potential buyers (people sometimes pay in-game gold to purchase certain items, or if they need help defeating certain encounters), as well as vetting potential new members.

- Custom Web Service Integration (Named Credentials & APEX): In order to pull "member" or "client" data, we can connect to [Blizzard's Battle.net API](https://develop.battle.net/documentation). In this case the data will be that of character's in the game that are played by individuals that are either applying to join the guild or are looking to be clients of the guild's services. We'll be accessing the API with the use of Salesforce's Named Credentials feature, and accessing the callout in various APEX classes and methods tied to various endpoints.

- Custom Lightning Web Components: I'll be creating custom LWC's that will utilize the callouts created in APEX, and display rendered images of the characters as well and the items that they are using. Other LWC's will be built as necessary, but this will be the main one.