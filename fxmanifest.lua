fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Sharky - Csongor | With Kek_Orbit'

shared_scripts {
    'config.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    '@ox_lib/init.lua',
}

client_script 'client/main.lua'

server_scripts {
    'server/main.lua',
    'server/log.lua'
}

escrow_ignore 'config.lua'
escrow_ignore 'locales/*.lua'
escrow_ignore 'server/log.lua'
