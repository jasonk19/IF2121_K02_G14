:- dynamic(items/7).

/* items(id,name,qty,sell,buy,lvlfish,lvlfarm) */
/******** FISH ********/
/* Small Fish */
items(1,anchovy,0,20,0,0,0).
items(2,goldfish,0,35,0,0,0).
items(3,guppy,0,50,0,0,0).
/* Medium Fish */
items(4,carp,0,125,0,0,0).
items(5,bass,0,180,0,0,0).
items(6,salmon,0,225,0,0,0).
/* Large Fish */
items(4,tuna,0,500,0,0,0).
items(5,marlin,0,750,0,0,0).
items(6,shark,0,1000,0,0,0).
/* Rare Fish */
items(7,treasure_chest,0,2500,0,0,0).

/******** RANCH ********/
/* Animal */
items(8,cow,0,500,1000,0,0).
items(9,sheep,0,350,700,0,0).
items(10,chicken,0,250,500,0,0).
/* Animal Product */
items(11,milk,0,375,0,0,0).
items(12,golden_milk,0,2750,0,0,0).
items(13,wool,0,250,0,0,0).
items(14,golden_wool,0,2500,0,0,0).
items(15,egg,0,100,0,0,0).
items(16,golden_egg,0,2000,0,0,0).

/******** FARM ********/
/* Seeds */
items(17,carrot_seed,0,15,30,0,0).
items(18,corn_seed,0,25,50,0,0).
items(19,potato_seed,0,30,60,0,0).
items(20,tomato_seed,0,50,100,0,0).
/* Harvest */
items(21,carrot,0,60,0,0,0).
items(22,corn,0,100,0,0,0).
items(23,potato,0,120,0,0,0).
items(24,tomato,0,200,0,0,0).

/******** EQUIPMENT ********/
/* Fishing */
items(25,wooden_fishing_rod,0,200,0,1,0).
items(26,stone_fishing_rod,0,300,0,5,0).
items(27,bronze_fishing_rod,0,500,0,10,0).
items(28,silver_fishing_rod,0,750,0,20,0).
items(29,golden_fishing_rod,0,1000,0,50,0).
/* Farming */
items(30,wooden_shovel,0,200,0,0,1).
items(31,stone_shovel,0,300,0,0,5).
items(32,bronze_shovel,0,500,0,0,10).
items(33,silver_shovel,0,750,0,0,20).
items(34,golden_shovel,0,1000,0,0,50).
