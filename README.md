# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **6** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [x] Add a search bar.
- [x] All images fade in.
- [x] For the large poster, load the low-res image first, switch to high-res when complete.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Use official Movie DB theme colors
- [x] Display movie release date in a human readable format
- [x] Display movie voting average

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/zihanzzz/Flicks/blob/master/Flicks.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

1. I didn't have much experience working with Storyboard directly. I found manually dragging and moving UI components a little bit inconvenient. But I got used to it very quickly. There is some limitations to Storyboard such as you cannot put a UISearchBar on the NavigationItem. I had to do this programmatically. Another thing I found more easier doing things programmatically is subviews. With code, it is very easy to see when and where a specific view is being added to a subview. However in Storyboard it just kind of works magically. Even though Storyboard does work for almost everything else, I still believe in doing everything programtically is much more easier to deal with : )

2. This is my first time implementing a UITabBarController. The structure has now been very clear to me: UITabBarController -> UINavigationController -> UIViewController.

3. I didn't solve the issue where TableView will load "wrong" images first and then suddenly change to the correct ones. It is because TableViewCells are being reused. I tried setting image of the cell to nil in cellForRow but it didn't work.

4. No auto-layout is implemented.

5. I didn't have much time to work on the CollectionView. I will update it once I have time.

6. I spent a lot of time learning ScrollView. The contentSize property of the ScrollView is a little hard to understand.


## License

    Copyright [2016] [James Zhou]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.