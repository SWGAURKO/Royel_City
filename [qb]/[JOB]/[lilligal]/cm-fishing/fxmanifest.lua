fx_version 'cerulean'
game 'gta5'
author 'CodeM Team'
description 'Codem-Fishing'
version '1.2.6'

shared_script {
	'config.lua',
	'GetFrameworkObject.lua',
	'server_config.lua',
}

escrow_ignore {
	'config.lua',
	'GetFrameworkObject.lua',
	'server/PlayerLoaded.lua',
	'client/afkmode.lua',
	'client/minigame.lua',
	'server_config.lua',
	'client/interaction.lua'
}

client_scripts {
	'GetFrameworkObject.lua',
	'client/*.lua',
}

server_scripts {
	-- '@mysql-async/lib/MySQL.lua',  -- MYSQL ASYNC
	'@oxmysql/lib/MySQL.lua', -- MYSQL ASYNC
	'server_config.lua',
	'server/main.lua',
	'server/PlayerLoaded.lua',
	'GetFrameworkObject.lua',
}

ui_page {
	'html/index.html',
}

files {
	'html/style.css',
	'html/css/responsive.css',
	'html/*.js',
	'html/lib/*.js',
	'html/*.html',
	'html/images/*.png',
	'html/images/fishimage/common/*.png',
	'html/images/fishimage/uncommon/*.png',
	'html/images/fishimage/legendary/*.png',
	'html/images/fishimage/rare/*.png',
	'html/images/fishimage/epic/*.png',
	'html/images/fishimage/baits/*.png',
	'html/images/fishimage/rods/*.png',
	'html/fonts/*.otf',
	'html/*.ogg',
}



lua54 'yes'

dependency '/assetpacks'