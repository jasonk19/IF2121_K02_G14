:- dynamic(items/8).

/* items(id,name,qty,sell,buy,lvlfish,lvlfarm,lvlranch) */
/******** FISH ********/
/* Small Fish */
items(1,anchovy,0,20,0,0,0,0).
items(2,goldfish,0,35,0,0,0,0).
items(3,guppy,0,50,0,0,0,0).
/* Medium Fish */
items(4,carp,0,125,0,0,0,0).
items(5,bass,0,180,0,0,0,0).
items(6,salmon,0,225,0,0,0,0).
/* Large Fish */
items(7,tuna,0,500,0,0,0,0).
items(8,marlin,0,750,0,0,0,0).
items(9,shark,0,1000,0,0,0,0).
/* Rare Fish */
items(10,treasure_chest,0,2500,0,0,0,0).

/******** RANCH ********/
/* Animal */
items(21,cow,0,500,1000,0,0,0).
items(22,sheep,0,350,700,0,0,0).
items(23,chicken,0,250,500,0,0,0).
/* Animal Product */
items(24,milk,0,375,0,0,0,0).
items(25,milk(large),0,750,0,0,0,0).
items(26,milk(golden),0,2750,0,0,0,0).
items(27,wool,0,250,0,0,0,0).
items(28,wool(large),0,500,0,0,0,0).
items(29,wool(golden),0,2500,0,0,0,0).
items(30,egg,0,100,0,0,0,0).
items(31,egg(large),0,200,0,0,0,0).
items(32,egg(golden),0,2000,0,0,0,0).

/******** FARM ********/
/* Seeds */
items(51,carrot_seed,0,15,30,0,0,0).
items(52,corn_seed,0,25,50,0,0,0).
items(53,potato_seed,0,30,60,0,0,0).
items(54,tomato_seed,0,50,100,0,0,0).
/* Harvest */
items(55,carrot,0,60,0,0,0,0).
items(56,corn,0,100,0,0,0,0).
items(57,potato,0,120,0,0,0,0).
items(58,tomato,0,200,0,0,0,0).

/******** EQUIPMENT ********/
/* Fishing */
items(101,wooden_fishing_rod,0,100,200,1,0,0).
items(102,stone_fishing_rod,0,150,300,5,0,0).
items(103,bronze_fishing_rod,0,250,500,10,0,0).
items(104,silver_fishing_rod,0,375,750,20,0,0).
items(105,golden_fishing_rod,0,500,1000,50,0,0).
/* Farming */
items(106,shovel,0,100,200,0,1,0).
/* Ranch */
items(107,milkers,0,100,200,0,0,1).
items(108,premium_milkers,0,250,500,0,0,15).
items(109,shears,0,100,200,0,0,1).
items(110,premium_shears,0,250,500,0,0,15).
