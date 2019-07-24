2 options: I can add just the table view to the canvas. Manually add cells. OR add a prebuilt table view controller which will come with a table view. 1 cell comes free.
Table view have cells. These cells have styles. Mostly we use cell style = custom. Then I can drop controls onto my cell
Each row has an object table view cell. If we have 1000 rows, we might actually create just 50 objects. Then get these objects when we scroll and populate them with new data. This is reuse.
For reuse we have an id associated with each type of cell our table has. In storyboard just click on cell and provide an attribute. In code write table.register(Class (this can be custom or just UItableview cell), "id")
A table can have 3 types of custom cells registered. we use this identifier to distinguish which cell want when table view asks for a cell at given index path. we call this on table view. Hey get this type of cell. 
To get a cell with an identifier. we say dequeRCell with id for path. 2 options we either get a brand new cell or a previously used cell.
In cellfor populate the cell with data
IndexPath has row and column
We can give subview in our table view a tag. Use this tag to set value in cellfor. Remember we just get a uiview when getting back using a tag so cast it. And this uiview is optional.
Data source gives data to table. delegate controls behaviour.
Apple has somewhere declared 2 protocols. UI Table View class has two variables dataSource and delegate of these types (Like persist has save()) Now our VC inherits from UITableViewController which implements its 2 protocols. And assigns itself as delegate
and also provides implementation.  A good habit to get into is to use question mark in xcode for documentation
UItableVC provides empty stubs so when i write any methods like didselectrowat they are inherited. So I override. When I use the protools directly I do not need an override, cuz I am just providing an implementation.
cellForRowat path gives us the cell to customize it. it returns an optional because there may not be a cell present at that index path
What reuse look like in practice. Suppose I checkmark first three items. and scroll down checkmark will appear again because tableview is placing exact same cell in the new position. Anything I did to that cell is just there
Model can be a text file or database. It has create, delete, update methods. If model changes it updates controller updates the view on main thread. Now if user creates the delete button controller will delete item from model and update UI
When a view controller is initialized from a storyboard we call init coder
New cells are autochecked bug. Sometimes we get new cells but sometimes we get recycled cells. So thats why when we get cells we need to placecheckmark or not based on the model
Bug The first item needs to be clicked twice for checkmark to start toggling
Why is row cell not getting recycle scroll up checkmark error. because when we get cellforrowat that path we are configuring checkmark everytime and looking at model to decide the state of the cell. This is solved by configuring checkmark when we get one
Add a method to toggle the checkmark because the controller should not try to manage state for model
Navigation C has a back button and title in the middle. We can put a button on the right side as well. Every nav controller has a root vc. Our table vc will be set to that. there is also a property on navi controller that will point to my table vc
Every ui vc has a optional navigation controller property
We embed the table vc to basically give it a navigation bar on top and then give edit controls as bar buttons on top
Enabling swiping to delete is extremely easy 2 step process. Enable this behavior and implement it
There are two editing styles. I can also implement a plus at left of table view items
Navigation has a show segue which has a back button
Table view has content which can be dynamic cells i.e. prototype cells/get them by reuse id at run time or static cells build time add outlets directly build in interface builder stuff
Table view has style which can be plain or grouped
The text field will tell me when the return key is pressed and I have to resign its first responder status
A screen with just a textfield should just display a keyboard so make the textfield the first responder when a view first appears
Control events are second way to resign the first responder status, textfield has an didEndEditing control event and I can hook up an action with this event
Protocols are declared when a VC wants to send data to other VC. It will declare a protocol, have a delegate property of type protocol, calling VC will declare itself a delegate in segue destinationVC.delegate = self, implement methods in extension, destination vc will call any of these protocol methods at specific times on its delegate var
Here any VC can become a delegate of add item vc and start getting the checklist items
For each segue give it an identifier, the prepare for method will be called for each segue. we use id for segue to get the destination vc and pass data
present vc will present modally and we can write dismiss. but for vc's in a navigation controller we instead use pop
I can reuse the add item vc to serve as edit view controller
Detail disclosure accessory can indicate that tapping it will allow user to edit an item
I will have two segues from list vc to add item vc
Passing data to next vc in navigation controller or while segueing. Create properties on receiving vc to store data. Initiate a segue. Check the identifier. get an instance of destination vc and just set the properties
In view did load the receiving vc can update its UI that is being sent by some other vc
NSOject lets me compare my edited checklist item with other checklist item in the array without writing the logic! just by inheritance
The accessory in a table view can have a seperate segue but the sender passed in prepare for segue will be the cell
If we create cells with custom style we need tags to refer to the views we put inside, we cannot create outlets because cells are being reused so our random cells will be affected
To get the benefits of outlets we can subclass the table view cell. We cant make outlets in View controller cuz at runtime a given cell may appear at 10 places due to reuse. That label will corrupt state
We get 1 instance of uitableview cell class per cell. Every cell has a backing class
Edit mode - lets users select, deselect rows, and move rows. I have editbarbutton item that lets me enter edit mode. first Just add this lil button then implement move in model
For moving implement move rowAt
Multi-delete - first I enable user to select multiple rows. It has further an option for only allow in edit mode. I find out indexPaths of selected rows. delete from model and update ui which can be reload data
There is a concept of batch updates. for example when I want to delete 50 rows.
We can index the table items by first letter. It will be useful in say the contacts app. To model this we create array of array of checklist items
Create 26 sections
data source gives out the number of sections, each section has a title so we return an array of strings, also we give sectionIndexTitle 0-25 fancy words by apple




1. Create a single view app.
2. Set device orientation to just Portrait from targets
3. Convert the default VC to subclass from a table view controller and call it checklist VC
4. Delete the default generic VC populated in storyboard file and drag a tableVC instead
5. Make my VC entry point in attributes inspector
6. Connect the table VC in storyboard to the class I created
7. Delete the default cell and add my own cell. id is ChecklistItem. add checkmark with tag
8. Make rows to 1k. Give my label a tag a-e if it its row is %5 value is 0-4
9. Confirm the table view delegate and data souce by control clicking it
10. Make taps toggle the checkmark and stop it from being selected foreever
11.  Create a model class for storing item with the name of item and whether it is checked (means checkmark displayed) or not. 
12. declare and initialize one item from this model and update delegate methods to read from it to third row
13. Make a method that will configure checkmark for a cell.
14. Add itemStore to VC which has 5 todos and update C to use the model
15. Write a method to configure text for a cell. pass it the table view cell and the checklist item so the corresponding data
16. Add a method to toggle the checkmark
17. Embed table vc in a navigation controller
18. Set my navigation controllers prefer large titles 
19. Set the title of my table vc nav item title
20. Add a plus bar button item. Connect it to action add item. just print to console
21. Implement this method in the itemstore 
22. Make new items checked by default. Give random titles to todo's
23. Add swipe to delete
24. Edit checklist item. Clicking on + button. Add a tableview controller and present it via show segue
25. Add Cancel L, Add R bar button items both dismiss current vc
26. Make these buttons pop this vc
27. Add a group style static content 1 section 1 cell with a textfield inside
28. Make the keyboard go away when the user presses enter
29. Add a textfield to the cell, create outlet
30. Prevent the row being grayed when the user taps to enter something in text field 
31. Pressing done should print text. Make the textfield select when user gets to this screen
32. Remove the border style of textfield, capitalize the input of words typed in
33. Listen to textfield and dismiss the keyboard when user presses return key
34. Use control event action pair to add new item when the user ends editing
35. Prevent empty item from being created. Disable and enable done button based on if we have empty text in the textfield. Create outlets to the done and cancel bar buttons
36. Implement shouldChangeCharacterIn to check if current text in textfield will be empty and then disable done button
37. Define a protocol. that returns that notifies when user finishes adding item and when user cancelled
38. Declare a delegate var
39. call methods on delegates
40. Declare the implementation, implement the methods
41. And assign itself as the delegate in segue
42. Get the updated model item from the calling vc and append to model and update the ui
43. What things can I do to make our add item vc an edit item vc
44. Add detail disclosure indicator and place checkmark at extreme left
45. Update the vc to use this text label with checkmark (alt v) and set its text
46. Do EditItem segue to addItem vc
47. Add two properites in the receiving vc itemToEdit and the checklist itself
48. Check if we are editing in the view did load method, if so then populate the textfield, also the title should be edit item, enable add button
49.  Find out what done is doing and why we do not see an edited item if we just let done do its current implementation
50. Add a new method for edit in the protocol
51. Make the done button look at the mode and calling appropriate method
52. Make checklist item inherit from NSObject so that I can use indexOf on its array and let inheritance do the heavy listing
53. There can be a double add bug so watch out
54. Rename the protocol to ItemDetailViewController delegate and the vc to item detail vc
55. Create a table view cell subclass, it will be a cocoa touch class named checklistTVcell
56. Just go to cell's identity inspector and point it to my subclass
57. Create outlets, update list vc to use this cell instead. cast cell as mycell and then access its properties
58. Write move(item to) in the model
59. Set initial vc in navigation controllers title to be large others to prefer smaller
60. Implement setEditing and pass in table view's isEditing property
61. For moving, implement moveRowAt
62. Remove toggle checkmark bug
63. Add a bar button for multi-delete with target as the vc class
64. Implement delete in model side
65. Add property for allowing user to multi-delete and batch the deletes
66. Ignore toggling checkmarks when multi-deleting
67. Create 26 sections using UIlocalizedIndexedCollation.current().sectionTitles.count
68. Use this cool initializer repeating: , count:
69. Populate the indexedData array using the todo list items
70. Update the method where table view asks for rows in some index
71. Update the method where we populate the cell at a given index Path
72. Implement the side jump bar by returning details sectionIndexTitle, sectionNumber
73. 


