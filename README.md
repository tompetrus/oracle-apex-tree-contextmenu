# Apex 5 Tree Search and Show

Plugin Details:
- Name: Tree ContextMenu
- Code: TP.DA.TREECONTEXTMENU
- Version: v1.0.0
- Apex compatibility: 5

In Apex 5 a new tree widget has been introduced which replaces the previous implementation of jstree. This tree is also used in the builder, and shows off a nice contextual menu (ie. when right-clicking a node). In the tree region however you cannot change settings to include a contextmenu somehow. It is however rather easy to hook into the contextMenu event. On the other hand, for some reason it has not been made possible to add a contextmenu in the same easy way as it is during initialization of the tree widget: there is an option to provide an apex menu options object, and the widget will hook everything up - but only during creation of the tree instance, not afterwards during an option.  
This plugin contains a javascript file which will extend the treeView widget with a new function, "setContextMenu", which enables to add a contextmenu with an apex menu options object to the tree after it has already been initialized. The code has been taken from the source code of the tree widget, the very same code which would hook everything up during initialization. The apex plugin then facilitates the use of this by exposing it to the dynamic action framework and removing the need to configure things through javascript.  Note that the node which has been right-clicked will be selected aswell!  
The apex menu object isn't very hard to understand. But yet again, there is no "real" documentation on hands other than the commentary in the source file. It's very good and descriptive though!

OTN: https://community.oracle.com/thread/3993738

Demo: https://apex.oracle.com/pls/apex/f?p=90922:20

## Features:

- Allows you to add a contextmenu to the tree component
- Provide the menu items and actions in JSON notation, conforming to the requirements of apex.widget.menu
- Provide a menu ID

## To use:

1. Install the plugin in the shared components of your application
2. Create a dynamic action on the page which reacts to some event. For example a button.
3. As a true action, select the "Tree ContextMenu" action, found under "Initialize"
4. Adjust the settings
5. Select the affected region (the tree region)

## Example of menu syntax

```
{items:[
  {type:"action", label: "do something 1", action:function(){ 
      var node =  apex.jQuery("#myTree div[role='tree']").treeView("getSelectedNodes")[0];
      console.log("selected do something 1, node selected: ", node);
      alert("You actived 'do something 1' on " + node.label + "(id: "+ node.id +")");
    }
  },
  {type:"separator"},
  {type:"action", label: "do something 2", action:function(){console.log("selected do something 2");}}
]}
```

## apex.menu syntax documentation

Copied text from the APEX.WIDGET.MENU file under images\libraries\apex

Here expected is an options OBJECT for the apex.menu widget. See the file for all info you can ever dream of.

```
 * The options object has these properties:
 *   menubar: <bool> If true the widget is a menu bar otherwise the widget is a single popup menu
 *   menubarShowSubMenuIcon: <bool> Ignored unless this is a menubar. If true menu sub menu items will have a down arrow
 *       icon added. The default is false unless the menubar has a mix of action and sub menu items. This does not
 *       affect split menu items which always show a down arrow with a divider
 *   menubarOverflow: <bool> If true the menubar will respond to window size changes by moving menu bar items that
 *       don't fit on to an overflow menu. This only applies if menubar is true.
 *   iconType: <css-name> default icon type for all items. The default is "a-Icon".
 *   behaveLikeTabs: <bool> If true menu bar items can have a current property to indicate the item is
 *     associated with the current "page".
 *   tabBehavior: <string> One of NONE, NEXT, EXIT (default is EXIT)
 *      EXIT: tab or shift tab exit (and close) the menu and focus moves to the next (previous) tab stop relative to
 *          the item that launched the menu. Not valid for popup menus because they don't have an launch element
 *          This follows the DHTML Style guide recommendation
 *      NEXT: tab and shift tab work like the Down and Up keys
 *      NONE: the tab key does nothing. This is most like normal desktop menus
 *   useLinks: <bool> If true action menu items with href property are rendered with an anchor element.
 *      This allows some non-menu behavior that is expected of links (middle or right mouse click, and shift and ctrl key modifiers on click or Enter)
 *      The default is true. Set to false if menu is mainly for functions and you want a more desktop experience.
 *   items: [<menuItem>...] An array of menuItem objects.
 *      Only action and subMenu item types are allowed at the menu bar level
 *   slide: <bool> If true menus will slide down when opened otherwise they are shown all at once
 *   firstItemIsDefault: For popup/context menus only. If true the first menu item gets an extra class to indicate it is
 *      the default choice. The menu widget is not responsible for implementing any default behavior.
 *   customContent: Only for popup/context menus or sub menus of a menu bar. This is true, false or an element id. See
 *      below for details about custom content.
 *      If false it is a normal menu with items (or menu markup); there is no custom content. The default is false.
 *      If true the content of the menu element is the custom markup.
 *      If the value is a string then it is the id of an element that contains the custom content. The custom content
 *      element is moved to be the only child of the menu (or sub menu) element. This is useful for menu bar sub menus
 *      where true would not work.
 *
 * The menuItem object is one of the following forms (discriminated by the type property):
 *   { type: "separator" }
 *   { type: "subMenu", label: <text>, iconType: <css-name>, icon: <css-name>, menu: <menu>, disabled: <bool-or-fn> }
 *   { type: "toggle", label: <text>, accelerator: <text>, set: <fn>, get: <fn>, onLabel: <text>, offLabel: <text>, disabled: <bool-or-fn> }
 *   { type: "action", label: <text>, accelerator: <text>, href: <url>, action: <fn>, iconType: <css-name>, icon: <name>, disabled: <bool-or-fn> }
 *   { type: "radioGroup", set: <fn>, get: <fn>, choices: [
 *     { label: <text>, value: <string>, disabled: <bool-or-fn> },...
 *   ] }
 *
 * All menu items can have an id property. The id is only used to find the item by id.
 * All menu items can have a hide property. The value is true or false or a function returning true or false. If true the item is ignored.
 * The value for iconType and icon are
 ```