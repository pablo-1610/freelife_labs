fx_version 'bodacious'
game 'gta5'

client_scripts {
    "modules/**/client/*.lua",
    "modules/**/client/objects/*.lua",

    "client/*.lua",
    "client/objects/*.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "modules/**/server/*.lua",
    "modules/**/server/objects/*.lua",

    "server/enums/*.lua",
    "server/config/*.lua",
    "server/*.lua",
    "server/objects/*.lua",
}