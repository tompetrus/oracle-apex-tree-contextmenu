FUNCTION tmenu_render
( p_dynamic_action in apex_plugin.t_dynamic_action
, p_plugin         in apex_plugin.t_plugin 
)
RETURN apex_plugin.t_dynamic_action_render_result
IS
  l_result apex_plugin.t_dynamic_action_render_result;
  l_menu_items      VARCHAR2(32000)  := p_dynamic_action.attribute_01;
  l_menu_id         VARCHAR2(100  )  := p_dynamic_action.attribute_02;
  
  l_region_id       NUMBER;
  l_static_id       VARCHAR2(400);
  l_onload_code     VARCHAR2(4000);  
  l_code            VARCHAR2(4000);
  l_crlf            CHAR(2) := CHR(13)||CHR(10);
BEGIN
  IF apex_application.g_debug
  THEN
    apex_plugin_util.debug_dynamic_action(
       p_plugin         => p_plugin,
       p_dynamic_action => p_dynamic_action 
    );
  END IF;
  
  l_code := 
    'function(){ apex.jQuery("div[role=tree]", this.affectedElements).treeView("setContextMenu", {contextMenu:'||NVL(l_menu_items,'{items:[]}')||',contextMenuId:"'||l_menu_id||'"}); }';
   
  l_result.javascript_function := l_code;
  
  RETURN l_result;
END;