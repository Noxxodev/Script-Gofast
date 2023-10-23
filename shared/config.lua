---------- Prix de vente -----------

Config = {     
    minMoney100 = 1900, -- Prix minimum du véhicule si l'état du véhicule est a 100%
    maxMoney100 = 2000, -- Prix maximum du véhicule si l'état du véhicule est a 100%
    minMoney75 = 1700, -- Prix minimum du véhicule si l'état du véhicule est a 75%
    maxMoney75 = 1800, -- Prix maximum du véhicule si l'état du véhicule est a 75%
    minMoney50 = 1500, -- Prix minimum du véhicule si l'état du véhicule est a 50%
    maxMoney50 = 1600, -- Prix maximum du véhicule si l'état du véhicule est a 50%
    minMoney0 = 1300, -- Prix minimum du véhicule si l'état du véhicule est a 0%
    maxMoney0 = 1400, -- Prix maximum du véhicule si l'état du véhicule est a 0%
}

Config.money = black_money -- black_money = argent sale | money = argent liquide | bank = argent en banques

-------------- Autre ---------------

Config.notif = 1 -- 1 = esx_notify | 2 = s1n_notif

Config.temps = 43200000 -- Temps entre les gofast en seconde

------------------------------------

---------------- Ped ---------------
Config.ped = true -- false si vous voulez desactive les ped
Config.Invincible = true -- false si vous voulez qu'il ne soit pas invincible
Config.Frozen = true -- false si vous voulez qu'il ne soit pas freeze
Config.Stoic = true -- false si vous voulez qu'il ne fasse pas d'émotions
Config.Fade = true -- false si vous voulez qu'il soit invisible
Config.PedsDistance = 20.0 -- la distance a lequel vous souhaitez voir les peds


Config.MinusOne = true -- false si vous voulez pas qu'il soit directement sur le sol

Config.PedList = {
	{
		model = "csb_g", -- model du ped
		coords = vector3(1733.933, -1518.106, 113.9468), -- coordonnées du ped
		heading = 251.0921, -- orientation du ped
		gender = "male", -- le genre du ped
		scenario = "WORLD_HUMAN_CLIPBOARD" -- animation du ed
	},
	{
		model = "csb_g",
		coords = vector3(1741.969, -1525.011, 112.6149),
		heading = 347.0847,
		gender = "male", 
		scenario = "WORLD_HUMAN_CLIPBOARD" 
	},
}

------------------------------------

--------------- Blips --------------

Config.position = true  --true si vous voulez le blips false si vous souhaitez le retirer

--Configuration du blips
Config.gofast = { 
	Pos     = { x = 1734.426, y = -1518.118, z = 113.9467 }, --coordonnées du blips
	Sprite  = 227, -- l'icon du blips
	Display = 4, 
	Scale   = 0.65, -- taille du blips
	Colour  = 1, -- la couleur du blips
    name = 'Gofast', -- le nom du blips
}

------------------------------------

------------- Véhicule -------------

Config.vehicles = { -- la liste des véhicule qu'il vous donnerons pour le gofast
    {model = "jester4"},
    {model = "burrito3"},
    --{model = "speedo4"},
    --{model = "youga2"},
    --{model = "x"},
}

------------------------------------

---------- Point de vente ----------

Config.deliveryPoints = { -- la liste des coordonnées des points de vente
    vector3(-72.85714721679688,6495.86376953125,31.4871826171875), 
    vector3(1839.5999755859375,3897.666015625,33.4080810546875),
    vector3(1901.69, 4917.76, 48.73),
    vector3(1453.23, 6350.46, 23.74),
    vector3(64.21, 3664.85, 39.72),
    vector3(-672.03955078125,5790.10546875,17.3165283203125),
}

Config.message = 'Appuye sur [~r~ E ~s~] pour vendre le véhicule'

------------------------------------

--------- Point de d'épart ---------

Config.posdebut = vector3(1733.933, -1518.106, 113.9468) -- coordonnées du point de départ

Config.spawnveh = vector4(1744.9, -1521.83, 112.63, 248.62) -- coordonnées du point de spawn des véhicule

------------------------------------

----- Point pour rendre le véh -----

Config.posfin = vector3(1741.912109375,-1524.975830078125,112.6021728515625) -- coordonnées du point pour rendre la sanchez