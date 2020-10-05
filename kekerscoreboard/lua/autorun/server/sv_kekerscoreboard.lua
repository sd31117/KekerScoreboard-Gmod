print("loaded server")
include("autorun/sh_kekerscoreboard.lua")
AddCSLuaFile("autorun/sh_kekerscoreboard.lua")

for file, directory in pairs( file.Find("keker/*", "DATA") ) do
    print( "[KEKER] found file(s): " .. file, "Name: " .. directory )
    resource.AddSingleFile("data/keker/"..file)
end
