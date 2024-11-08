- config

eat_true = false -- hunger mod
theme_color = Color(255,140,0)

-- end config

if CLIENT then
	surface.CreateFont('ping', {
		font = 'Open Sans Bold',
		size = 25,
		weight = 600
		} )

	surface.CreateFont('low', {
		font = 'Roboto',
		size = 22,
		weight = 100
		} )
end

function minhud()
	minclock = 1 --support minclock

	ply = LocalPlayer()


	food = Material("materials/bread.png")
	hpm = Material("materials/hp.png")
	arm = Material("materials/arm.png")
	ammo = Material("materials/ammorp.png")
	job = Material("materials/jobreal.png")
	money = Material("materials/mon.png")

	if ply:Armor() > 0 then

		surface.SetDrawColor(theme_color)
		surface.SetMaterial(arm)
		surface.DrawTexturedRect( 45, 1000, 10, 10 )

		draw.RoundedBox(0,60,1000,150,10, Color(0,0,0,100))
		draw.RoundedBox(0,60,1000,ply:Armor() * 1.5 ,10, theme_color)
	end 

	surface.SetDrawColor(theme_color)
	surface.SetMaterial(hpm)
	surface.DrawTexturedRect( 45, 1020, 10, 10 )

	draw.RoundedBox(0,60,1020,150,10, Color(0,0,0,100))
	draw.RoundedBox(0,60,1020,ply:Health() * 1.5 ,10, theme_color)

	-- eat
	if eat_true == true then
		surface.SetDrawColor(theme_color)
		surface.SetMaterial(food)
		surface.DrawTexturedRect( 45, 1040, 10, 10 )

		draw.RoundedBox(0,60,1040,150,10, Color(0,0,0,100))	
		draw.RoundedBox(0,60,1040,ply:getDarkRPVar('Energy') * 1.5 ,10, theme_color)
	end

	--ping

	draw.SimpleText(ply:Ping(), "ping", 3, 0, Color(255,255,255))
	--clock
	if clock_yes ~= 1 then
		draw.RoundedBox(0,1843,0,90,30, Color(0,0,0,100))
		draw.SimpleText(os.date("%X",os.time()),"ping", 1845, 0, Color(255,255,255))
	end

	-- job
	if engine.ActiveGamemode() == "darkrp" then
		surface.SetDrawColor(theme_color)
		surface.SetMaterial(job)
		surface.DrawTexturedRect( 230, 1005, 17, 17 )

		draw.RoundedBox(0,220,1000, 250,50, Color(0,0,0,100))
		draw.RoundedBox(3,220,1000,3,50,theme_color)
		draw.SimpleText(ply:getDarkRPVar('job'), "low", 255,1002, Color(255,255,255))

		surface.SetDrawColor(theme_color)
		surface.SetMaterial(money)
		surface.DrawTexturedRect( 230, 1025, 17, 17 )

		draw.SimpleText("$" .. ply:getDarkRPVar('money') .. " (+".. ply:getDarkRPVar('salary') .."$)", "low", 255,1024, Color(255,255,255))
	end
end

hook.Add("HUDPaint", "minhud", minhud)

local hideHUDElements = {
	["DarkRP_LocalPlayerHUD"] = true,
	['CHudHealth'] =true,
  ['CHudBattery'] =true,
  ['CHudSuitPower'] =true,
}
hook.Add("HUDShouldDraw", "HideDefaultDarkRP", function(name)
	if hideHUDElements[name] then return false end
end)‰