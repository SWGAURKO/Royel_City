fx_version 'cerulean'
game 'gta5'

author 'fivemstore'
description 'qb-banking'
version '1.0.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config/config.lua'
}


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/wrappers/business.lua',
    'server/wrappers/useraccounts.lua',
    'server/wrappers/gangs.lua',
    'server/main.lua'
}

client_script {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/main.lua'
}

ui_page 'nui/index.html'

files {
    'nui/images/logo.png',
    'nui/scripting/jquery-ui.css',
    'nui/scripting/external/jquery/jquery.js',
    'nui/scripting/jquery-ui.js',
    'nui/style.css',
    'nui/index.html',
    'nui/qb-banking.js',
}

dependencies 'qb-atms'

lua54 'yes'
