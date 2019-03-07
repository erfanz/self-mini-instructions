# Creating Custom Persian Keyboard Layout in Mac

## Issue
When in Chrome, if the keyboard is in Persian mode, ⌘ + ⇧ + <kbd>{</kbd> (resp. <kbd>}</kbd>) does not go to previous (resp. next) tab.
This is because in the Persian keyboard layout, <kbd>{</kbd> and <kbd>}</kbd> are switched.
So when wanting to go to the previous tab, it goes to the next one, and vice versa.
This is really annoying, 

## Solution
Create a new keyboard layout for yourself.
It can be done with a tool called *Ukelele*.
The whole process is fully explained in this [YouTube link](https://www.youtube.com/watch?v=K_DFP4PecRw).
This [SO post](https://apple.stackexchange.com/questions/344217/custom-ukelele-layout-cmd-w-and-similar-shortcuts-not-working/344222) is also needed to make the shortcuts work.

I already created the layout ([here](./fff)). 
Download it and copy it to `/Library/Keyboard Layouts` folder.
Then, to install the layout, go to `System Preferences -> Keyboard -> Input Sources`, and search for the layout's name, which is `Erfan-KB-Layout`.

Done!
