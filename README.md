# ![](https://forum.choiceofgames.com/uploads/choiceofgames/270/107efc2878dfc5fc.png) Chronicler  
**Description:**  
Chronicler is a cross-platform visual code editor for [ChoiceScript](https://www.choiceofgames.com/make-your-own-games/choicescript-intro/). It allows both beginners and veteran novelists alike to design interactive fiction with a flowchart-like layout rather than typing code in a text editor.

If you wan't to change how ChoiceScript is produced look at "data_to_choicescript" in the scripts folder.

- The launcher downloads the latest version of Chronicler.exe, this is located in "%LOCALAPPDATA%\Chronicler_Launcher\downloads"

- in version 1.5 and later you can force update by holding ctrl and clicking on the update button

Credit where credit is due:
- Thanks to David Norgren for the new Textbox scripts. They have proven invaluable.
- And a special thanks to @CJW for all the advice and testing, especially since I didn't specifically request it.
- Also I would like to thank @Flurrywinde11 for advice and testing on the Linux side.

Images:
![](https://www.dropbox.com/s/y6ygh2ma8bkyjwq/Chronicler1.png?dl=1)
![](https://www.dropbox.com/s/12unpg8wvym6bix/Chronicler7.png?dl=1)
![](https://www.dropbox.com/s/s4qjfcttlua7tu1/Chronicler5.png?dl=1)

I've tried to make Chronicler as easy as possible to use.

***

**Controls:**  

***Camera movement:***  

* Middle Mouse and drag  
- Spacebar and drag  
- Arrow keys  
- Scroll or press Q & E to zoom in and out  
- CTRL+R to reset the view  

***
***

***File Menu***  

* **Show ChoiceScript:** displays a textbox containing the generated CS for the active scene.  
* **Stats Screen:** currently displays a textbox to modify the "choicescript_stats.txt" file.  

***Bubble Menu:***  

* Click and drag on the needed bubble to add it to the scene  
* The center circle displays variables when clicked on.  


***Scene Menu:***  

* Click on a scene to switch to it  
* Hover the mouse above or below the current scene -> when the cursor changes, click and hold to cycle quickly  
* The center circle adds a new scene  
* To change the order of a scene: Select it -> click and hold until the menu changes -> drag up and down to adjust its position  
* To rename a scene: Select it -> double click to edit textbox  

***
***

 **Bubbles:**  

* Bubbles can be moved around by clicking and dragging.  
* You can highlight and move multiple bubbles at once by clicking and dragging in a blank area. Every bubble in the box will be selected. When satisfied with your selection, release the mouse button.  
To place the bubbles down again, simply left click.  
* Delete a bubble by Right Clicking and confirming.  
* Resize bubbles by clicking and dragging in their bottom right corner  

***Action:***  

* Actions simply perform whatever you type in them (e.g. **set disdain %+10*)  
* Actions only have one **output**  

***Bubble:***  

* Bubbles make up the bulk of your story. They also contain **Choices**  
* To edit bubble text: double click  
* The smaller title bar is used to **label** the bubble in CS and serves as a useful reminder to yourself in the editor  
* By default, Bubbles have one output. Use this if you don't wish to present the player with a choice. (connected to a "*page_break" **Action** for instance)  
* Click the "+" button to add a choice. Right Click a choice to delete it  
* **Choices** have two sections: a *conditional* section and a *text* section  
the conditional section is available for "*if()" and "*selectable_if()" statements  
the text section is what the player sees for that choice.  

***Choice Bubble:***  

* Choice bubbles act similar to the way choices originally were.  
* The changes being:   
 * Links are now on the side  
 * Choices can be reordered by hovering over the choice and clicking the "up" and "down" arrows that appear on the left side.  
 * Delete a choice by hovering and clicking the red "X" in the upper right hand corner.  

***Condition:***  

* Conditions are for testing the values of a variable (e.g. disdain > 20)  
* You do not have to type the "*if ( )" part. Merely the condition you wish to check  
* Conditions have two outputs: **True** and **False**  

***  
***Output:***  

* Outputs, including Choices, are what connect your story together.  
* To attach them to another bubble: click and drag to the desired destination.  
A path will be drawn between them.  


***
***

**Shortcuts:**  

 * 1 = create text bubble  
 * 2 = create condition  
 * 3 = create action  
 * It may be noted that pressing these three keys while a bubble or choice is selected will automatically connect the selected output to the new bubble.  
 * Text can be copied and pasted into text boxes using the keyboard shortcuts: ctrl+c and ctrl+v respectively.
 * Tab to switch between the Title and Text of a text bubble  
 * ctrl+z to undo  
 * ctrl+shift+z or ctrl+y to redo  
 * ctrl+A to select all bubbles  
***
***

**New Features:**  

 * There is now a small button in the upper right corner of text bubbles.  
Pressing it will display a color picker.  
While the color picker is open, you may click on another bubble to retrieve its color  
 * If only one bubble is selected, press ctrl+D to duplicate it.  
 * If multiple bubbles are selected, pressing ctrl+c and ctrl+v will copy and paste them.  
Pressing "delete" will remove them.  
 * ctrl+z to undo  
 * ctrl+shift+z or ctrl+y to redo  
 * Window can now be resized  
 * Automatic Autosave every 30 seconds  
(found in "appdata\local\Chronicler")  
Also detects whether Chronicler crashed or not on last run.  

**Version 1.3.3:**  

 * Code completion popup.  
Displays actions and variables.  
Esc to toggle on or off, otherwise it pops up while typing.  
Up & Down Arrow Keys to change selection  
Tab to insert selection into text.  
 * Variable refactoring.  
Changing the name of a variable in the variables screen will intelligently update it in bubbles that it appears in.  

**Version 1.4.1**  

* When importing a project, the first scene must be named "startup.txt" and contain a *SCENE_LIST tag with the names of the other scenes. These will be automatically imported. Any other scenes must be in the same directory!  

**Issues**  

* *IF statements without *ELSE statements might not connect up properly. A similar issue also plagues the use of *FAKE_CHOICE. These must be manually connected up once the import is complete.  


***  
* One more note: *function names must be lowercase for the import to be able to recognize them. I believe CS lets you mix upper and lower case, so I will get around to fixing this.  Just something to be aware of for right now.  

***
* Finally: Really large projects will take time to import / save / load! If you save your imported project, expect Chronicler to take a moment to startup as it auto-loads the data.  



***

[![](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc/4.0/)
Chronicler is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/).