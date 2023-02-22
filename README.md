# GetGoProject

A simple app to show everything about [Rick And Morty](https://rickandmortyapi.com) Series. Below are the previews of the main screens:

Character             |  Location                   |  Episode
:-------------------------:|:-------------------------:|:-------------------------:
<img src="https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_iphone8_character_home.png" width="300" height="auto">  | <img src="https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_iphone8_location_home.png" width="300" height="auto"> | <img src="https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_iphone8_episode_home.png" width="300" height="auto">


## Design Pattern
In this project, I decided to use MVVM+Coordinator pattern. It's an extension of MVVM pattern, where there's a coordinator element to manage all navigations of the controllers. The concept can be seen below.

![alt text](https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_concept.jpg)

I implemented a little modification from the concept above, where the coordinators only have a responsibility to inititate controllers. So in most controllers, coordinator parameters aren't injected inside the view models, but to the controllers. This technique is useful when you need to create a simple controller that doesn't need a view model but still needs to do some navigations, such as Filter Modal in the app.

The coordinator structure I used in here, the view starts with a tab bar as a parent coordinator. The parent coordinator then has child coordinators with their own navigation controllers. Tab bar items are going to be the childs.


## Test Coverage
So far, I've managed to achive 85,7% code test coverage in total.
![](https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_test_result.png)


## Third Parties
[WebImage](https://github.com/SDWebImage/SDWebImage) |  [HalfModal](https://github.com/mercari/BottomHalfModal)             
:-------------------------:|:-------------------------:
<img src="https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_iphone8_character_detail.png" width="300" height="auto"> | <img src="https://github.com/RickyAS/GetGoProject/blob/main/Screenshots/ss_iphone8_character_home_filter.png" width="300" height="auto">


## Final Thoughts
This 7 days test, is more challenging than I thought. When I look at the design first time, it was simple thought I could done it easily. But the more I got into working on it, I realised I took a while, in learning things so I can properly implement mvvm+coordinator, Unit test, UI test, and make good documentations. I hadn't done those properly in my current workplace. Because there're many tight deadlines, revamping current architecture design, and making test cases to old codes take a lot of time and hardworks. But through this project, I can start all over again with a good foundation.

I learned a lot from here, but I can learn better if I get the opportunity to get along with the experienced people from here. I Hope I can make it to the next stage.
All other sreenshots can be found [here](https://github.com/RickyAS/GetGoProject/blob/main/Screenshots).
