name "bubba-blackmarket"
author "bigbubbajake"
version "2.0.0"
description "Blackmarket script by bigbubbajake"
fx_version "cerulean"
game "gta5"

dependencies { 'qb-input', 'qb-menu', 'qb-target' }
client_scripts { 'client.lua' }
server_scripts { '@oxmysql/lib/MySQL.lua', 'server.lua', }
shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
}
ui_page 'html/index.html'
files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/img/*.png',
	'html/sound/*.ogg',
}

lua54 'yes'
