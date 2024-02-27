---@diagnostic disable: undefined-global
--# selene: allow(undefined_variable, unscoped_variables)

-- local pumlpreview_ok, pumlpreview = pcall(require, 'plantuml-previewer')
-- if not pumlpreview_ok then
--     vim.notify("orgmode plugin not loaded!")
--     return
-- end
local soil_ok, soil = pcall(require, 'soil')
if not soil_ok then
    vim.notify 'soil plugin not loaded!'
    return
end

-- vim.g.plantuml_executable_script = os.getenv 'HOME' .. '/bin/plantUML.sh'
-- vim.g.slumlord_plantuml_jar_path = os.getenv 'HOME' .. '/bin/plantuml.jar'
--
-- pumlpreview.setup {
--     plantuml_jar = os.getenv 'HOME' .. '/bin/plantuml.jar',
--     java_command = '/opt/java/bin/java',
-- }

soil.setup {
    -- If you want to use Plant UML jar version instead of the install version
    puml_jar = os.getenv 'HOME' .. '/bin/plantuml.jar',

    -- If you want to customize the image showed when running this plugin
    image = {
        darkmode = false, -- Enable or disable darkmode
        format = 'png',   -- Choose between png or svg
    },
}
