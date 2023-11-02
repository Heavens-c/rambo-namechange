fx_version 'cerulean'

game 'gta5'

shared_script '@es_extended/imports.lua'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_script '@ox_lib/init.lua'

lua54 'yes'

dependencies {
    'oxmysql',
    'ox_lib'
}
