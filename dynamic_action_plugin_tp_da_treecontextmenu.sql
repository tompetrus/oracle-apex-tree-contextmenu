set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050000 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2013.01.01'
,p_release=>'5.0.4.00.12'
,p_default_workspace_id=>27000294100083787867
,p_default_application_id=>90922
,p_default_owner=>'TPE'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/tp_da_treecontextmenu
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(46436166007718297478)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'TP.DA.TREECONTEXTMENU'
,p_display_name=>'Tree ContextMenu'
,p_category=>'INIT'
,p_supported_ui_types=>'DESKTOP'
,p_javascript_file_urls=>'#PLUGIN_FILES#apex.widget.treeView.contextMenu.js'
,p_plsql_code=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'FUNCTION tmenu_render',
'( p_dynamic_action in apex_plugin.t_dynamic_action',
', p_plugin         in apex_plugin.t_plugin ',
')',
'RETURN apex_plugin.t_dynamic_action_render_result',
'IS',
'  l_result apex_plugin.t_dynamic_action_render_result;',
'  l_menu_items      VARCHAR2(32000)  := p_dynamic_action.attribute_01;',
'  l_menu_id         VARCHAR2(100  )  := p_dynamic_action.attribute_02;',
'  ',
'  l_region_id       NUMBER;',
'  l_static_id       VARCHAR2(400);',
'  l_onload_code     VARCHAR2(4000);  ',
'  l_code            VARCHAR2(4000);',
'  l_crlf            CHAR(2) := CHR(13)||CHR(10);',
'BEGIN',
'  IF apex_application.g_debug',
'  THEN',
'    apex_plugin_util.debug_dynamic_action(',
'       p_plugin         => p_plugin,',
'       p_dynamic_action => p_dynamic_action ',
'    );',
'  END IF;',
'  ',
'  l_code := ',
'    ''function(){ apex.jQuery("div[role=tree]", this.affectedElements).treeView("setContextMenu", {contextMenu:''||NVL(l_menu_items,''{items:[]}'')||'',contextMenuId:"''||l_menu_id||''"}); }'';',
'   ',
'  l_result.javascript_function := l_code;',
'  ',
'  RETURN l_result;',
'END;'))
,p_render_function=>'tmenu_render'
,p_standard_attributes=>'REGION'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'In Apex 5 a new tree widget has been introduced which replaces the previous implementation of jstree. This tree is also used in the builder, and shows off a nice contextual menu (ie. when right-clicking a node). In the tree region however you cannot '
||'change settings to include a contextmenu somehow. It is however rather easy to hook into the contextMenu event. On the other hand, for some reason it has not been made possible to add a contextmenu in the same easy way as it is during initialization '
||'of the tree widget: there is an option to provide an apex menu options object, and the widget will hook everything up - but only during creation of the tree instance, not afterwards during an option.  ',
'This plugin contains a javascript file which will extend the treeView widget with a new function, "setContextMenu", which enables to add a contextmenu with an apex menu options object to the tree after it has already been initialized. The code has be'
||'en taken from the source code of the tree widget, the very same code which would hook everything up during initialization. The apex plugin then facilitates the use of this by exposing it to the dynamic action framework and removing the need to config'
||'ure things through javascript.  Note that the node which has been right-clicked will be selected aswell!  ',
'The apex menu object isn''t very hard to understand. But yet again, there is no "real" documentation on hands other than the commentary in the source file. It''s very good and descriptive though!'))
,p_version_identifier=>'1.0.0'
,p_about_url=>'https://github.com/tompetrus/oracle-apex-tree-contextmenu'
,p_files_version=>6
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(46437253321743080131)
,p_plugin_id=>wwv_flow_api.id(46436166007718297478)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Menu Items (JSON)'
,p_attribute_type=>'JAVASCRIPT'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_examples=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'{items:[',
'  {type:"action", label: "do something 1", action:function(){ console.log("selected do something 1, nodes selected: ", apex.jQuery("#myTree div[role=''tree'']").treeView("getSelectedNodes"));}},',
'  {type:"separator"},',
'  {type:"action", label: "do something 2", action:function(){console.log("selected do something 2");}}',
']}'))
,p_help_text=>wwv_flow_utilities.join(wwv_flow_t_varchar2(
'Copied text from the APEX.WIDGET.MENU file under images\libraries\apex',
'',
'Here expected is an options OBJECT for the apex.menu widget. See the file for all info you can ever dream of.',
'',
' * The options object has these properties:',
' *   menubar: <bool> If true the widget is a menu bar otherwise the widget is a single popup menu',
' *   menubarShowSubMenuIcon: <bool> Ignored unless this is a menubar. If true menu sub menu items will have a down arrow',
' *       icon added. The default is false unless the menubar has a mix of action and sub menu items. This does not',
' *       affect split menu items which always show a down arrow with a divider',
' *   menubarOverflow: <bool> If true the menubar will respond to window size changes by moving menu bar items that',
' *       don''t fit on to an overflow menu. This only applies if menubar is true.',
' *   iconType: <css-name> default icon type for all items. The default is "a-Icon".',
' *   behaveLikeTabs: <bool> If true menu bar items can have a current property to indicate the item is',
' *     associated with the current "page".',
' *   tabBehavior: <string> One of NONE, NEXT, EXIT (default is EXIT)',
' *      EXIT: tab or shift tab exit (and close) the menu and focus moves to the next (previous) tab stop relative to',
' *          the item that launched the menu. Not valid for popup menus because they don''t have an launch element',
' *          This follows the DHTML Style guide recommendation',
' *      NEXT: tab and shift tab work like the Down and Up keys',
' *      NONE: the tab key does nothing. This is most like normal desktop menus',
' *   useLinks: <bool> If true action menu items with href property are rendered with an anchor element.',
' *      This allows some non-menu behavior that is expected of links (middle or right mouse click, and shift and ctrl key modifiers on click or Enter)',
' *      The default is true. Set to false if menu is mainly for functions and you want a more desktop experience.',
' *   items: [<menuItem>...] An array of menuItem objects.',
' *      Only action and subMenu item types are allowed at the menu bar level',
' *   slide: <bool> If true menus will slide down when opened otherwise they are shown all at once',
' *   firstItemIsDefault: For popup/context menus only. If true the first menu item gets an extra class to indicate it is',
' *      the default choice. The menu widget is not responsible for implementing any default behavior.',
' *   customContent: Only for popup/context menus or sub menus of a menu bar. This is true, false or an element id. See',
' *      below for details about custom content.',
' *      If false it is a normal menu with items (or menu markup); there is no custom content. The default is false.',
' *      If true the content of the menu element is the custom markup.',
' *      If the value is a string then it is the id of an element that contains the custom content. The custom content',
' *      element is moved to be the only child of the menu (or sub menu) element. This is useful for menu bar sub menus',
' *      where true would not work.',
' *',
' * The menuItem object is one of the following forms (discriminated by the type property):',
' *   { type: "separator" }',
' *   { type: "subMenu", label: <text>, iconType: <css-name>, icon: <css-name>, menu: <menu>, disabled: <bool-or-fn> }',
' *   { type: "toggle", label: <text>, accelerator: <text>, set: <fn>, get: <fn>, onLabel: <text>, offLabel: <text>, disabled: <bool-or-fn> }',
' *   { type: "action", label: <text>, accelerator: <text>, href: <url>, action: <fn>, iconType: <css-name>, icon: <name>, disabled: <bool-or-fn> }',
' *   { type: "radioGroup", set: <fn>, get: <fn>, choices: [',
' *     { label: <text>, value: <string>, disabled: <bool-or-fn> },...',
' *   ] }',
' *',
' * All menu items can have an id property. The id is only used to find the item by id.',
' * All menu items can have a hide property. The value is true or false or a function returning true or false. If true the item is ignored.',
' * The value for iconType and icon are'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(46437336155463467998)
,p_plugin_id=>wwv_flow_api.id(46436166007718297478)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Menu ID'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'An optional ID for the menu'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2F617065782E6A51756572792822236D7954726565206469765B726F6C653D2774726565275D22292E74726565566965772822636F6E746578744D656E75416374696F6E222C2066756E6374696F6E2865297B636F6E736F6C652E6C6F672822636F6E';
wwv_flow_api.g_varchar2_table(2) := '746578746D656E7520616374696F6E207472696767657265642077697468206576656E74203D20222C2065293B7D290D0A282066756E6374696F6E202820242C20756E646566696E65642029207B0D0A2020242E7769646765742822617065782E747265';
wwv_flow_api.g_varchar2_table(3) := '6556696577222C20242E617065782E74726565566965772C207B0D0A20202020736574436F6E746578744D656E753A2066756E6374696F6E20202820704F7074696F6E732029207B0D0A2020202020202F2F76617220696E7374203D20617065782E6A51';
wwv_flow_api.g_varchar2_table(4) := '7565727928705472656553656C6563746F72202B2022206469765B726F6C653D2774726565275D22292E646174612822617065782D747265655669657722293B0D0A2020202020207661722073656C66203D20746869733B0D0A20202020202076617220';
wwv_flow_api.g_varchar2_table(5) := '6C436F6E746578744D656E75416374696F6E3B0D0A2020202020200D0A202020202020696620282073656C662E636F6E746578744D656E7524202029207B0D0A20202020202020207468726F7720226120636F6E746578744D656E752068617320616C72';
wwv_flow_api.g_varchar2_table(6) := '65616479206265656E20646566696E6564206F6E20746869732074726565223B0D0A2020202020207D3B0D0A2020202020200D0A2020202020206966202820704F7074696F6E732E636F6E746578744D656E752029207B0D0A2020202020202020696620';
wwv_flow_api.g_varchar2_table(7) := '2820242E617065782E6D656E752029207B0D0A202020202020202020206966202820704F7074696F6E732E636F6E746578744D656E752E6D656E756261722029207B0D0A2020202020202020202020207468726F772022547265655669657720636F6E74';
wwv_flow_api.g_varchar2_table(8) := '6578744D656E75206D757374206E6F742062652061206D656E75626172223B0D0A202020202020202020207D0D0A202020202020202020202F2F206175676D656E7420746865206D656E750D0A20202020202020202020704F7074696F6E732E636F6E74';
wwv_flow_api.g_varchar2_table(9) := '6578744D656E752E5F6F726967696E616C4265666F72654F70656E203D20704F7074696F6E732E636F6E746578744D656E752E6265666F72654F70656E3B0D0A20202020202020202020704F7074696F6E732E636F6E746578744D656E752E6265666F72';
wwv_flow_api.g_varchar2_table(10) := '654F70656E203D2066756E6374696F6E28206576656E742C2075692029207B0D0A2020202020202020202020206966202820704F7074696F6E732E636F6E746578744D656E752E5F6F726967696E616C4265666F72654F70656E2029207B0D0A20202020';
wwv_flow_api.g_varchar2_table(11) := '2020202020202020202075692E6D656E75456C656D656E74203D2073656C662E636F6E746578744D656E75243B0D0A202020202020202020202020202075692E74726565203D206374726C243B0D0A202020202020202020202020202075692E74726565';
wwv_flow_api.g_varchar2_table(12) := '4E6F646541646170746572203D2073656C662E6E6F6465416461707465723B0D0A202020202020202020202020202075692E7472656553656C656374696F6E203D2073656C662E67657453656C656374696F6E28293B0D0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(13) := '202075692E7472656553656C65637465644E6F646573203D2073656C662E6765744E6F646573282075692E7472656553656C656374696F6E20293B0D0A2020202020202020202020202020704F7074696F6E732E636F6E746578744D656E752E5F6F7269';
wwv_flow_api.g_varchar2_table(14) := '67696E616C4265666F72654F70656E28206576656E742C20756920293B0D0A2020202020202020202020207D0D0A202020202020202020207D3B0D0A20202020202020202020704F7074696F6E732E636F6E746578744D656E752E6F6C64416674657243';
wwv_flow_api.g_varchar2_table(15) := '6C6F7365203D20704F7074696F6E732E636F6E746578744D656E752E6166746572436C6F73653B0D0A20202020202020202020704F7074696F6E732E636F6E746578744D656E752E6166746572436C6F7365203D2066756E6374696F6E28206576656E74';
wwv_flow_api.g_varchar2_table(16) := '2C2075692029207B0D0A2020202020202020202020206966202820704F7074696F6E732E636F6E746578744D656E752E6F6C644166746572436C6F73652029207B0D0A202020202020202020202020202075692E6D656E75456C656D656E74203D207365';
wwv_flow_api.g_varchar2_table(17) := '6C662E636F6E746578744D656E75243B0D0A202020202020202020202020202075692E74726565203D206374726C243B0D0A2020202020202020202020202020704F7074696F6E732E636F6E746578744D656E752E6F6C644166746572436C6F73652820';
wwv_flow_api.g_varchar2_table(18) := '6576656E742C20756920293B0D0A2020202020202020202020207D0D0A20202020202020202020202069662028202175692E616374696F6E546F6F6B466F6375732029207B0D0A202020202020202020202020202073656C662E666F63757328293B0D0A';
wwv_flow_api.g_varchar2_table(19) := '2020202020202020202020207D0D0A202020202020202020207D3B0D0A2020202020202020202073656C662E636F6E746578744D656E7524203D20242820223C646976207374796C653D27646973706C61793A6E6F6E65273E3C2F6469763E2220292E61';
wwv_flow_api.g_varchar2_table(20) := '7070656E64546F282022626F64792220293B0D0A202020202020202020206966202820704F7074696F6E732E636F6E746578744D656E7549642029207B0D0A20202020202020202020202073656C662E636F6E746578744D656E75245B305D2E6964203D';
wwv_flow_api.g_varchar2_table(21) := '20704F7074696F6E732E636F6E746578744D656E7549643B0D0A202020202020202020207D0D0A2020202020202020202073656C662E636F6E746578744D656E75242E6D656E752820704F7074696F6E732E636F6E746578744D656E7520293B0D0A2020';
wwv_flow_api.g_varchar2_table(22) := '202020202020202069662028206C436F6E746578744D656E75416374696F6E2029207B0D0A20202020202020202020202064656275672E7761726E2822547265655669657720636F6E746578744D656E75416374696F6E206F7074696F6E2069676E6F72';
wwv_flow_api.g_varchar2_table(23) := '6564207768656E20636F6E746578744D656E75206F7074696F6E2070726573656E7422293B0D0A202020202020202020207D0D0A202020202020202020206C436F6E746578744D656E75416374696F6E203D2066756E6374696F6E28206576656E742029';
wwv_flow_api.g_varchar2_table(24) := '207B0D0A20202020202020202020202076617220746172676574242C20706F733B0D0A0D0A20202020202020202020202069662028206576656E742E74797065203D3D3D2022636F6E746578746D656E75222029207B0D0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(25) := '202073656C662E636F6E746578744D656E75242E6D656E75282022746F67676C65222C206576656E742E70616765582C206576656E742E706167655920293B0D0A2020202020202020202020207D20656C7365207B0D0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(26) := '2074617267657424203D202428206576656E742E74617267657420293B0D0A2020202020202020202020202020706F73203D20746172676574242E6F666673657428293B0D0A202020202020202020202020202073656C662E636F6E746578744D656E75';
wwv_flow_api.g_varchar2_table(27) := '242E6D656E75282022746F67676C65222C20706F732E6C6566742C20706F732E746F70202B20746172676574242E636C6F73657374282053454C5F434F4E54454E5420292E686569676874282920293B0D0A2020202020202020202020207D0D0A202020';
wwv_flow_api.g_varchar2_table(28) := '202020202020207D3B0D0A202020202020202020200D0A202020202020202020202F2F617065782E6A517565727928705472656553656C6563746F72202B2022206469765B726F6C653D2774726565275D22292E747265655669657728226F7074696F6E';
wwv_flow_api.g_varchar2_table(29) := '222C22636F6E746578744D656E75416374696F6E222C206C436F6E746578744D656E75416374696F6E293B0D0A2020202020202020202073656C662E5F7365744F7074696F6E2822636F6E746578744D656E75416374696F6E222C206C436F6E74657874';
wwv_flow_api.g_varchar2_table(30) := '4D656E75416374696F6E293B0D0A20202020202020207D20656C7365207B0D0A2020202020202020202064656275672E7761726E2822547265655669657720636F6E746578744D656E75206F7074696F6E2069676E6F7265642062656361757365206D65';
wwv_flow_api.g_varchar2_table(31) := '6E7520776964676574206E6F742070726573657422293B0D0A20202020202020207D0D0A2020202020207D0D0A202020207D0D0A20207D293B0D0A7D2928617065782E6A517565727929';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(46659763240253527401)
,p_plugin_id=>wwv_flow_api.id(46436166007718297478)
,p_file_name=>'apex.widget.treeView.contextMenu.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
