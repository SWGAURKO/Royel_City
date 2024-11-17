fx_version 'cerulean'

author 'yusufkaracolak and ensboi'
version '1.1'
game 'gta5'

client_scripts {
    'client/*.lua',
    'editable/client_editable.lua',

}

shared_scripts {
    'shared/*.lua',

}

server_scripts {
    --'@mysql-async/lib/MySQL.lua',
    '@oxmysql/lib/MySQL.lua',
    'editable/server_editable.lua',
    'server/*.lua',
}

ui_page 'html/index.html'


files {
    "html/**.*",
}

escrow_ignore {
    'shared/*.lua',
    'editable/*.lua',
}

lua54 'yes'

dependency '/assetpacks'