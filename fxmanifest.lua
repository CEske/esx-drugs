fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
    'configs/client.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Unhash this line if you use 'oxmysql'.⚠️
    'configs/server.lua',
    'configs/client.lua',
    'server/*.lua'
}

escrow_ignore {
    'configs/*.lua', 
}

dependency 'eske_logs'