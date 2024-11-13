fx_version 'cerulean'
game 'gta5'

author '0BugScripts Remastered: <0bugscripts.tebex.io>'
description 'zr-notify'
version '1.0.0'

lua54 'yes'

shared_scripts {
    'zr-config/zr-config.lua',
}

client_scripts {
    'zr-build/zr-build-c.lua',
}

ui_page 'zr-nui/zr-index.html'

files { 
    'zr-nui/*',
    'zr-nui/zr-assets/zr-icons/*', 
    'zr-nui/zr-assets/zr-sounds/*', 
}

escrow_ignore {
    'zr-config/*.lua'
}

export 'zr_notify'
dependency '/assetpacks'