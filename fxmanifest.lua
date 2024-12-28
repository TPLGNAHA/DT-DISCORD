fx_version 'cerulean'
game 'gta5'

author 'DOWTERS'
description 'Discord Rich Presence'
version '1.0'

client_scripts {
    'config.lua',
    'client/**.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- mysql-async
    '@oxmysql/lib/MySQL.lua', -- oxmysql
    'config.lua',
    'server/*.lua'
}