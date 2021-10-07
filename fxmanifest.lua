fx_version 'cerulean'
game 'gta5'

author 'Harry The Bastard'
version '1.0.0'

ui_page 'UI/index.html'

files {
    'UI/index.html',
	'UI/css/bootstrap-4.6.css',
	'UI/css/stylesheet.css',
	'UI/js/bootstrap.bundle-4.6.js',
	'UI/js/jquery-3.5.1.js',
	'UI/js/script.js',
	'UI/js/vue.min.js'
}

shared_scripts {
    'config.lua',
    'shared.lua'

}

client_scripts {
    'client/nativeStuff.lua',
    'client/debugging.lua',
    'client/globals.lua',
	'FrameworkSpecific/Client/*.lua',
    'client/roleplay.lua',
    'client/zones.lua',
    'client/main_cl.lua',
    'client/vehicleModifications.lua'
}

server_scripts {
    'server.lua'

}

