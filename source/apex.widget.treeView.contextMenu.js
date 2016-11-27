/**
 * @author Tom Petrus
 * @fileoverview Extends the apex treeView widget. A new function "setContextMenu" will be added for availability on the standard widget. It is used to add a contextmenu to the tree by providing an apex.widget.menu options object to the function and will hook into tree functionality.  
 * Be aware that the extend has to occur before a tree instance is initialized, otherwise that tree instance will not have this extra available.
 */
( function ( $, undefined ) {
  $.widget("apex.treeView", $.apex.treeView, {
    /**
     * hooks an apex.menu into the tree, similar to how the tree widget does it on create. This plugin lifts the restriction of only being able to hook a menu up during creation of an instance. 
     * @param pOptions an object containing the options for the contextmenu
     * @param pOptions.contextMenu the apex.menu options object
     * @param pOptions.contextMenuId an optional id to give to the menu instance
     */
    setContextMenu: function  ( pOptions ) {
      //var inst = apex.jQuery(pTreeSelector + " div[role='tree']").data("apex-treeView");
      var self = this;
      var lContextMenuAction;
      
      if ( self.contextMenu$  ) {
        throw "a contextMenu has already been defined on this tree";
      };
      
      if ( pOptions.contextMenu ) {
        if ( $.apex.menu ) {
          if ( pOptions.contextMenu.menubar ) {
            throw "TreeView contextMenu must not be a menubar";
          }
          // augment the menu
          pOptions.contextMenu._originalBeforeOpen = pOptions.contextMenu.beforeOpen;
          pOptions.contextMenu.beforeOpen = function( event, ui ) {
            if ( pOptions.contextMenu._originalBeforeOpen ) {
              ui.menuElement = self.contextMenu$;
              ui.tree = ctrl$;
              ui.treeNodeAdapter = self.nodeAdapter;
              ui.treeSelection = self.getSelection();
              ui.treeSelectedNodes = self.getNodes( ui.treeSelection );
              pOptions.contextMenu._originalBeforeOpen( event, ui );
            }
          };
          pOptions.contextMenu.oldAfterClose = pOptions.contextMenu.afterClose;
          pOptions.contextMenu.afterClose = function( event, ui ) {
            if ( pOptions.contextMenu.oldAfterClose ) {
              ui.menuElement = self.contextMenu$;
              ui.tree = ctrl$;
              pOptions.contextMenu.oldAfterClose( event, ui );
            }
            if ( !ui.actionTookFocus ) {
              self.focus();
            }
          };
          self.contextMenu$ = $( "<div style='display:none'></div>" ).appendTo( "body" );
          if ( pOptions.contextMenuId ) {
            self.contextMenu$[0].id = pOptions.contextMenuId;
          }
          self.contextMenu$.menu( pOptions.contextMenu );
          if ( lContextMenuAction ) {
            debug.warn("TreeView contextMenuAction option ignored when contextMenu option present");
          }
          lContextMenuAction = function( event ) {
            var target$, pos;

            if ( event.type === "contextmenu" ) {
              self.contextMenu$.menu( "toggle", event.pageX, event.pageY );
            } else {
              target$ = $( event.target );
              pos = target$.offset();
              self.contextMenu$.menu( "toggle", pos.left, pos.top + target$.closest( SEL_CONTENT ).height() );
            }
          };
          
          //apex.jQuery(pTreeSelector + " div[role='tree']").treeView("option","contextMenuAction", lContextMenuAction);
          self._setOption("contextMenuAction", lContextMenuAction);
        } else {
          debug.warn("TreeView contextMenu option ignored because menu widget not preset");
        }
      }
    }
  });
})(apex.jQuery)