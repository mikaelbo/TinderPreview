# Tinder Preview

A simple iOS tweak that adds some convenience to the matches list in Tinder. Made for research purposes, and for fun, with the help of Cycript. 

Tested and working with Tinder **7.2.2+**. 

*(Group matches are currently not supported)*

## Long press match cell for options
Shows a custom made action sheet with the following options:

* Show profile
* Message
* Report
* Unmatch
 
![action-sheet](https://cloud.githubusercontent.com/assets/5389084/24826933/0127cebc-1c74-11e7-93db-eec7e2a2fe46.gif)

## Show a user's profile from the matches list

Tap a profile picture on a match cell to show the user's profile. 

Only supported under the **Messages** section, for obvious reasons ;)

![profile](https://cloud.githubusercontent.com/assets/5389084/24826934/03ce04d8-1c74-11e7-8ecd-95edc43c4a4b.gif)

## Installation
Make sure you have [Theos](https://github.com/theos/theos) installed (guide found [here](http://iphonedevwiki.net/index.php/Theos/Setup)), with the `$THEOS` and `$THEOS_DEVICE_IP` variables configured. 

After that just run `make package install` in the console from the project directory.