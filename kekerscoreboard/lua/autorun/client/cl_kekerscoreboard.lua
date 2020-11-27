include("autorun/sh_kekerscoreboard.lua")

surface.CreateFont("Keker14", {
    font = "Roboto",
    size = 14,
    weight = 500,
})
 
--[[hook.Add("HUDPaint", "KekerScoreboard", function()
    local w,h = ScrW(), ScrH()
    local ply = LocalPlayer()
    local hp = ply:Health()
    local maxhp = ply:GetMaxHealth()
    local boardW = w * .1
    local boardH = h * .02
    surface.SetDrawColor(0, 0, 0, 190)
    surface.DrawRect(w / 2 - boardW / 2, h - boardH * 1.1, boardW, boardH)
    surface.SetDrawColor(255, 0, 0, 190)
    surface.DrawRect(w / 2 - boardW / 2, h - boardH * 1.1, boardW * (hp / maxhp), boardH)
end)]]

fileWarning = false

local function ToggleSC(toggle)
    if toggle then
        local w,h = ScrW(), ScrH()
        KekerScoreboard = vgui.Create("DFrame")
        KekerScoreboard:SetTitle("")
        KekerScoreboard:SetSize(w * .6, h * .7)
        KekerScoreboard:Center()
        KekerScoreboard:MakePopup()
        KekerScoreboard:ShowCloseButton(false)
        KekerScoreboard:SetDraggable(false)
        KekerScoreboard.Paint = function(self,w,h)
            local logoW = KekerScoreboard:GetWide() * .2
            local logoH = KekerScoreboard:GetTall() * .05
            local logo = vgui.Create("DImage", KekerScoreboard)
            logo:SetSize(logoW, logoH)
            logo:SetPos(KekerScoreboard:GetWide() / 2 - logoW / 2, 5)
            logo:SetImage("download/materials/keker/keker.png")
            surface.SetDrawColor(220, 220, 220, 225)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText("GMod Network | "..engine.ActiveGamemode().." | "..game.GetMap(), "Keker14", w / 2, h * .07, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local scroll = vgui.Create("DScrollPanel", KekerScoreboard)
        scroll:SetPos(0, KekerScoreboard:GetTall() * .09)
        scroll:SetSize(KekerScoreboard:GetWide(), KekerScoreboard:GetTall() * .97)

        local ypos = 0
        for k,v in pairs(player.GetAll()) do
            local playerPanel = vgui.Create("DPanel", scroll)
            playerPanel:SetPos(0, ypos)
            playerPanel:SetSize(KekerScoreboard:GetWide(), KekerScoreboard:GetTall() * .1)
            local name = v:Name()
            local ping = v:Ping()
            local avatarSize = 64
            playerPanel.Paint = function(self, w, h)
                if IsValid(v) then
                    surface.SetDrawColor(0, 0, 0, 190)
                    surface.DrawRect(0, 0, w, h)
                    local Avatar = vgui.Create("AvatarImage", playerPanel)
                    Avatar:SetSize(avatarSize, avatarSize)
                    Avatar:SetPos(playerPanel:GetWide() * .015, playerPanel:GetTall() / 2 - avatarSize / 2)
                    Avatar:SetPlayer(v, avatarSize)

                    draw.SimpleText(name, "Keker14", w * .09 , h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                    draw.SimpleText(ping .. "ms", "Keker14", w * .95 , h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                end
            end
            ypos = ypos + playerPanel:GetTall() * 1.1
        end
    else
        if IsValid(KekerScoreboard) then
            KekerScoreboard:Remove()
        end
    end
end

hook.Add("ScoreboardShow", "KekerScoreboardOpen", function()
    ToggleSC(true)
    return false
end)

hook.Add("ScoreboardHide", "KekerScoreboardHide", function()
    ToggleSC(false)
end)