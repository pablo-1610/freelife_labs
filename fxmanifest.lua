fx_version 'bodacious'
game 'gta5'

client_scripts {
    "RageUI_v1/client/RMenu.lua",
    "RageUI_v1/client/menu/RageUI.lua",
    "RageUI_v1/client/menu/Menu.lua",
    "RageUI_v1/client/menu/MenuController.lua",
    "RageUI_v1/client/components/*.lua",
    "RageUI_v1/client/menu/elements/*.lua",
    "RageUI_v1/client/menu/items/*.lua",
    "RageUI_v1/client/menu/panels/*.lua",
    "RageUI_v1/client/menu/windows/*.lua",

    "modules/**/client/*.lua",
    "modules/**/client/objects/*.lua",

    "client/*.lua",
    "client/objects/*.lua",
    "client/menu/*.lua",
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