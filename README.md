# iOS Technical Test - TheFork light restaurant page

The main goal of this test is to write an application consisting on a single restaurant page and following this design:

![picture](https://ptitchevreuil.github.io/test.png)

## Instructions

- You should write your application in **Swift**
- Your code should run starting **iOS 11**
- You must use a **UICollectionView**
- Your views must be defined programmatically (no **xib** nor **storyboard** for cells)
- Restaurant data are accessible on this [JSON file](https://ptitchevreuil.github.io/test.json) (mock) 
- Assets can be found in the archive (images)

## Work delivery

You should provide the following elements:
- access to your git repository
- instructions to build your project
- a brief explanation of the technical choices and potential difficulties

## Evaluation criteria

- Your test compiles and run
- Your implementation can easily be understood by the reviewer
- Your code is testable


# DELIVERY
<h1 align="center">TestTheFork</h1>
<p align="center">
  <a href="https://www.logolynx.com/images/logolynx/f9/f98c597f4b18590733032cc76fa88ce8.png"><img alt="ios" src="https://www.logolynx.com/images/logolynx/f9/f98c597f4b18590733032cc76fa88ce8.png"/></a>
</p>

## Implementation

### Contraints
>Création des interfaces avec autolayout directement dans le code (pas de storyboard ni de
xib, ni de SwiftUI)
>
>  Aucune librairie externe n'est autorisée
> 
> Le projet doit être compatible pour iOS 11+
> 

## Architecture 

I used an VIP and Clean Swift architecture for my application. 

![MVVM Architecture](https://miro.medium.com/max/1400/1*dzjlbX9q9gTgyorj0gXnbw.png "")
Each screen has the followings components
- ViewController 
- Presenter
- Interactor
- Router which I defined as Coordinator with factory behavior ( it implements all this objects and inject dependancies)

I found this architecture pretty well because thanks to it. I can easily test the business logic, I just have to test the ViewModel class to do it. 

The whole architecture is designed to make each component as independent as possible.
I use generics and protocols to separate each layer network model and ui.
For testing each component can be tested independently of the others

## What went wrong during the test

- the main constraint was not use storyBoard and respect the mandatory design
- I wrote massive classes in UI layer to match with all the UI elements which are numerous

## Unit tests

I used [XCTest](https://developer.apple.com/documentation/xctest) 

# Results
## Home
![image](https://github.com/clebodam/theFork/raw/master/home.png "")
## Diaporama
![image](https://github.com/clebodam/theFork/raw/master/diaporama1.png "")
![image](https://github.com/clebodam/theFork/raw/master/diaporama2.png "")
## Action
![image](https://github.com/clebodam/theFork/raw/master/loader.png "")
![image](https://github.com/clebodam/theFork/raw/master/alert.png "")

## Map
![image](https://github.com/clebodam/theFork/raw/master/map.png "")


