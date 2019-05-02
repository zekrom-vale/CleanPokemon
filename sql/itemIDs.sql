create table itemIDs(
ID number(5,0) not null check(id>=0), --The ingame numeric identifyer
HEX varchar2(10) , --The hexadesimal value of the ID
NAME nvarchar2(100) , --The name of the item
POKCET varchar2(50) , --The location of the item, in the bag
GAME varchar2(200) , --The game the item is limited to, null if not
GEN number(2,0) references GENERATION(GEN) check(gen>0), --The generation the ID and item corisponds to
CONSTRAINT un_ID unique(ID, GEN, GAME), --Ensure no duplicates per GEN and GAME, by ID
CONSTRAINT un_ID_NAME unique(ID, NAME, GEN, GAME) --Ensure no duplicates per GEN and GAME, by NAME (And ID)
);

insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 568, '0x0238', nq'|Battle CD 35|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 370, '0x0172', nq'|TM43|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 916, '0x0394', nq'|Psychic Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 109, '0x006D', nq'|Dawn Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 849, '0x0351', nq'|Ice Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x0072', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 675, '0x02A3', nq'|Kangaskhanite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 415, '0x019F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 725, '0x02D5', nq'|Letter|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 278, '0x0116', nq'|Iron Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 457, '0x01C9', nq'|Contest Pass|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 69, '0x0045', nq'|PP Up|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 569, '0x0239', nq'|Clever Wing|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x001E', nq'|Fresh Water|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', nq'|TM56|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 475, '0x01DB', nq'|Card Key|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0x00C4', nq'|Kasib Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 859, '0x035B', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 837, '0x0345', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 67, '0x0043', nq'|Calcium|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 483, '0x01E3', nq'|Rainbow Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 272, '0x0110', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', nq'|Up-Grade|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 573, '0x023D', nq'|Plume Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', nq'|Leaf Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x005F', nq'|Growth Mulch|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 730, '0x02DA', nq'|Key to Room 1|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 283, '0x011B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 470, '0x01D6', nq'|Berry Pots|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', nq'|Flame Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x64', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 536, '0x0218', nq'|Enigma Stone|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 607, '0x025F', nq'|X Sp. Def 6|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 773, '0x0305', nq'|Key Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 648, '0x0288', nq'|Luminous Moss|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', nq'|Earth Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 500, '0x01F4', nq'|Park Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', nq'|Power Bracer|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 739, '0x02E3', nq'|Contest Costume|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 39, '0x27', nq'|Revive|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 131, '0x83', nq'|Stardust|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', nq'|Deep Sea Tooth|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x40', nq'|Max Ether|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x0045', nq'|White Flute|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 133, '0x0085', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 486, '0x01E6', nq'|Blue Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 178, '0x00B2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', nq'|Revival Herb|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', nq'|TM56|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 865, '0x0361', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 675, '0x02A3', nq'|Kangaskhanite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 652, '0x028C', nq'|Rich Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 199, '0x00C7', nq'|Metal Coat|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 663, '0x0297', nq'|Mewtwonite Y|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', nq'|Up-Grade|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 64, '0x0040', nq'|Protein|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 637, '0x027D', nq'|Dropped Item|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', nq'|TM80|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', nq'|Chilan Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 249, '0x00F9', nq'|Charcoal|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 546, '0x0222', nq'|Cell Battery|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x005F', nq'|Growth Mulch|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 113, '0x0071', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 945, '0x03B1', nq'|N-Solarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', nq'|Fresh Water|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 348, '0x15C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', nq'|Berry Juice|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 899, '0x0383', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', nq'|Earth Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', nq'|Power Bracer|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 416, '0x01A0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 694, '0x02B6', nq'|TM100|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x0045', nq'|White Flute|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', nq'|Revival Herb|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 742, '0x02E6', nq'|Aqua Suit|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 779, '0x030B', nq'|Electrium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 354, '0x0162', nq'|TM27|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 181, '0x00B5', nq'|Macho Brace|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 523, '0x020B', nq'|Data Card 19|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 821, '0x0335', nq'|Dragonium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x57', nq'|Big Mushroom|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 569, '0x0239', nq'|Clever Wing|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', nq'|Full Restore|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 214, '0xD6', nq'|TM14|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 30, '0x001E', nq'|Fresh Water|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 422, '0x01A6', nq'|HM03|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 204, '0x00CC', nq'|Hard Stone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', nq'|Chilan Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 846, '0x034E', nq'|Adrenaline Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 362, '0x016A', nq'|TM35|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x29', nq'|Guard Spec.|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', nq'|TM67|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x004B', nq'|Green Shard|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', nq'|Dire Hit|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', nq'|Sweet Heart|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', nq'|Stone Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0xAE', nq'|Gold Berry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 58, '0x003A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 530, '0x0212', nq'|Voice Case 3|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 607, '0x025F', nq'|X Sp. Def 6|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', nq'|Earth Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 833, '0x0341', nq'|Eevium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 917, '0x0395', nq'|Ice Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 167, '0x00A7', nq'|Belue Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', nq'|Town Map|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 412, '0x019C', nq'|TM85|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', nq'|Power Bracer|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 474, '0x01DA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 532, '0x0214', nq'|Jade Orb|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 341, '0x0155', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', nq'|Wave Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', nq'|Lunar Wing|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 38, '0x0026', nq'|Lava Cookie|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', nq'|Power Anklet|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 523, '0x020B', nq'|Data Card 19|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 278, '0x0116', nq'|Iron Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 513, '0x0201', nq'|Data Card 09|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', nq'|Sky Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 207, '0x00CF', nq'|Starf Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 569, '0x0239', nq'|Clever Wing|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 226, '0x00E2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 298, '0x012A', nq'|Flame Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 530, '0x0212', nq'|Data Card 26|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 885, '0x0375', nq'|Stretchy Spring|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 897, '0x0381', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 176, '0x00B0', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 268, '0x010C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', nq'|Chilan Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x7A', nq'|Energy Root|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 571, '0x023B', nq'|Pretty Wing|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 216, '0x00D8', nq'|Dragon Fang|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 399, '0x018F', nq'|TM72|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x8C', nq'|Scope Lens|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 34, '0x0022', nq'|Ether|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 111, '0x006F', nq'|Odd Keystone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 452, '0x01C4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 514, '0x0202', nq'|Data Card 10|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x004B', nq'|Green Shard|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x005F', nq'|Growth Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 450, '0x01C2', nq'|Bike|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 660, '0x0294', nq'|Charizardite X|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', nq'|Rare Bone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 607, '0x025F', nq'|X Sp. Def 6|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', nq'|Earth Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 235, '0x00EB', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 503, '0x01F7', nq'|F-Disk|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', nq'|Town Map|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', nq'|Bonsly Card|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 490, '0x01EA', nq'|Wht Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 14, '0x000E', nq'|Antidote|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 91, '0x005B', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 170, '0x00AA', nq'|Kelpsy Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 604, '0x025C', nq'|X Accuracy 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', nq'|Thunder Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', nq'|Power Bracer|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', nq'|Power Anklet|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', nq'|Revival Herb|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 167, '0x00A7', nq'|Wepear Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 780, '0x030C', nq'|Grassium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', nq'|Lunar Wing|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 210, '0x00D2', nq'|Sharp Beak|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 725, '0x02D5', nq'|Letter|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', nq'|Cherish Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 530, '0x0212', nq'|Data Card 26|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 411, '0x019B', nq'|TM84|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 663, '0x0297', nq'|Mewtwonite Y|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 79, '0x004F', nq'|X Special|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0xDA', nq'|TM27|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', nq'|Chilan Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 546, '0x0222', nq'|Cell Battery|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 254, '0x00FE', nq'|Red Scarf|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x004B', nq'|Green Shard|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 507, '0x01FB', nq'|Data Card 03|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', nq'|Sweet Heart|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 740, '0x02E4', nq'|Contest Costume|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 693, '0x02B5', nq'|TM99|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', nq'|TM88|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 104, '0x68', nq'|バラバッヂ (RoseBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 910, '0x038E', nq'|Ghost Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 442, '0x01BA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 307, '0x0133', nq'|TM19|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x0097', nq'|Pecha Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 39, '0x0027', nq'|Blue Flute|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 914, '0x0392', nq'|Grass Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', nq'|Thunder Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 604, '0x025C', nq'|X Accuracy 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 464, '0x01D0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 262, '0x0106', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 384, '0x0180', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 696, '0x02B8', nq'|Mega Ring|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 583, '0x0247', nq'|Battle CD 50|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', nq'|TM07|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 523, '0x020B', nq'|Data Card 19|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 389, '0x0185', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', nq'|Lunar Wing|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', nq'|Antidote|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 724, '0x02D4', nq'|Pokéblock Kit|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', nq'|Light Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x0020', nq'|Heal Powder|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', nq'|Cherish Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 444, '0x01BC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 231, '0x00E7', nq'|Lucky Egg|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', nq'|Passho Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 530, '0x0212', nq'|Data Card 26|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 940, '0x03AC', nq'|Purple Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 832, '0x0340', nq'|Snorlium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 291, '0x0123', nq'|Power Lens|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 241, '0xF1', nq'|TM41|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 978, '0x03D2', nq'|Bulbasaur Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 472, '0x01D8', nq'|Blue Card|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', nq'|TM39|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 185, '0x00B9', nq'|Passho Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 11, '0x0B', nq'|Antidote|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 123, '0x007B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 448, '0x01C0', nq'|Sprayduck|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 126, '0x7E', nq'|Lucky Egg|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0xE5', nq'|TM37|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', nq'|Rare Bone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 723, '0x02D3', nq'|Basement Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', nq'|Town Map|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 243, '0x00F3', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 531, '0x0213', nq'|Data Card 27|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', nq'|Deep Sea Tooth|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 126, '0x007E', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 482, '0x01E2', nq'|Silver Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 472, '0x01D8', nq'|Blue Card|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 53, '0x0035', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 757, '0x02F5', nq'|Audinite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', nq'|Dragon Fang|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', nq'|Wave Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 299, '0x012B', nq'|TM11|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 696, '0x02B8', nq'|Mega Ring|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 942, '0x03AE', nq'|Surge Badge|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 285, '0x011D', nq'|Damp Rock|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 859, '0x035B', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 325, '0x0145', nq'|TM37|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', nq'|Power Anklet|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', nq'|Antidote|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 985, '0x03D9', nq'|Spearow Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 278, '0x0116', nq'|Iron Ball|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 234, '0x00EA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', nq'|Light Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 26, '0x001A', nq'|Super Potion|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 120, '0x0078', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1008, '0x03F0', nq'|Geodude Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 341, '0x0155', nq'|TM14|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', nq'|Passho Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 602, '0x025A', nq'|X Defense 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 344, '0x0158', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 760, '0x02F8', nq'|Slowbronite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 158, '0x009E', nq'|Tamato Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 343, '0x0157', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 460, '0x01CC', nq'|Coupon 1|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 563, '0x0233', nq'|Steel Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', nq'|Leftovers|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 546, '0x0222', nq'|Cell Battery|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 738, '0x02E2', nq'|Devon Scuba Gear|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', nq'|Figy Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 527, '0x020F', nq'|Krane Memo 5|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 578, '0x0242', nq'|Battle CD 45|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 480, '0x01E0', nq'|Pass|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 413, '0x019D', nq'|TM86|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 473, '0x01D9', nq'|SlowpokeTail|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 197, '0xC5', nq'|HM02|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 373, '0x0175', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', nq'|Lustrous Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 274, '0x0112', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 206, '0x00CE', nq'|BlackGlasses|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 496, '0x01F0', nq'|Love Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 400, '0x0190', nq'|TM73|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', nq'|Dragon Fang|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 867, '0x0363', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 585, '0x0249', nq'|Relic Silver|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', nq'|TM61|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 247, '0xF7', nq'|TM47|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 57, '0x0039', nq'|X Attack|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', nq'|TM10|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 884, '0x0374', nq'|Grassy Seed|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', nq'|Antidote|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 481, '0x01E1', nq'|Machine Part|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', nq'|Enigma Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', nq'|Light Ball|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 773, '0x0305', nq'|Key Stone|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 24, '0x0018', nq'|Max Potion|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', nq'|Passho Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 548, '0x0224', nq'|Fire Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 370, '0x0172', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 319, '0x013F', nq'|TM31|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 139, '0x008B', nq'|Oran Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 460, '0x01CC', nq'|Coupon 1|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 467, '0x01D3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 90, '0x005A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', nq'|TM62|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 364, '0x016C', nq'|TM37|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', nq'|Stone Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', nq'|Red Flute|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0x00D2', nq'|Sharp Beak|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 215, '0xD7', nq'|TM15|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 422, '0x01A6', nq'|HM03|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 463, '0x01CF', nq'|Storage Key|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', nq'|Dragon Fang|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 84, '0x54', nq'|B2F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 713, '0x02C9', nq'|Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', nq'|Wave Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 62, '0x003E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 185, '0x00B9', nq'|Mental Herb|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 585, '0x0249', nq'|Relic Silver|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 369, '0x0171', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 520, '0x0208', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', nq'|TM13|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 483, '0x01E3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 473, '0x01D9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', nq'|Magost Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', nq'|Sitrus Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 174, '0x00AE', nq'|Tamato Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', nq'|Enigma Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0x00EC', nq'|Light Ball|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', nq'|TM05|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 370, '0x0172', nq'|MysticTicket|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 548, '0x0224', nq'|Fire Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 272, '0x0110', nq'|Toxic Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', nq'|Passho Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 122, '0x007A', nq'|Medicine Pocket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 324, '0x0144', nq'|TM36|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 125, '0x007D', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 580, '0x0244', nq'|Balm Mushroom|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0xE0', nq'|TM32|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', nq'|Leftovers|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 36, '0x24', nq'|Protein|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 641, '0x0281', nq'|Holo Caster|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1001, '0x03E9', nq'|Mankey Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 718, '0x02CE', nq'|Mach Bike|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 626, '0x0272', nq'|Xtransceiver|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 905, '0x0389', nq'|Flying Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', nq'|Lustrous Orb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 316, '0x013C', nq'|Full Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 154, '0x009A', nq'|Leppa Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', nq'|Wave Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', nq'|Power Anklet|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0x00FA', nq'|Dragon Fang|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 447, '0x01BF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1004, '0x03EC', nq'|Abra Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', nq'|Sitrus Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 801, '0x0321', nq'|Tapunium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x53', nq'|Bitter Berry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', nq'|Enigma Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 803, '0x0323', nq'|Aloraichium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', nq'|Secret Potion|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 548, '0x0224', nq'|Fire Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x001E', nq'|EnergyPowder|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 845, '0x034D', nq'|Sparkling Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 272, '0x0110', nq'|Toxic Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 480, '0x01E0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', nq'|Lucky Punch|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x0033', nq'|Green Shard|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0x00FE', nq'|Sea Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 316, '0x013C', nq'|Full Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 129, '0x0081', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', nq'|Leftovers|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x5A', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 758, '0x02F6', nq'|Metagrossite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 396, '0x018C', nq'|TM69|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', nq'|Stone Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 526, '0x020E', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 18, '0x12', nq'|Hyper Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0x00E3', nq'|DeepSeaScale|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', nq'|Reaper Cloth|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 593, '0x0251', nq'|X Speed 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', nq'|SilverPowder|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 493, '0x01ED', nq'|Level Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 491, '0x01EB', nq'|Black Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', nq'|Lustrous Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 667, '0x029B', nq'|Aggronite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 471, '0x01D7', nq'|Dowsing Machine|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0xBD', nq'|Mirage Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 488, '0x01E8', nq'|Green Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 316, '0x013C', nq'|Full Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', nq'|TM14|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', nq'|TM11|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 283, '0x011B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 25, '0x0019', nq'|Max Revive|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 541, '0x021D', nq'|Air Balloon|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 250, '0x00FA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', nq'|Reply Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', nq'|Sitrus Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', nq'|Secret Potion|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', nq'|Lansat Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 313, '0x0139', nq'|Iron Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', nq'|Destiny Knot|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 50, '0x0032', nq'|Yellow Shard|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 466, '0x01D2', nq'|Gracidea|', q'|Key items|', q'|Platinum, HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0x00FE', nq'|Sea Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0x00DD', nq'|King's Rock|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 515, '0x0203', nq'|Data Card 11|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 525, '0x020D', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 112, '0x0070', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', nq'|Reaper Cloth|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0xE9', nq'|TM41|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x0000', nq'|Nothing|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 474, '0x01DA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', nq'|SilverPowder|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x62', nq'|Blackbelt|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 293, '0x0125', nq'|TM05|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 445, '0x01BD', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 462, '0x01CE', nq'|Coupon 3|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 273, '0x0111', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 676, '0x02A4', nq'|Gyaradosite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 65, '0x0041', nq'|Iron|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 227, '0xE3', nq'|TM27|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 315, '0x013B', nq'|Rock Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', nq'|Choice Band|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 555, '0x022B', nq'|Ground Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 23, '0x17', nq'|ThunderBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 367, '0x016F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 316, '0x013C', nq'|Full Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', nq'|TM11|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 206, '0x00CE', nq'|BlackGlasses|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', nq'|DeepSeaTooth|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 739, '0x02E3', nq'|Contest Costume|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 341, '0x0155', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', nq'|Reply Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 401, '0x0191', nq'|TM74|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 125, '0x007D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 112, '0x0070', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 504, '0x01F8', nq'|RageCandyBar|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 197, '0x00C5', nq'|Lucky Egg|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', nq'|Destiny Knot|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0x00EA', nq'|Leftovers|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0x00DD', nq'|King's Rock|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 867, '0x0363', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 880, '0x0370', nq'|Protective Pads|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 503, '0x01F7', nq'|Tidal Bell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0xDD', nq'|TM29|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 515, '0x0203', nq'|Data Card 11|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 120, '0x0078', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0xBC', nq'|Music Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', nq'|Inquiry Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', nq'|Big Pearl|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 315, '0x013B', nq'|TM27|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 479, '0x01DF', nq'|Lost Item|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', nq'|TM49|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 749, '0x02ED', nq'|Mega Tiara|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', nq'|Lustrous Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x0097', nq'|Pecha Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x01', nq'|Master Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', nq'|Aspear Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 42, '0x002A', nq'|Lava Cookie|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', nq'|Yellow Shard|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 643, '0x0283', nq'|Roller Skates|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 462, '0x01CE', nq'|Coupon 3|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 56, '0x0038', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0xA2', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x85', nq'|Basement Key|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 895, '0x037F', nq'|Leaf Letter|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 239, '0x00EF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 53, '0x0035', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 258, '0x0102', nq'|Thick Club|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 806, '0x0326', nq'|Mewnium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 549, '0x0225', nq'|Battle CD 16|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', nq'|Reply Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', nq'|TM17|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1038, '0x040E', nq'|Electabuzz Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', nq'|Lansat Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 121, '0x0079', nq'|Pokémon Box|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', nq'|TM18|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', nq'|Ice Heal|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 48, '0x0030', nq'|Carbos|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', nq'|Shock Drive|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1039, '0x040F', nq'|Pinsir Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 700, '0x02BC', nq'|Elevator Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 157, '0x009D', nq'|Grepa Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 369, '0x0171', nq'|Tea|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 574, '0x023E', nq'|Liberty Pass|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 404, '0x0194', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 651, '0x028B', nq'|Poké Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', nq'|Razor Claw|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', nq'|Reaper Cloth|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', nq'|TM49|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 125, '0x007D', nq'|Wood Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 700, '0x02BC', nq'|Elevator Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', nq'|Stone Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', nq'|Root Fossil|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', nq'|Charti Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', nq'|Revival Herb|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 462, '0x01CE', nq'|Coupon 3|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 485, '0x01E5', nq'|Red Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 245, '0x00F5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 56, '0x0038', nq'|Dire Hit|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', nq'|TM14|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 604, '0x025C', nq'|X Accuracy 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 579, '0x0243', nq'|Dragon Skull|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 353, '0x0161', nq'|Gold Teeth|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', nq'|TM37|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 621, '0x026D', nq'|Xtransceiver|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 179, '0x00B3', nq'|BrightPowder|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', nq'|Super Rod|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 122, '0x007A', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', nq'|Like Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 85, '0x0055', nq'|Escape Rope|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 28, '0x001C', nq'|Lemonade|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 230, '0x00E6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x66', nq'|BlackGlasses|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 10, '0x0A', nq'|Moon Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 961, '0x03C1', nq'|Mighty Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 236, '0xEC', nq'|TM36|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', nq'|Lansat Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', nq'|TM18|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 542, '0x021E', nq'|Red Card|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 580, '0x0244', nq'|Balm Mushroom|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 799, '0x031F', nq'|Incinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 956, '0x03BC', nq'|Roto HP Restore|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', nq'|Rose Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 365, '0x016D', nq'|TM38|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0x00DD', nq'|King's Rock|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', nq'|Ice Heal|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 106, '0x006A', nq'|Pearl|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 518, '0x0206', nq'|Data Card 14|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 77, '0x004D', nq'|X Speed|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 515, '0x0203', nq'|Data Card 11|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 533, '0x0215', nq'|Lock Capsule|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 643, '0x0283', nq'|Roller Skates|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 493, '0x01ED', nq'|Level Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', nq'|TM83|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', nq'|Metal Coat|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 66, '0x0042', nq'|Yellow Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 237, '0x00ED', nq'|Soft Sand|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 187, '0x00BB', nq'|Rindo Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 462, '0x01CE', nq'|Coupon 3|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 720, '0x02D0', nq'|Wailmer Pail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 767, '0x02FF', nq'|Cameruptite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 621, '0x026D', nq'|Xtransceiver|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x0037', nq'|Guard Spec.|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x0095', nq'|Bluk Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 579, '0x0243', nq'|Dragon Skull|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 403, '0x0193', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 874, '0x036A', nq'|Silph Scope|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 779, '0x030B', nq'|Electrium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 648, '0x0288', nq'|Luminous Moss|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 150, '0x0096', nq'|Nanab Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', nq'|TM26|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 528, '0x0210', nq'|Data Card 24|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', nq'|Max Repel|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 184, '0x00B8', nq'|Soothe Bell|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 816, '0x0330', nq'|Flyinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', nq'|Dread Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', nq'|TM56|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 339, '0x0153', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 879, '0x036F', nq'|Terrain Extender|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', nq'|TM18|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', nq'|Ice Heal|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 102, '0x0066', nq'|Dome Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 516, '0x0204', nq'|Data Card 12|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 937, '0x03A9', nq'|Red Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', nq'|Rose Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 897, '0x0381', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 334, '0x014E', nq'|TM07|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 915, '0x0393', nq'|Electric Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', nq'|TM83|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 593, '0x0251', nq'|X Speed 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 598, '0x0256', nq'|X Accuracy 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', nq'|Metal Coat|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 777, '0x0309', nq'|Firium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 25, '0x0019', nq'|Hyper Potion|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0x00A2', nq'|Nomel Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 367, '0x016F', nq'|TM40|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 99, '0x63', nq'|Blk Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 349, '0x015D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 404, '0x0194', nq'|TM77|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 91, '0x005B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 145, '0x0091', nq'|Mago Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 239, '0x00EF', nq'|Miracle Seed|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 441, '0x01B9', nq'|Red Chain|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', nq'|Sitrus Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 403, '0x0193', nq'|TM76|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', nq'|Lansat Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x0096', nq'|Chesto Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 101, '0x0065', nq'|Helix Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 363, '0x016B', nq'|TM36|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', nq'|Ice Heal|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 619, '0x026B', nq'|TM94|', q'|TMs and HMs|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', nq'|Bridge Mail M|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 606, '0x025E', nq'|X Sp. Atk 6|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 466, '0x01D2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 588, '0x024C', nq'|Relic Band|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 450, '0x01C2', nq'|Bicycle|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 598, '0x0256', nq'|X Accuracy 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 332, '0x014C', nq'|TM05|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 325, '0x0145', nq'|Reaper Cloth|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', nq'|Metal Coat|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 391, '0x0187', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 361, '0x0169', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 114, '0x0072', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 179, '0x00B3', nq'|Spelon Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 383, '0x017F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 45, '0x002D', nq'|Sacred Ash|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 765, '0x02FD', nq'|Prison Bottle|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 626, '0x0272', nq'|Xtransceiver|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 225, '0x00E1', nq'|Stick|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 342, '0x0156', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 264, '0x0108', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 570, '0x023A', nq'|Swift Wing|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 928, '0x03A0', nq'|Lunalium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 541, '0x021D', nq'|Air Balloon|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 401, '0x0191', nq'|TM74|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 480, '0x01E0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', nq'|Coin Case|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', nq'|Stardust|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 136, '0x0088', nq'|Rawst Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', nq'|Destiny Knot|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 306, '0x0132', nq'|TM18|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 284, '0x011C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 370, '0x0172', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 448, '0x01C0', nq'|Sprayduck|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 957, '0x03BD', nq'|Roto PP Restore|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 401, '0x0191', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 575, '0x023F', nq'|Pass Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 32, '0x0020', nq'|Heal Powder|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', nq'|Bridge Mail M|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 593, '0x0251', nq'|X Speed 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 481, '0x01E1', nq'|Machine Part|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 250, '0x00FA', nq'|Dragon Fang|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 233, '0x00E9', nq'|Metal Coat|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 924, '0x039C', nq'|Mimikium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 28, '0x001C', nq'|Revive|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 706, '0x02C2', nq'|Makeup Bag|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', nq'|Nugget|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 87, '0x57', nq'|2F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 738, '0x02E2', nq'|Devon Scuba Gear|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', nq'|Odd Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1034, '0x040A', nq'|Staryu Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 697, '0x02B9', nq'|Intriguing Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 749, '0x02ED', nq'|Mega Tiara|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', nq'|HM06|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 602, '0x025A', nq'|X Defense 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 441, '0x01B9', nq'|Red Chain|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 904, '0x0388', nq'|Fighting Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 562, '0x0232', nq'|Dark Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 931, '0x03A3', nq'|Lycanium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', nq'|Leppa Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 541, '0x021D', nq'|Air Balloon|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 570, '0x023A', nq'|Swift Wing|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', nq'|Stardust|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', nq'|Destiny Knot|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 197, '0x00C5', nq'|Haban Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 245, '0x00F5', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', nq'|Durin Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 456, '0x01C8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 366, '0x016E', nq'|TM39|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 588, '0x024C', nq'|Relic Band|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 619, '0x026B', nq'|TM94|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 582, '0x0246', nq'|Pearl String|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 598, '0x0256', nq'|X Accuracy 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 187, '0x00BB', nq'|King's Rock|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', nq'|TM54|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 73, '0x49', nq'|Poké Flute|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 520, '0x0208', nq'|Data Card 16|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', nq'|Razor Claw|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 369, '0x0171', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 485, '0x01E5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 643, '0x0283', nq'|Roller Skates|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 54, '0x0036', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', nq'|Odd Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 995, '0x03E3', nq'|Oddish Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', nq'|Fashion Case|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 238, '0xEE', nq'|TM38|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 259, '0x0103', nq'|Stick|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 441, '0x01B9', nq'|Red Chain|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 602, '0x025A', nq'|X Defense 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 375, '0x0177', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 949, '0x03B5', nq'|Roto Hatch|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 666, '0x029A', nq'|Houndoominite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 882, '0x0372', nq'|Psychic Seed|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 345, '0x0159', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x0096', nq'|Chesto Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', nq'|Red Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 401, '0x0191', nq'|TM74|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 570, '0x023A', nq'|Swift Wing|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x1F', nq'|Calcium|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', nq'|Stardust|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', nq'|Big Pearl|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 438, '0x01B6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 295, '0x0127', nq'|TM07|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 135, '0x0087', nq'|Pecha Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 505, '0x01F9', nq'|Data Card 01|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 43, '0x002B', nq'|Berry Juice|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 311, '0x0137', nq'|Draco Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 31, '0x001F', nq'|Energy Root|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x0071', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 89, '0x0059', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 366, '0x016E', nq'|TM39|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1037, '0x040D', nq'|Jynx Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 582, '0x0246', nq'|Pearl String|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 231, '0x00E7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0x00E3', nq'|DeepSeaScale|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 633, '0x0279', nq'|Plasma Card|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 588, '0x024C', nq'|Relic Band|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 342, '0x0156', nq'|TM15|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 606, '0x025E', nq'|X Sp. Atk 6|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 700, '0x02BC', nq'|Elevator Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 463, '0x01CF', nq'|Storage Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 71, '0x47', nq'|Itemfinder|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 3, '0x03', nq'|Great Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', nq'|Razor Claw|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', nq'|Salac Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', nq'|TM49|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 639, '0x027F', nq'|Weakness Policy|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 605, '0x025D', nq'|X Speed 6|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 515, '0x0203', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 612, '0x0264', nq'|Item Drop|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 917, '0x0395', nq'|Ice Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 365, '0x016D', nq'|Berry Pouch|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 537, '0x0219', nq'|Prism Scale|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', nq'|Durin Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', nq'|Pearl|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 351, '0x015F', nq'|Secret Key|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', nq'|X Sp. Atk|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 510, '0x01FE', nq'|Data Card 06|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 681, '0x02A9', nq'|Mawilite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 399, '0x018F', nq'|TM72|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 678, '0x02A6', nq'|Charizardite Y|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 202, '0xCA', nq'|TM02|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 834, '0x0342', nq'|Mewnium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 728, '0x02D8', nq'|Go-Goggles|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 202, '0x00CA', nq'|Ganlon Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 458, '0x01CA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 336, '0x0150', nq'|TM48|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', nq'|TM15|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 448, '0x01C0', nq'|Sprayduck|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 124, '0x007C', nq'|Candy Jar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 446, '0x01BE', nq'|Good Rod|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', nq'|Data Card 03|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 128, '0x0080', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 582, '0x0246', nq'|Pearl String|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 245, '0x00F5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0xCD', nq'|TM14|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 915, '0x0393', nq'|Electric Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 605, '0x025D', nq'|X Speed 6|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 374, '0x0176', nq'|Sapphire (item)|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', nq'|Razor Claw|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', nq'|BridgeMail S|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 738, '0x02E2', nq'|Devon Scuba Gear|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', nq'|Salac Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 537, '0x0219', nq'|Prism Scale|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 200, '0xC8', nq'|HM05|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 207, '0xCF', nq'|TM07|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 28, '0x001C', nq'|Revive|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', nq'|Fashion Case|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 101, '0x0065', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 141, '0x008D', nq'|Lum Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 681, '0x02A9', nq'|Mawilite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 403, '0x0193', nq'|TM76|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 214, '0x00D6', nq'|White Herb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', nq'|Moon Stone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', nq'|Dread Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', nq'|Bridge Mail S|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x95', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', nq'|Big Pearl|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', nq'|Shiny Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', nq'|TM04|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 572, '0x023C', nq'|Cover Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 354, '0x0162', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 99, '0x0063', nq'|Root Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', nq'|Pomeg Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 366, '0x016E', nq'|TM39|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 36, '0x0024', nq'|Heal Powder|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 201, '0x00C9', nq'|Dragon Scale|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 537, '0x0219', nq'|Battle CD 04|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 854, '0x0356', nq'|Yellow Nectar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', nq'|Inquiry Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 100, '0x0064', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 259, '0x0103', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 147, '0x0093', nq'|Iapapa Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 40, '0x0028', nq'|Yellow Flute|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', nq'|Salac Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 145, '0x0091', nq'|Bridge Mail D|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 221, '0x00DD', nq'|Lax Incense|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 246, '0x00F6', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 861, '0x035D', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', nq'|Calcium|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 411, '0x019B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 713, '0x02C9', nq'|Bicycle|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 403, '0x0193', nq'|TM76|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 891, '0x037B', nq'|Silver Leaf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 533, '0x0215', nq'|Red ID Badge|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 674, '0x02A2', nq'|Abomasite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 825, '0x0339', nq'|Pikanium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', nq'|TM11|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', nq'|Mago Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 55, '0x0037', nq'|Guard Spec.|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', nq'|Dread Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 491, '0x01EB', nq'|Blk Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 166, '0x00A6', nq'|Durin Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', nq'|Big Pearl|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 339, '0x0153', nq'|TM12|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 693, '0x02B5', nq'|TM99|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 101, '0x0065', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', nq'|Magma Stone|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x73', nq'|マスター (Master - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 705, '0x02C1', nq'|Lens Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x0B', nq'|Ice Heal|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', nq'|Carbos|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', nq'|Letter|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 466, '0x01D2', nq'|Gracidea|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 230, '0xE6', nq'|TM30|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 511, '0x01FF', nq'|Down St. Key|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 933, '0x03A5', nq'|Z-Power Ring|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 463, '0x01CF', nq'|Storage Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', nq'|Hondew Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 622, '0x026E', nq'|God Stone|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 481, '0x01E1', nq'|Machine Part|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 417, '0x01A1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 106, '0x006A', nq'|Pearl|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 399, '0x018F', nq'|TM72|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 490, '0x01EA', nq'|White Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 263, '0x0107', nq'|Green Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', nq'|HP Up|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 537, '0x0219', nq'|Prism Scale|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', nq'|Nugget|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0xB2', nq'|Rainbow Wing|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 697, '0x02B9', nq'|Intriguing Stone|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x1E', nq'|Lucky Punch|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 604, '0x025C', nq'|X Accuracy 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 262, '0x0106', nq'|Pink Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 677, '0x02A5', nq'|Absolite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 160, '0x00A0', nq'|Wiki Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 109, '0x006D', nq'|Star Piece|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 674, '0x02A2', nq'|Abomasite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 179, '0x00B3', nq'|BrightPowder|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 538, '0x021A', nq'|Eviolite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', nq'|Parlyz Heal|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 203, '0x00CB', nq'|Soft Sand|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', nq'|TM04|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', nq'|Enigma Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 982, '0x03D6', nq'|Weedle Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', nq'|Fire Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 722, '0x02D2', nq'|Soot Sack|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 619, '0x026B', nq'|TM94|', q'|TMs and HMs|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 122, '0x007A', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', nq'|Magma Stone|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 488, '0x01E8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 142, '0x008E', nq'|Sitrus Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 364, '0x016C', nq'|TM Case|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 129, '0x81', nq'|Egg Ticket|', q'|Key items|', q'|Crystal|', 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 450, '0x01C2', nq'|Bicycle|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', nq'|Inquiry Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 475, '0x01DB', nq'|Card Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', nq'|Hondew Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 481, '0x01E1', nq'|Machine Part|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 399, '0x018F', nq'|TM72|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 237, '0xED', nq'|TM37|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', nq'|HP Up|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 974, '0x03CE', nq'|Tough Candy XL|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 851, '0x0353', nq'|Beast Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 666, '0x029A', nq'|Houndoominite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 576, '0x0240', nq'|Dream Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 258, '0x0102', nq'|Yellow Scarf|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 68, '0x44', nq'|X Special|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', nq'|Bridge Mail S|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 538, '0x021A', nq'|Eviolite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x02', nq'|Ultra Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 599, '0x0257', nq'|X Speed 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x0059', nq'|Big Pearl|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', nq'|TM42|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', nq'|TM04|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', nq'|Poké Doll|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 90, '0x005A', nq'|Stardust|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', nq'|TM33|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 381, '0x017D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', nq'|Magma Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 18, '0x0012', nq'|Antidote|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 600, '0x0258', nq'|X Sp. Atk 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', nq'|X Defense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 724, '0x02D4', nq'|Pokéblock Kit|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', nq'|Stick|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 497, '0x01F1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x0071', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 99, '0x0063', nq'|Root Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 247, '0x00F7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 748, '0x02EC', nq'|Mega Stickpin|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 129, '0x0081', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 639, '0x027F', nq'|Weakness Policy|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 68, '0x0044', nq'|Rare Candy|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 226, '0xE2', nq'|TM26|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 543, '0x021F', nq'|Ring Target|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 519, '0x0207', nq'|Data Card 15|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 841, '0x0349', nq'|Forage Bag|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 17, '0x0011', nq'|Awakening|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', nq'|Nugget|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', nq'|TM73|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 184, '0x00B8', nq'|Occa Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 513, '0x0201', nq'|Joy Scent|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 99, '0x0063', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 199, '0xC7', nq'|HM04|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', nq'|Old Gateau|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 411, '0x019B', nq'|TM84|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 599, '0x0257', nq'|X Speed 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', nq'|TM42|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 81, '0x0051', nq'|Fluffy Tail|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1023, '0x03FF', nq'|Cubone Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0xB9', nq'|Eon Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', nq'|TM33|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 442, '0x01BA', nq'|Town Map|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', nq'|TM59|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', nq'|TM03|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', nq'|Protector|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', nq'|Yellow Flute|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 52, '0x0034', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 426, '0x01AA', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 605, '0x025D', nq'|X Speed 6|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 130, '0x0082', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 612, '0x0264', nq'|Item Drop|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 129, '0x0081', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 20, '0x0014', nq'|Max Potion|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 620, '0x026C', nq'|TM95|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 241, '0x00F1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 116, '0x0074', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 840, '0x0348', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 490, '0x01EA', nq'|White Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 13, '0x0D', nq'|Ice Heal|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 7, '0x07', nq'|?????|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 852, '0x0354', nq'|Big Malasada|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 259, '0x0103', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', nq'|Fashion Case|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 82, '0x0052', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 677, '0x02A5', nq'|Absolite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 489, '0x01E9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 591, '0x024F', nq'|Battle CD 58|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 61, '0x3D', nq'|Soda Pop|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 492, '0x01EC', nq'|Fast Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 593, '0x0251', nq'|X Speed 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 304, '0x0130', nq'|TM16|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x0096', nq'|Chesto Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 667, '0x029B', nq'|Aggronite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 492, '0x01EC', nq'|Fast Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 599, '0x0257', nq'|X Speed 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', nq'|Wiki Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', nq'|TM42|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 210, '0x00D2', nq'|Sharp Beak|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 491, '0x01EB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 805, '0x0325', nq'|Eevium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', nq'|TM33|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 215, '0x00D7', nq'|Charcoal|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 72, '0x48', nq'|Moomoo Milk|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 215, '0x00D7', nq'|Macho Brace|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 572, '0x023C', nq'|Cover Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x9F', nq'|Level Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 154, '0x009A', nq'|Leppa Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 420, '0x01A4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', nq'|Enigma Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 130, '0x0082', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 368, '0x0170', nq'|TM41|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', nq'|Protector|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 723, '0x02D3', nq'|Basement Key|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 911, '0x038F', nq'|Steel Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 129, '0x0081', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 93, '0x005D', nq'|Sun Stone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', nq'|HM02|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', nq'|Rindo Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 743, '0x02E7', nq'|Pair of Tickets|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 270, '0x010E', nq'|Life Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', nq'|Salac Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 390, '0x0186', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 425, '0x01A9', nq'|HM06|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0xFC', nq'|HM10|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', nq'|Amulet Coin|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1012, '0x03F4', nq'|Farfetch'd Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x2F', nq'|Soda Pop|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 892, '0x037C', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', nq'|Nomel Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 19, '0x0013', nq'|Full Restore|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', nq'|Charti Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 667, '0x029B', nq'|Aggronite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', nq'|Wiki Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 375, '0x0177', nq'|Magma Emblem|', q'|Key items|', q'|Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 96, '0x0060', nq'|Thunderstone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 249, '0xF9', nq'|HM07|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 424, '0x01A8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 572, '0x023C', nq'|Cover Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 621, '0x026D', nq'|Xtransceiver|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 294, '0x0126', nq'|TM06|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', nq'|X Defense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 349, '0x015D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0xCB', nq'|TM12|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', nq'|Protector|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 720, '0x02D0', nq'|Wailmer Pail|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 473, '0x01D9', nq'|SlowpokeTail|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', nq'|Black Belt|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 524, '0x020C', nq'|Data Card 20|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 625, '0x0271', nq'|Gram 3|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 186, '0x00BA', nq'|Choice Band|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 934, '0x03A6', nq'|Pink Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', nq'|Stick|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 354, '0x0162', nq'|TM27|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 568, '0x0238', nq'|Genius Wing|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 263, '0x0107', nq'|Green Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 175, '0x00AF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 492, '0x01EC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 880, '0x0370', nq'|Protective Pads|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 437, '0x01B5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 240, '0xF0', nq'|TM40|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 959, '0x03BF', nq'|Roto Catch|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 691, '0x02B3', nq'|TM97|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 373, '0x0175', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', nq'|Max Revive|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', nq'|Nomel Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0xED', nq'|TM45|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 712, '0x02C8', nq'|Looker Ticket|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', nq'|Wiki Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 820, '0x0334', nq'|Ghostium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', nq'|Greet Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 224, '0xE0', nq'|TM24|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 204, '0x00CC', nq'|Petaya Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', nq'|Rm. 4 Key|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', nq'|Durin Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 248, '0xF8', nq'|TM48|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', nq'|Dread Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', nq'|Dome Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 433, '0x01B1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 226, '0x00E2', nq'|Deep Sea Tooth|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', nq'|TM16|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 476, '0x01DC', nq'|Basement Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 14, '0x0E', nq'|Awakening|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 308, '0x0134', nq'|TM20|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 494, '0x01EE', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 247, '0x00F7', nq'|Spell Tag|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', nq'|TM14|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', nq'|Black Belt|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 625, '0x0271', nq'|Gram 3|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 620, '0x026C', nq'|TM95|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', nq'|Rindo Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 263, '0x0107', nq'|Green Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 193, '0x00C1', nq'|Payapa Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 434, '0x01B2', nq'|Seal Case|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1055, '0x041F', nq'|Mew Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 120, '0x0078', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', nq'|TM89|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 546, '0x0222', nq'|Powerup Part|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 754, '0x02F2', nq'|Sablenite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', nq'|Grip Claw|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', nq'|Max Revive|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 14, '0x000E', nq'|Antidote|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 31, '0x001F', nq'|Energy Root|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 621, '0x026D', nq'|Xtransceiver|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 236, '0x00EC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x36', nq'|Coin Case|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 716, '0x02CC', nq'|Mega Charm|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0x00A0', nq'|Wiki Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 613, '0x0265', nq'|Item Urge|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', nq'|Charti Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', nq'|Nomel Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 420, '0x01A4', nq'|HM01|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 339, '0x0153', nq'|TM12|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 783, '0x030F', nq'|Poisonium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', nq'|Durin Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', nq'|Dome Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 267, '0x010B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', nq'|TM46|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', nq'|SilverPowder|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 154, '0x009A', nq'|Leppa Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 600, '0x0258', nq'|X Sp. Atk 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 734, '0x02DE', nq'|Storage Key|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 448, '0x01C0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 508, '0x01FC', nq'|Subway Key|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', nq'|Black Belt|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 343, '0x0157', nq'|TM16|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 742, '0x02E6', nq'|Aqua Suit|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 588, '0x024C', nq'|Battle CD 55|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', nq'|Rm. 6 Key|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 508, '0x01FC', nq'|Data Card 04|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 882, '0x0372', nq'|Psychic Seed|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 263, '0x0107', nq'|Green Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 558, '0x022E', nq'|Bug Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 435, '0x01B3', nq'|Fashion Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 410, '0x019A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', nq'|Red Flute|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', nq'|Grip Claw|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', nq'|Max Revive|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 378, '0x017A', nq'|TM51|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 112, '0x0070', nq'|Griseous Orb|', q'|Items|', q'|Platinum, HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 510, '0x01FE', nq'|Card Key|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 296, '0x0128', nq'|Big Root|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 244, '0x00F4', nq'|Sharp Beak|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', nq'|Dome Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', nq'|TM22|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 45, '0x002D', nq'|Sacred Ash|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 235, '0xEB', nq'|TM35|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 398, '0x018E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 523, '0x020B', nq'|Data Card 19|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', nq'|Moomoo Milk|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', nq'|Big Mushroom|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x0071', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 573, '0x023D', nq'|Plume Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 116, '0x0074', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0x00F1', nq'|Black Belt|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x7C', nq'|Revival Herb|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 625, '0x0271', nq'|Gram 3|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 568, '0x0238', nq'|Genius Wing|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 500, '0x01F4', nq'|Jail Key|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 586, '0x024A', nq'|Relic Gold|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 530, '0x0212', nq'|Data Card 26|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 28, '0x001C', nq'|Revive|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 558, '0x022E', nq'|Bug Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 890, '0x037A', nq'|Gold Leaf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', nq'|Grip Claw|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 986, '0x03DA', nq'|Ekans Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 862, '0x035E', nq'|Golden Razz Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 764, '0x02FC', nq'|Diancite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 814, '0x032E', nq'|Poisonium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 60, '0x003C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', nq'|Shiny Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 424, '0x01A8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 476, '0x01DC', nq'|Basement Key|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 240, '0x00F0', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 437, '0x01B5', nq'|Pal Pad|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', nq'|Hard Stone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 432, '0x01B0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 456, '0x01C8', nq'|S.S. Ticket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 894, '0x037E', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', nq'|Durin Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 512, '0x0200', nq'|Data Card 08|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 102, '0x0066', nq'|Dome Fossil|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 42, '0x002A', nq'|Black Flute|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', nq'|Dragon Fang|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 227, '0x00E3', nq'|Deep Sea Scale|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 54, '0x0036', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 491, '0x01EB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 310, '0x0136', nq'|Spooky Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 282, '0x011A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 523, '0x020B', nq'|Data Card 19|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 590, '0x024E', nq'|Battle CD 57|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', nq'|TM02|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', nq'|Rindo Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 302, '0x012E', nq'|Icicle Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 486, '0x01E6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 403, '0x0193', nq'|TM76|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 232, '0x00E8', nq'|Scope Lens|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 293, '0x0125', nq'|TM05|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 720, '0x02D0', nq'|Wailmer Pail|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 311, '0x0137', nq'|TM23|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 28, '0x001C', nq'|Revive|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 208, '0x00D0', nq'|Enigma Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 539, '0x021B', nq'|Ein File H|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0xFB', nq'|HM09|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x82', nq'|Lost Item|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 40, '0x0028', nq'|Elixir|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 46, '0x002E', nq'|Protein|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 565, '0x0235', nq'|Health Wing|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 286, '0x011E', nq'|Grip Claw|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', nq'|Parlyz Heal|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', nq'|Full Restore|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 172, '0x00AC', nq'|Apicot Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 819, '0x0333', nq'|Rockium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', nq'|TM13|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', nq'|Charti Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 102, '0x66', nq'|ひんやりバッヂ (CoolBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', nq'|Choice Band|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 808, '0x0328', nq'|Firium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 171, '0x00AB', nq'|Petaya Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0xB1', nq'|Park Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 339, '0x0153', nq'|TM12|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 135, '0x0087', nq'|Adamant Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 31, '0x001F', nq'|Soda Pop|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 120, '0x0078', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x68', nq'|Pink Bow|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', nq'|Rare Candy|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 489, '0x01E9', nq'|Pink Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 482, '0x01E2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 106, '0x6A', nq'|ゴールドバッヂ (GoldBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 191, '0x00BF', nq'|Soul Dew|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', nq'|TM08|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 413, '0x019D', nq'|TM86|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 612, '0x0264', nq'|Item Drop|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 500, '0x01F4', nq'|Park Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', nq'|TM02|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 293, '0x0125', nq'|Power Anklet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 635, '0x027B', nq'|Colress Machine|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 558, '0x022E', nq'|Bug Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 52, '0x0034', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 712, '0x02C8', nq'|Looker Ticket|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x43', nq'|SecretPotion|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', nq'|Yellow Shard|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 345, '0x0159', nq'|TM18|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 494, '0x01EE', nq'|Lure Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 627, '0x0273', nq'|Medal Box|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 99, '0x0063', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 85, '0x55', nq'|B1F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', nq'|TM13|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 351, '0x015F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 634, '0x027A', nq'|Grubby Hanky|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', nq'|Choice Band|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 939, '0x03AB', nq'|Yellow Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 920, '0x0398', nq'|Fairy Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 614, '0x0266', nq'|Reset Urge|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0xAF', nq'|SquirtBottle|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 120, '0x0078', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 122, '0x007A', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x3A', nq'|Old Rod|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', nq'|Rare Candy|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', nq'|Mind Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x42', nq'|Red Scale|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 626, '0x0272', nq'|Xtransceiver|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x0071', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 287, '0x011F', nq'|Choice Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 866, '0x0362', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 710, '0x02C6', nq'|Jaw Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 823, '0x0337', nq'|Steelium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 568, '0x0238', nq'|Genius Wing|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 205, '0xCD', nq'|TM05|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 586, '0x024A', nq'|Relic Gold|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 435, '0x01B3', nq'|Fashion Case|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 129, '0x0081', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', nq'|Cleanse Tag|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', nq'|Yellow Shard|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 426, '0x01AA', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 533, '0x0215', nq'|Lock Capsule|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 768, '0x0300', nq'|Lopunnite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x0097', nq'|Pecha Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 58, '0x003A', nq'|X Defense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 118, '0x0076', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 476, '0x01DC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 823, '0x0337', nq'|Steelium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', nq'|Choice Band|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', nq'|Shiny Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 224, '0x00E0', nq'|Thick Club|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', nq'|Greet Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 512, '0x0200', nq'|Data Card 08|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 235, '0x00EB', nq'|Dragon Scale|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', nq'|Rock Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 261, '0x0105', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 244, '0x00F4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 120, '0x0078', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 122, '0x007A', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 509, '0x01FD', nq'|Maingate Key|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 223, '0x00DF', nq'|Metal Powder|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x39', nq'|Exp.Share|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', nq'|Rare Candy|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', nq'|Mind Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 626, '0x0272', nq'|Xtransceiver|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', nq'|TM14|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 466, '0x01D2', nq'|Gracidea|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 760, '0x02F8', nq'|Slowbronite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 77, '0x004D', nq'|Max Repel|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 524, '0x020C', nq'|Data Card 20|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 938, '0x03AA', nq'|Green Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 201, '0x00C9', nq'|Liechi Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 312, '0x0138', nq'|TM24|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 543, '0x021F', nq'|Ring Target|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', nq'|TM02|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 953, '0x03B9', nq'|Roto Friendship|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 519, '0x0207', nq'|Data Card 15|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', nq'|TM28|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 931, '0x03A3', nq'|Lycanium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', nq'|Coupon 2|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 732, '0x02DC', nq'|Key to Room 4|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x0097', nq'|Pecha Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 168, '0x00A8', nq'|Liechi Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', nq'|TM09|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 505, '0x01F9', nq'|Data Card 01|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 262, '0x0106', nq'|Pink Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', nq'|Contest Pass|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 171, '0x00AB', nq'|Petaya Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', nq'|Greet Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x44', nq'|S.S. Ticket|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 44, '0x2C', nq'|?????|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 835, '0x0343', nq'|Pikashunium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 121, '0x0079', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 120, '0x0078', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 228, '0x00E4', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 300, '0x012C', nq'|TM12|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', nq'|Wacan Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 466, '0x01D2', nq'|Gracidea|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x0032', nq'|Rare Candy|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 427, '0x01AB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', nq'|TM08|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0x00AE', nq'|Tamato Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 585, '0x0249', nq'|Battle CD 52|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', nq'|Soothe Bell|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 159, '0x009F', nq'|Figy Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0x00A4', nq'|Razz Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 392, '0x0188', nq'|TM65|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 543, '0x021F', nq'|Ring Target|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', nq'|Lucky Egg|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', nq'|Coupon 2|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x05', nq'|Poké Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 193, '0x00C1', nq'|DeepSeaScale|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 397, '0x018D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', nq'|X Speed|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 747, '0x02EB', nq'|Mega Anchor|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 627, '0x0273', nq'|Medal Box|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', nq'|TM54|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 533, '0x0215', nq'|Lock Capsule|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 148, '0x0094', nq'|Razz Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 454, '0x01C6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x2C', nq'|Dire Hit|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 494, '0x01EE', nq'|Lure Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 759, '0x02F7', nq'|Sharpedonite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', nq'|Old Gateau|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', nq'|Super Rod|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', nq'|Twisted Spoon|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 634, '0x027A', nq'|Grubby Hanky|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 545, '0x0221', nq'|Absorb Bulb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 600, '0x0258', nq'|X Sp. Atk 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 420, '0x01A4', nq'|HM01|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 629, '0x0275', nq'|DNA Splicers|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 110, '0x006E', nq'|Nugget|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', nq'|Wacan Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', nq'|Adamant Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', nq'|Escape Rope|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 937, '0x03A9', nq'|Red Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 112, '0x70', nq'|プチキャプテン (Petit Captain - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 890, '0x037A', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 82, '0x0052', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0x00AE', nq'|Tamato Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 42, '0x002A', nq'|Black Flute|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0x00A4', nq'|Razz Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', nq'|TM68|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 554, '0x022A', nq'|Poison Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', nq'|Member Card|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 233, '0x00E9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 636, '0x027C', nq'|Dropped Item|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 41, '0x0029', nq'|Red Flute|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 131, '0x0083', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', nq'|Exp. Share|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 997, '0x03E5', nq'|Venonat Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 968, '0x03C8', nq'|Tough Candy L|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 984, '0x03D8', nq'|Rattata Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 533, '0x0215', nq'|Lock Capsule|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 222, '0x00DE', nq'|Lucky Punch|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 661, '0x0295', nq'|Blastoisinite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 565, '0x0235', nq'|Health Wing|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 242, '0x00F2', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0xC7', nq'|TM08|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 609, '0x0261', nq'|X Attack 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0x00D4', nq'|Rowap Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 254, '0x00FE', nq'|Sea Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 247, '0x00F7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 134, '0x0086', nq'|Sweet Heart|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 567, '0x0237', nq'|Resist Wing|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 61, '0x003D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 110, '0x6E', nq'|シルバー (Silver - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 895, '0x037F', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 181, '0x00B5', nq'|Macho Brace|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', nq'|Adamant Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0x00AE', nq'|Tamato Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 623, '0x026F', nq'|Gram 1|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 396, '0x018C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 413, '0x019D', nq'|TM86|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 682, '0x02AA', nq'|Manectite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 544, '0x0220', nq'|Binding Band|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 860, '0x035C', nq'|Enigmatic Card|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 698, '0x02BA', nq'|Common Stone|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', nq'|BridgeMail T|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 554, '0x022A', nq'|Poison Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 636, '0x027C', nq'|Dropped Item|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 423, '0x01A7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 885, '0x0375', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', nq'|Exp. Share|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', nq'|Fluffy Tail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0x00C7', nq'|Babiri Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 39, '0x0027', nq'|Blue Flute|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 876, '0x036C', nq'|Card Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 52, '0x34', nq'|Full Heal|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 126, '0x007E', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 371, '0x0173', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 661, '0x0295', nq'|Blastoisinite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', nq'|Old Gateau|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1047, '0x0417', nq'|Kabuto Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 809, '0x0329', nq'|Waterium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 178, '0x00B2', nq'|Nomel Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 352, '0x0160', nq'|TM25|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 707, '0x02C3', nq'|Travel Trunk|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 463, '0x01CF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 434, '0x01B2', nq'|Seal Case|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 372, '0x0174', nq'|Powder Jar|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 632, '0x0278', nq'|Shiny Charm|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 36, '0x0024', nq'|Elixir|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 543, '0x021F', nq'|Ring Target|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', nq'|Adamant Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 842, '0x034A', nq'|Fishing Rod|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 587, '0x024B', nq'|Relic Vase|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 494, '0x01EE', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x0000', nq'|None|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0x00AE', nq'|Tamato Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0xE1', nq'|TM33|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 413, '0x019D', nq'|TM86|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0x00A4', nq'|Razz Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', nq'|Lucky Egg|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 544, '0x0220', nq'|Binding Band|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', nq'|TM60|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 37, '0x0025', nq'|Max Elixir|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 744, '0x02E8', nq'|Mega Bracelet|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 386, '0x0182', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 393, '0x0189', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 554, '0x022A', nq'|Poison Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 217, '0x00D9', nq'|Silk Scarf|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 637, '0x027D', nq'|Dropped Item|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 628, '0x0274', nq'|DNA Splicers|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1042, '0x0412', nq'|Lapras Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 290, '0x0122', nq'|Power Belt|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 396, '0x018C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 126, '0x007E', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 66, '0x0042', nq'|Carbos|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 964, '0x03C4', nq'|Courage Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', nq'|TM15|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 289, '0x0121', nq'|Power Bracer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 372, '0x0174', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 54, '0x0036', nq'|Old Gateau|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 379, '0x017B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', nq'|Twisted Spoon|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 500, '0x01F4', nq'|Park Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 15, '0x000F', nq'|Burn Heal|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 888, '0x0378', nq'|Lone Earring|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 872, '0x0368', nq'|Secret Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 477, '0x01DD', nq'|SquirtBottle|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 525, '0x020D', nq'|Data Card 21|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 587, '0x024B', nq'|Relic Vase|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 715, '0x02CB', nq'|Fairy Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 538, '0x021A', nq'|Ein File S|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 523, '0x020B', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 198, '0x00C6', nq'|Scope Lens|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 544, '0x0220', nq'|Binding Band|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x8A', nq'|Charcoal|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 418, '0x01A2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', nq'|TM41|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x0000', nq'|None|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 47, '0x002F', nq'|Iron|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 213, '0x00D5', nq'|Spell Tag|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x0037', nq'|Guard Spec.|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', nq'|Smoke Ball|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', nq'|Mind Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 756, '0x02F4', nq'|Galladite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 74, '0x4A', nq'|Lift Key|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 82, '0x52', nq'|Elixer|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 721, '0x02D1', nq'|Devon Parts|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', nq'|Zinc|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 79, '0x004F', nq'|X Special|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 629, '0x0275', nq'|DNA Splicers|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', nq'|Member Card|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 575, '0x023F', nq'|Pass Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 804, '0x0324', nq'|Snorlium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 625, '0x0271', nq'|Gram 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', nq'|Power Lens|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 494, '0x01EE', nq'|Lure Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', nq'|TM50|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 134, '0x0086', nq'|Chesto Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 275, '0x0113', nq'|Focus Sash|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 692, '0x02B4', nq'|TM98|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 399, '0x018F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 579, '0x0243', nq'|Dragon Skull|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 419, '0x01A3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x96', nq'|MysteryBerry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 559, '0x022F', nq'|Rock Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', nq'|Razz Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 715, '0x02CB', nq'|Fairy Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 478, '0x01DE', nq'|Red Scale|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 434, '0x01B2', nq'|Seal Case|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 223, '0x00DF', nq'|Amulet Coin|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 542, '0x021E', nq'|Battle CD 09|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 360, '0x0168', nq'|TM33|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 1, '0x01', nq'|Master Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 886, '0x0376', nq'|Chalky Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', nq'|TM11|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 595, '0x0253', nq'|X Sp. Def 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x0031', nq'|Calcium|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 311, '0x0137', nq'|Draco Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', nq'|TM41|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 594, '0x0252', nq'|X Sp. Atk 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 377, '0x0179', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 682, '0x02AA', nq'|Manectite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 71, '0x0047', nq'|PP Max|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 149, '0x0095', nq'|Cheri Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 524, '0x020C', nq'|Data Card 20|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 671, '0x029F', nq'|Pinsirite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', nq'|Mind Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 66, '0x42', nq'|X Defend|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', nq'|Smoke Ball|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', nq'|Sun Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 116, '0x74', nq'|Blue Card|', q'|Key items|', q'|Crystal|', 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', nq'|Coupon 2|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 499, '0x01F3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x2D', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 203, '0x00CB', nq'|Soft Sand|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 269, '0x010D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 105, '0x0069', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', nq'|Thunderstone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', nq'|TM54|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', nq'|Fire Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 721, '0x02D1', nq'|Devon Parts|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 275, '0x0113', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x0014', nq'|Max Potion|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 124, '0x007C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', nq'|Quick Powder|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 305, '0x0131', nq'|TM17|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 262, '0x0106', nq'|Pink Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', nq'|Super Rod|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 953, '0x03B9', nq'|Roto Friendship|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 559, '0x022F', nq'|Rock Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 518, '0x0206', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 434, '0x01B2', nq'|Seal Case|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', nq'|X Sp. Def|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 64, '0x40', nq'|Gold Teeth|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 499, '0x01F3', nq'|Sport Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 701, '0x02BD', nq'|TMV Pass|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 563, '0x0233', nq'|Steel Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 375, '0x0177', nq'|TM48|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 256, '0x0100', nq'|Lucky Punch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 649, '0x0289', nq'|Snowball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 311, '0x0137', nq'|Draco Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x0000', nq'|None|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', nq'|Lum Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 267, '0x010B', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 39, '0x0027', nq'|Max Ether|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', nq'|Cornn Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 298, '0x012A', nq'|TM10|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 994, '0x03E2', nq'|Zubat Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', nq'|Lucky Egg|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', nq'|Sun Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 575, '0x023F', nq'|Pass Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 84, '0x0054', nq'|Max Repel|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 597, '0x0255', nq'|X Attack 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 459, '0x01CB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', nq'|Member Card|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 461, '0x01CD', nq'|Coupon 2|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x6B', nq'|NeverMeltIce|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1036, '0x040C', nq'|Scyther Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x0031', nq'|Calcium|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', nq'|Mosaic Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 460, '0x01CC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 529, '0x0211', nq'|Data Card 25|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 132, '0x0084', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 925, '0x039D', nq'|Lycanium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 168, '0x00A8', nq'|Pinap Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', nq'|Fire Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 871, '0x0367', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 381, '0x017D', nq'|TM54|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 118, '0x0076', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 376, '0x0178', nq'|Old Sea Map|', q'|Key items|', q'|Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 500, '0x01F4', nq'|Safe Key|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 277, '0x0115', nq'|Metronome|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 516, '0x0204', nq'|Data Card 12|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 866, '0x0362', nq'|Golden Pinap Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 262, '0x0106', nq'|Pink Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 525, '0x020D', nq'|Data Card 21|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 245, '0xF5', nq'|HM03|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 460, '0x01CC', nq'|Coupon 1|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 68, '0x0044', nq'|Black Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 138, '0x008A', nq'|Leppa Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', nq'|Exp. Share|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 156, '0x009C', nq'|Persim Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 30, '0x1E', nq'|Repel|' , 1 );
insert into itemIDs( GAME, GEN )
values( q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 649, '0x0289', nq'|Snowball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 832, '0x0340', nq'|Snorlium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 542, '0x021E', nq'|Red Card|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 311, '0x0137', nq'|Draco Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x99', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 0, '0x00', nq'|?|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 251, '0x00FB', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 803, '0x0323', nq'|Aloraichium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 698, '0x02BA', nq'|Common Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', nq'|TM41|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 446, '0x01BE', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 530, '0x0212', nq'|Data ROM|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 661, '0x0295', nq'|Blastoisinite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 483, '0x01E3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 545, '0x0221', nq'|Absorb Bulb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 19, '0x0013', nq'|Full Restore|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 128, '0x0080', nq'|Battle Pocket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', nq'|Sun Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 454, '0x01C6', nq'|Member Card|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 597, '0x0255', nq'|X Attack 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 701, '0x02BD', nq'|TMV Pass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x87', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', nq'|Yellow Shard|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 549, '0x0225', nq'|Water Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 97, '0x0061', nq'|Stable Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 360, '0x0168', nq'|Bicycle|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 2, '0x02', nq'|Ultra Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 708, '0x02C4', nq'|Lumiose Galette|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', nq'|Quick Powder|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 912, '0x0390', nq'|Fire Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 88, '0x0058', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 118, '0x0076', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 447, '0x01BF', nq'|Super Rod|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 513, '0x0201', nq'|Data Card 09|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 514, '0x0202', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 559, '0x022F', nq'|Rock Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 125, '0x007D', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 111, '0x006F', nq'|Heart Scale|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x90', nq'|Dragon Fang|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0x00D8', nq'|Exp. Share|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 632, '0x0278', nq'|Shiny Charm|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 420, '0x01A4', nq'|HM01|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', nq'|Super Rod|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 305, '0x0131', nq'|TM17|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 398, '0x018E', nq'|TM71|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 402, '0x0192', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', nq'|TM46|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 26, '0x1A', nq'|MarshBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 542, '0x021E', nq'|Red Card|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 320, '0x0140', nq'|TM32|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 594, '0x0252', nq'|X Sp. Atk 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 384, '0x0180', nq'|TM57|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 423, '0x01A7', nq'|HM04|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 318, '0x013E', nq'|TM30|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 694, '0x02B6', nq'|TM100|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 220, '0xDC', nq'|TM20|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 545, '0x0221', nq'|Absorb Bulb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 169, '0x00A9', nq'|Ganlon Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 511, '0x01FF', nq'|Data Card 07|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x60', nq'|TwistedSpoon|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 542, '0x021E', nq'|Cologne Case|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', nq'|Sun Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 597, '0x0255', nq'|X Attack 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 91, '0x005B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x0031', nq'|Calcium|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x004A', nq'|Yellow Shard|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 265, '0x0109', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 74, '0x4A', nq'|PSNCureBerry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x0052', nq'|Fire Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 531, '0x0213', nq'|Data Card 27|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', nq'|Poké Doll|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', nq'|Sticky Barb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 746, '0x02EA', nq'|Mega Glasses|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', nq'|Quick Powder|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', nq'|Small Tablet|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 318, '0x013E', nq'|Rose Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 262, '0x0106', nq'|Pink Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 79, '0x4F', nq'|PP Up|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 37, '0x25', nq'|Iron|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 133, '0x0085', nq'|Cheri Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 799, '0x031F', nq'|Incinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 500, '0x01F4', nq'|Park Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x008D', nq'|Tunnel Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 563, '0x0233', nq'|Steel Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', nq'|TM01|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x0026', nq'|Ether|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 512, '0x0200', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x0000', nq'|None|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', nq'|Protector|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 792, '0x0318', nq'|Steelium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 581, '0x0245', nq'|Big Nugget|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 496, '0x01F0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', nq'|Zinc|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0x00E7', nq'|Lucky Egg|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 209, '0x00D1', nq'|Mystic Water|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 575, '0x023F', nq'|Pass Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x38', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 830, '0x033E', nq'|Marshadium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 283, '0x011B', nq'|Smooth Rock|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', nq'|Power Lens|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', nq'|Blue Flute|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 108, '0x006C', nq'|Stardust|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 531, '0x0213', nq'|Data Card 27|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 524, '0x020C', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', nq'|Poké Doll|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 920, '0x0398', nq'|Fairy Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 980, '0x03D4', nq'|Squirtle Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x001D', nq'|Max Revive|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 591, '0x024F', nq'|Casteliacone|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 449, '0x01C1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 579, '0x0243', nq'|Battle CD 46|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x0026', nq'|Ether|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 333, '0x014D', nq'|TM45|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', nq'|Zap Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 99, '0x63', nq'|かいがらバッヂ (ShellBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 312, '0x0138', nq'|TM24|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 326, '0x0146', nq'|TM38|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', nq'|Zinc|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 172, '0x00AC', nq'|Hondew Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 226, '0x00E2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 511, '0x01FF', nq'|Data Card 07|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', nq'|Shoal Salt|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', nq'|Sacred Ash|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 265, '0x0109', nq'|Wide Lens|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 184, '0x00B8', nq'|Soothe Bell|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 528, '0x0210', nq'|Data Card 24|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 724, '0x02D4', nq'|Pokéblock Kit|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', nq'|Power Lens|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0x00E1', nq'|Soul Dew|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 443, '0x01BB', nq'|Vs. Seeker|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 531, '0x0213', nq'|Data Card 27|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', nq'|Sticky Barb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 497, '0x01F1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', nq'|Smoke Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 689, '0x02B1', nq'|Sprinklotad|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 364, '0x016C', nq'|TM37|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0xB7', nq'|Portraitmail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', nq'|Lucky Punch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0x00D4', nq'|Rowap Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 571, '0x023B', nq'|Battle CD 38|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 365, '0x016D', nq'|TM38|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 467, '0x01D3', nq'|Secret Key|', q'|Key items|', q'|Platinum, HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', nq'|Yellow Flute|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 565, '0x0235', nq'|Health Wing|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 591, '0x024F', nq'|Casteliacone|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 853, '0x0355', nq'|Red Nectar|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 477, '0x01DD', nq'|Squirt Bottle|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 810, '0x032A', nq'|Electrium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 20, '0x0014', nq'|Ice Heal|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 513, '0x0201', nq'|Data Card 09|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x06', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 54, '0x36', nq'|Max Revive|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 204, '0xCC', nq'|TM04|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 850, '0x0352', nq'|Ride Pager|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', nq'|TM46|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 899, '0x0383', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 253, '0x00FD', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', nq'|TM01|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 320, '0x0140', nq'|TM32|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 403, '0x0193', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x0037', nq'|Guard Spec.|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0x00E4', nq'|Smoke Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x0034', nq'|Zinc|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 422, '0x01A6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 104, '0x0068', nq'|Armor Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0x00C7', nq'|Babiri Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 441, '0x01B9', nq'|Red Chain|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', nq'|TM89|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', nq'|Sacred Ash|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 665, '0x0299', nq'|Medichamite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x0031', nq'|Calcium|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0x00D0', nq'|Magnet|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 291, '0x0123', nq'|Power Lens|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 327, '0x0147', nq'|TM39|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 346, '0x015A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x25', nq'|Poké Doll|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', nq'|Lucky Punch|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0x00D4', nq'|Rowap Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 55, '0x0037', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', nq'|Chople Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 713, '0x02C9', nq'|Bicycle|', q'|Key items|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 413, '0x019D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 477, '0x01DD', nq'|Squirt Bottle|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 25, '0x19', nq'|SoulBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0x00D3', nq'|Jaboca Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', nq'|TM03|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x0026', nq'|Ether|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 382, '0x017E', nq'|TM55|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 274, '0x0112', nq'|Quick Powder|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', nq'|TM01|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x0039', nq'|X Attack|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 462, '0x01CE', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 61, '0x003D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 689, '0x02B1', nq'|Sprinklotad|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 236, '0x00EC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', nq'|Adamant Orb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 528, '0x0210', nq'|Data Card 24|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 417, '0x01A1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 243, '0x00F3', nq'|Mystic Water|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 152, '0x0098', nq'|Pinap Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 772, '0x0304', nq'|Meteorite|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', nq'|TM89|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', nq'|Sacred Ash|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 123, '0x007B', nq'|TM Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 289, '0x0121', nq'|TM01|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x005F', nq'|Growth Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 535, '0x0217', nq'|Blue Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 213, '0x00D5', nq'|Spell Tag|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 281, '0x0119', nq'|Rm. 1 Key|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 358, '0x0166', nq'|Dome Fossil|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', nq'|Splash Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', nq'|Silver Powder|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0x00E1', nq'|Soul Dew|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 487, '0x01E7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 161, '0x00A1', nq'|Mago Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 632, '0x0278', nq'|Shiny Charm|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0x00D4', nq'|Rowap Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 521, '0x0209', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 144, '0x0090', nq'|Wiki Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 17, '0x11', nq'|Max Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 879, '0x036F', nq'|Terrain Extender|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', nq'|Chople Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 591, '0x024F', nq'|Casteliacone|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0xC8', nq'|TM09|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 903, '0x0387', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 326, '0x0146', nq'|TM38|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 16, '0x0010', nq'|Ice Heal|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', nq'|TM03|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', nq'|Watmel Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', nq'|Zap Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 877, '0x036D', nq'|Gold Teeth|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 350, '0x015E', nq'|TM23|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 190, '0x00BE', nq'|Cleanse Tag|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 104, '0x0068', nq'|Big Mushroom|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 545, '0x0221', nq'|Absorb Bulb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0x00C7', nq'|Babiri Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1048, '0x0418', nq'|Aerodactyl Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', nq'|TM47|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x006F', nq'|Heart Scale|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 528, '0x0210', nq'|Data Card 24|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 511, '0x01FF', nq'|Data Card 07|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', nq'|Sacred Ash|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0xAD', nq'|Berry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', nq'|Spooky Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 461, '0x01CD', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 772, '0x0304', nq'|Meteorite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 407, '0x0197', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', nq'|Splash Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 35, '0x0023', nq'|Max Ether|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 845, '0x034D', nq'|Sparkling Stone|', q'|Key items|', q'|Sun, Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', nq'|Heal Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', nq'|Sticky Barb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 62, '0x003E', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 377, '0x0179', nq'|TM50|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0x00E1', nq'|Soul Dew|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 197, '0x00C5', nq'|Lucky Egg|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 911, '0x038F', nq'|Steel Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', nq'|TM68|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0x00CF', nq'|Black Belt|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', nq'|TM88|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', nq'|Chople Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 753, '0x02F1', nq'|Sceptilite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x5C', nq'|Ylw Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 74, '0x004A', nq'|Dire Hit|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x0073', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 793, '0x0319', nq'|Fairium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 57, '0x0039', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x28', nq'|Max Revive|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 317, '0x013D', nq'|TM29|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', nq'|Sitrus Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 125, '0x007D', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 513, '0x0201', nq'|Data Card 09|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 82, '0x0052', nq'|Fire Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 924, '0x039C', nq'|Mimikium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 92, '0x005C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 357, '0x0165', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 339, '0x0153', nq'|TM12|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', nq'|Super Repel|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 878, '0x036E', nq'|Lift Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', nq'|TM25|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 487, '0x01E7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 527, '0x020F', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x0037', nq'|Guard Spec.|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 713, '0x02C9', nq'|Bicycle|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', nq'|Pokéblock Case|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 736, '0x02E0', nq'|S.S. Ticket|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 224, '0x00E0', nq'|Thick Club|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 401, '0x0191', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 977, '0x03D1', nq'|Quick Candy XL|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', nq'|Spooky Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 434, '0x01B2', nq'|Seal Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 421, '0x01A5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', nq'|TM68|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', nq'|Rindo Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 189, '0x00BD', nq'|Chople Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 338, '0x0152', nq'|TM11|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 771, '0x0303', nq'|Meteorite|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0x00E0', nq'|Cleanse Tag|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 703, '0x02BF', nq'|Adventure Rules|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 125, '0x007D', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 940, '0x03AC', nq'|Purple Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', nq'|Colbur Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 474, '0x01DA', nq'|Clear Bell|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 451, '0x01C3', nq'|Suite Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 522, '0x020A', nq'|Data Card 18|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', nq'|Cornn Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 127, '0x007F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 615, '0x0267', nq'|Dire Hit 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x009E', nq'|Tamato Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 963, '0x03C3', nq'|Smart Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 730, '0x02DA', nq'|Key to Room 1|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 654, '0x028E', nq'|Boost Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 199, '0x00C7', nq'|Babiri Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 55, '0x37', nq'|Guard Spec.|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 426, '0x01AA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 944, '0x03B0', nq'|N-Lunarizer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 201, '0x00C9', nq'|Dragon Scale|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 528, '0x0210', nq'|Data Card 24|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 718, '0x02CE', nq'|Mach Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 132, '0x0084', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 195, '0x00C3', nq'|Everstone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', nq'|TM08|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x5E', nq'|Cleanse Tag|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 532, '0x0214', nq'|Jade Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x009B', nq'|Qualot Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 285, '0x011D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', nq'|X Sp. Atk|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 493, '0x01ED', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 800, '0x0320', nq'|Primarium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 567, '0x0237', nq'|Resist Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 618, '0x026A', nq'|TM93|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', nq'|TM08|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', nq'|Max Repel|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 464, '0x01D0', nq'|Secret Potion|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 422, '0x01A6', nq'|HM03|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', nq'|Protein|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', nq'|Quick Claw|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0x00E0', nq'|Cleanse Tag|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 703, '0x02BF', nq'|Adventure Rules|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 96, '0x0060', nq'|Thunderstone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 249, '0xF9', nq'|TM49|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 474, '0x01DA', nq'|Clear Bell|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 567, '0x0237', nq'|Resist Wing|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 267, '0x010B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 88, '0x58', nq'|3F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 912, '0x0390', nq'|Fire Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 273, '0x0111', nq'|Flame Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 217, '0x00D9', nq'|Quick Claw|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0x00C7', nq'|Babiri Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 820, '0x0334', nq'|Ghostium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 233, '0x00E9', nq'|Metal Coat|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 111, '0x006F', nq'|Heart Scale|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 405, '0x0195', nq'|TM78|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', nq'|Heal Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', nq'|Thanks Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 347, '0x15B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 395, '0x018B', nq'|TM68|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', nq'|Lucky Punch|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 18, '0x0012', nq'|Parlyz Heal|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', nq'|Big Mushroom|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', nq'|Max Repel|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', nq'|TM61|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 281, '0x0119', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 422, '0x01A6', nq'|HM03|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 831, '0x033F', nq'|Aloraichium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 656, '0x0290', nq'|Gengarite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 659, '0x0293', nq'|Venusaurite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0x00E0', nq'|Cleanse Tag|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 162, '0x00A2', nq'|Aguav Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', nq'|Quick Claw|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 268, '0x010C', nq'|Expert Belt|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 459, '0x01CB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 522, '0x020A', nq'|Data Card 18|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 474, '0x01DA', nq'|Clear Bell|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 63, '0x003F', nq'|HP Up|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0xF4', nq'|HM02|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 567, '0x0237', nq'|Resist Wing|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 193, '0x00C1', nq'|Payapa Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 860, '0x035C', nq'|Enigmatic Card|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 173, '0x00AD', nq'|Lansat Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 160, '0x00A0', nq'|Magost Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 615, '0x0267', nq'|Dire Hit 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', nq'|Colbur Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 688, '0x02B0', nq'|Maranga Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 664, '0x0298', nq'|Blazikenite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', nq'|TM83|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 847, '0x034F', nq'|Zygarde Cube|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 132, '0x0084', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', nq'|TM78|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', nq'|Thanks Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x22', nq'|Leaf Stone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 188, '0x00BC', nq'|SilverPowder|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 96, '0x60', nq'|11F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 396, '0x018C', nq'|TM69|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', nq'|Expert Belt|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0x00B7', nq'|Quick Claw|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 558, '0x022E', nq'|Battle CD 25|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 422, '0x01A6', nq'|HM03|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1046, '0x0416', nq'|Omanyte Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 754, '0x02F2', nq'|Sablenite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x10', nq'|Hyper Potion|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 262, '0x0106', nq'|Old Rod|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 757, '0x02F5', nq'|Audinite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 469, '0x01D5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 72, '0x0048', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 193, '0x00C1', nq'|Payapa Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 640, '0x0280', nq'|Assault Vest|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', nq'|Stick|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 418, '0x01A2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 378, '0x017A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 755, '0x02F3', nq'|Altarianite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 902, '0x0386', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 615, '0x0267', nq'|Dire Hit 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x19', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 220, '0x00DC', nq'|Sea Incense|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', nq'|TM44|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0xF2', nq'|TM50|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0xD4', nq'|TM21|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 436, '0x01B4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 807, '0x0327', nq'|Normalium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 365, '0x016D', nq'|TM38|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 146, '0x0092', nq'|Bridge Mail T|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 664, '0x0298', nq'|Blazikenite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', nq'|Thunderstone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 272, '0x0110', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 561, '0x0231', nq'|Dragon Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 419, '0x01A3', nq'|TM92|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', nq'|TM45|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 225, '0x00E1', nq'|Stick|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 410, '0x019A', nq'|TM83|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 231, '0xE7', nq'|TM39|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 622, '0x026E', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x91', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', nq'|TM78|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', nq'|TM77|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 540, '0x021C', nq'|Ein File C|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', nq'|Splash Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 246, '0x00F6', nq'|Never-Melt Ice|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 352, '0x0160', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 396, '0x018C', nq'|TM69|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 790, '0x0316', nq'|Dragonium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', nq'|Expert Belt|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 322, '0x0142', nq'|Electirizer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 350, '0x015E', nq'|TM23|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 154, '0x009A', nq'|Kelpsy Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', nq'|Zap Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 65, '0x0041', nq'|Iron|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 350, '0x015E', nq'|Poké Flute|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', nq'|TM13|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 381, '0x017D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 418, '0x01A2', nq'|TM91|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', nq'|Quick Claw|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 289, '0x0121', nq'|TM01|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x0026', nq'|Ether|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 812, '0x032C', nq'|Icium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 48, '0x30', nq'|Card Key|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 193, '0x00C1', nq'|Payapa Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 27, '0x001B', nq'|Soda Pop|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', nq'|Petaya Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 640, '0x0280', nq'|Assault Vest|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', nq'|Stick|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x004B', nq'|X Attack|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 108, '0x006C', nq'|Dusk Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x0045', nq'|PP Up|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 236, '0x00EC', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 189, '0x00BD', nq'|Amulet Coin|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 355, '0x0163', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', nq'|TM87|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 538, '0x021A', nq'|Eviolite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 365, '0x016D', nq'|TM38|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 540, '0x021C', nq'|Rocky Helmet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', nq'|TM78|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1010, '0x03F2', nq'|Slowpoke Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 217, '0x00D9', nq'|Silk Scarf|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 299, '0x012B', nq'|Splash Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0x00DE', nq'|Silver Powder|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 396, '0x018C', nq'|TM69|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 566, '0x0236', nq'|Muscle Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x67', nq'|SlowpokeTail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', nq'|Thanks Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 22, '0x0016', nq'|Paralyze Heal|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', nq'|Spell Tag|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 448, '0x01C0', nq'|Sprayduck|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 830, '0x033E', nq'|Marshadium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 752, '0x02F0', nq'|Swampertite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 340, '0x0154', nq'|TM13|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 131, '0x0083', nq'|Fab Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 418, '0x01A2', nq'|TM91|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 522, '0x020A', nq'|Data Card 18|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 109, '0x006D', nq'|Star Piece|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 193, '0x00C1', nq'|Payapa Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 261, '0x0105', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 849, '0x0351', nq'|Ice Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', nq'|TM71|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 209, '0x00D1', nq'|Mystic Water|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 89, '0x59', nq'|4F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 28, '0x001C', nq'|Lemonade|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 324, '0x0144', nq'|Dubious Disc|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 368, '0x0170', nq'|Rainbow Pass|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 74, '0x004A', nq'|Dire Hit|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 950, '0x03B6', nq'|Roto Bargain|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x58', nq'|SilverPowder|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 59, '0x003B', nq'|X Speed|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 28, '0x1C', nq'|Iron|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 43, '0x002B', nq'|White Flute|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 404, '0x0194', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 618, '0x026A', nq'|TM93|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 200, '0x00C8', nq'|Leftovers|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 51, '0x33', nq'|Poké Doll|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0xD7', nq'|TM24|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 324, '0x0144', nq'|TM36|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x49', nq'|Quick Claw|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 427, '0x01AB', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 240, '0x00F0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 418, '0x01A2', nq'|TM91|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 592, '0x0250', nq'|Dire Hit 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 69, '0x0045', nq'|PP Up|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 119, '0x0077', nq'|Chill Drive|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 298, '0x012A', nq'|TM10|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 252, '0x00FC', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 670, '0x029E', nq'|Scizorite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1054, '0x041E', nq'|Mewtwo Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 89, '0x0059', nq'|Big Pearl|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 943, '0x03AF', nq'|N-Solarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 88, '0x0058', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 631, '0x0277', nq'|Oval Charm|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 762, '0x02FA', nq'|Pidgeotite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 118, '0x0076', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 922, '0x039A', nq'|Lunalium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 536, '0x0218', nq'|Ylw ID Badge|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 348, '0x015C', nq'|TM21|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 286, '0x011E', nq'|Grip Claw|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 833, '0x0341', nq'|Eevium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 753, '0x02F1', nq'|Sceptilite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', nq'|TM77|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 524, '0x020C', nq'|Krane Memo 2|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 242, '0xF2', nq'|TM42|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', nq'|Sea Incense|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 83, '0x53', nq'|Max Elixer|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0xAA', nq'|Polkadot Bow|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 535, '0x0217', nq'|Blue Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 246, '0xF6', nq'|TM46|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', nq'|Lucky Punch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 868, '0x0364', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 72, '0x0048', nq'|Red Shard|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 518, '0x0206', nq'|Data Card 14|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 482, '0x01E2', nq'|Silver Wing|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 889, '0x0379', nq'|Beach Glass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 67, '0x0043', nq'|Red Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 78, '0x4E', nq'|Super Rod|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 72, '0x48', nq'|Silph Scope|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 504, '0x01F8', nq'|Gonzap's Key|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 225, '0xE1', nq'|TM25|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x5D', nq'|Grn Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', nq'|Rm. 2 Key|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0x00E0', nq'|Cleanse Tag|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', nq'|Quick Claw|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', nq'|Green Scarf|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 409, '0x0199', nq'|TM82|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 279, '0x0117', nq'|Lagging Tail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', nq'|Choice Specs|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 741, '0x02E5', nq'|Magma Suit|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 362, '0x016A', nq'|TM35|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', nq'|Super Repel|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', nq'|Potion|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 480, '0x01E0', nq'|Pass|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 93, '0x5D', nq'|8F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 246, '0x00F6', nq'|NeverMeltIce|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', nq'|TM08|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 688, '0x02B0', nq'|Maranga Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x0015', nq'|Awakening|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 132, '0x0084', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 528, '0x0210', nq'|Voice Case 1|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 182, '0x00B6', nq'|Exp. Share|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 248, '0x00F8', nq'|Twisted Spoon|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1030, '0x0406', nq'|Tangela Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 83, '0x0053', nq'|Thunder Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 506, '0x01FA', nq'|Data Card 02|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 212, '0x00D4', nq'|NeverMeltIce|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', nq'|Works Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 68, '0x0044', nq'|Rare Candy|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 580, '0x0244', nq'|Battle CD 47|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 312, '0x0138', nq'|TM24|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 132, '0x0084', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 212, '0xD4', nq'|TM12|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', nq'|Steel Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 591, '0x024F', nq'|Casteliacone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 682, '0x02AA', nq'|Manectite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 657, '0x0291', nq'|Gardevoirite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', nq'|TM20|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 650, '0x028A', nq'|Safety Goggles|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 28, '0x1C', nq'|EarthBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', nq'|Super Repel|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0xC6', nq'|TM07|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 313, '0x0139', nq'|TM25|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 552, '0x0228', nq'|Ice Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 52, '0x34', nq'|X Speed|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 289, '0x0121', nq'|TM01|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 246, '0x00F6', nq'|NeverMeltIce|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 689, '0x02B1', nq'|Sprinklotad|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 672, '0x02A0', nq'|Aerodactylite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 784, '0x0310', nq'|Groundium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 727, '0x02D7', nq'|Scanner|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 90, '0x005A', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 230, '0x00E6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', nq'|Iron|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 583, '0x0247', nq'|Comet Shard|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1043, '0x0413', nq'|Ditto Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 726, '0x02D6', nq'|Eon Ticket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x0015', nq'|Awakening|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', nq'|Sticky Barb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 397, '0x018D', nq'|TM70|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 431, '0x01AF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 4, '0x0004', nq'|Poké Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 518, '0x0206', nq'|Data Card 14|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', nq'|Works Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', nq'|Expert Belt|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 642, '0x0282', nq'|Prof's Letter|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', nq'|Poké Doll|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 872, '0x0368', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 574, '0x023E', nq'|Battle CD 41|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', nq'|TM64|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 178, '0x00B2', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 552, '0x0228', nq'|Battle CD 19|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 51, '0x0033', nq'|Green Shard|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 114, '0x72', nq'|RageCandyBar|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1032, '0x0408', nq'|Horsea Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', nq'|Super Repel|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 718, '0x02CE', nq'|Mach Bike|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 929, '0x03A1', nq'|Ultranecrozium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 510, '0x01FE', nq'|Data Card 06|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 552, '0x0228', nq'|Ice Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 672, '0x02A0', nq'|Aerodactylite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', nq'|Iron|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 195, '0x00C3', nq'|Charti Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 23, '0x0017', nq'|Full Restore|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 583, '0x0247', nq'|Comet Shard|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', nq'|TM77|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 97, '0x0061', nq'|Water Stone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 319, '0x013F', nq'|Luck Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 955, '0x03BB', nq'|Roto Stealth|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 631, '0x0277', nq'|Oval Charm|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', nq'|Iron|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 59, '0x003B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', nq'|Yellow Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 200, '0x00C8', nq'|Leftovers|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', nq'|Parlyz Heal|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 347, '0x015B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 69, '0x0045', nq'|White Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 143, '0x008F', nq'|Figy Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 361, '0x0169', nq'|TM34|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', nq'|Works Key|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 518, '0x0206', nq'|Data Card 14|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', nq'|Expert Belt|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 824, '0x0338', nq'|Fairium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 691, '0x02B3', nq'|TM97|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 60, '0x003C', nq'|X Accuracy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 366, '0x016E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 562, '0x0232', nq'|Dark Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 206, '0x00CE', nq'|Lansat Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', nq'|TM25|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 67, '0x0043', nq'|Calcium|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', nq'|Insect Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 542, '0x021E', nq'|Red Card|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x88', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', nq'|Ether|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 552, '0x0228', nq'|Ice Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 487, '0x01E7', nq'|Ylw Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 100, '0x0064', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 828, '0x033C', nq'|Primarium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 534, '0x0216', nq'|Red Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 117, '0x0075', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', nq'|TM88|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 203, '0x00CB', nq'|Soft Sand|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 636, '0x027C', nq'|Dropped Item|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 586, '0x024A', nq'|Relic Gold|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 766, '0x02FE', nq'|Mega Cuff|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 118, '0x0076', nq'|Burn Drive|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 589, '0x024D', nq'|Battle CD 56|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 130, '0x0082', nq'|Dream Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 222, '0xDE', nq'|TM22|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 763, '0x02FB', nq'|Glalitite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 886, '0x0376', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 156, '0x009C', nq'|Hondew Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 338, '0x0152', nq'|TM50|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 177, '0x00B1', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 10, '0x000A', nq'|Timer Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 237, '0x00ED', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', nq'|TM44|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 562, '0x0232', nq'|Dark Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 385, '0x0181', nq'|TM58|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 906, '0x038A', nq'|Poison Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x0072', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', nq'|Insect Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 230, '0x00E6', nq'|Focus Band|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0x00CD', nq'|Apicot Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 130, '0x0082', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', nq'|White Flute|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 84, '0x0054', nq'|Max Repel|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 243, '0xF3', nq'|TM43|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 426, '0x01AA', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 408, '0x0198', nq'|TM81|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 602, '0x025A', nq'|X Defend 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 496, '0x01F0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 583, '0x0247', nq'|Comet Shard|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 32, '0x0020', nq'|Heal Powder|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 687, '0x02AF', nq'|Kee Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 697, '0x02B9', nq'|Intriguing Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 673, '0x02A1', nq'|Lucarionite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 503, '0x01F7', nq'|Machine Part|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', nq'|TM09|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 471, '0x01D7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 909, '0x038D', nq'|Bug Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 9, '0x09', nq'|Pokédex|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 216, '0x00D8', nq'|Exp. Share|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 642, '0x0282', nq'|Prof's Letter|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 826, '0x033A', nq'|Decidium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 20, '0x0014', nq'|Max Potion|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 121, '0x79', nq'|EnergyPowder|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 70, '0x46', nq'|Clear Bell|', q'|Key items|', q'|Crystal|', 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 205, '0x00CD', nq'|Miracle Seed|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 102, '0x0066', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 465, '0x01D1', nq'|Vs. Recorder|', q'|Key items|', q'|Platinum, HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x0089', nq'|Grass Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0x00CD', nq'|Apicot Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 378, '0x017A', nq'|TM51|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 930, '0x03A2', nq'|Mimikium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', nq'|Elixir|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 362, '0x016A', nq'|TM35|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x0067', nq'|TinyMushroom|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 898, '0x0382', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 153, '0x0099', nq'|Pomeg Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', nq'|Iapapa Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 389, '0x0185', nq'|TM62|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 316, '0x013C', nq'|TM28|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', nq'|Meadow Plate|', q'|Items|' , 5 );
insert into itemIDs( GEN )
values( 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', nq'|Spooky Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', nq'|Lansat Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 362, '0x016A', nq'|TM35|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 244, '0x00F4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 288, '0x0120', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 168, '0x00A8', nq'|Liechi Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', nq'|Rare Candy|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 687, '0x02AF', nq'|Kee Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 44, '0x002C', nq'|Berry Juice|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 587, '0x024B', nq'|Battle CD 54|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 274, '0x0112', nq'|Quick Powder|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 513, '0x0201', nq'|Data Card 09|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 492, '0x01EC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 177, '0x00B1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x15', nq'|Max Elixer|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', nq'|Burn Heal|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 59, '0x003B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x35', nq'|X Special|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0xA7', nq'|Normal Box|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 333, '0x014D', nq'|TM06|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 245, '0x00F5', nq'|Poison Barb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 410, '0x019A', nq'|TM83|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 356, '0x0164', nq'|TM29|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 255, '0x00FF', nq'|Blue Scarf|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', nq'|TM31|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 267, '0x010B', nq'|Wise Glasses|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', nq'|Escape Rope|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 287, '0x011F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x0072', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 33, '0x21', nq'|Thunderstone|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 657, '0x0291', nq'|Gardevoirite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 496, '0x01F0', nq'|Love Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', nq'|Ganlon Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0x00CD', nq'|Apicot Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 129, '0x0081', nq'|Tropic Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 362, '0x016A', nq'|TM35|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', nq'|Amulet Coin|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 369, '0x0171', nq'|TM42|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 949, '0x03B5', nq'|Roto Hatch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 782, '0x030E', nq'|Fightinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 72, '0x0048', nq'|Red Shard|', q'|Items|' , 6 );
insert into itemIDs( GEN )
values( 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 310, '0x0136', nq'|Spooky Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 235, '0x00EB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', nq'|Meadow Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 326, '0x0146', nq'|Razor Claw|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 778, '0x030A', nq'|Waterium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 70, '0x0046', nq'|Shoal Salt|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 415, '0x019F', nq'|TM88|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', nq'|TM09|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x69', nq'|Stick|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 504, '0x01F8', nq'|RageCandyBar|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 672, '0x02A0', nq'|Aerodactylite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 4, '0x04', nq'|Poké Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 435, '0x01B3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 495, '0x01EF', nq'|Heavy Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 556, '0x022C', nq'|Battle CD 23|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 514, '0x0202', nq'|Data Card 10|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 497, '0x01F1', nq'|Friend Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', nq'|BridgeMail M|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 41, '0x0029', nq'|Red Flute|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 116, '0x0074', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 958, '0x03BE', nq'|Roto Boost|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x0015', nq'|Awakening|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 743, '0x02E7', nq'|Pair of Tickets|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 361, '0x0169', nq'|TM34|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 331, '0x014B', nq'|TM04|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 582, '0x0246', nq'|Battle CD 49|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 578, '0x0242', nq'|Prop Case|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x0072', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', nq'|Escape Rope|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 488, '0x01E8', nq'|Green Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 412, '0x019C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 402, '0x0192', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 233, '0xE9', nq'|TM33|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 99, '0x0063', nq'|Root Fossil|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0x00CD', nq'|Apicot Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 92, '0x005C', nq'|Nugget|', q'|Items|' , 4 );
insert into itemIDs( GEN )
values( 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 652, '0x028C', nq'|Rich Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 495, '0x01EF', nq'|Heavy Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 372, '0x0174', nq'|TM45|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', nq'|Stardust|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 526, '0x020E', nq'|Data Card 22|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 78, '0x004E', nq'|X Accuracy|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 769, '0x0301', nq'|Salamencite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 552, '0x0228', nq'|Ice Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', nq'|Meadow Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 117, '0x0075', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 881, '0x0371', nq'|Electric Seed|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 151, '0x0097', nq'|Pecha Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0xFD', nq'|HM11|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 52, '0x0034', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 673, '0x02A1', nq'|Lucarionite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 419, '0x01A3', nq'|TM92|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', nq'|TM09|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x2E', nq'|Fresh Water|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0x00FD', nq'|Shell Bell|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 549, '0x0225', nq'|Water Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', nq'|Burn Heal|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 438, '0x01B6', nq'|Works Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 438, '0x01B6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', nq'|TM65|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0x00B6', nq'|Exp. Share|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 53, '0x0035', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 465, '0x01D1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', nq'|Bridge Mail D|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 242, '0x00F2', nq'|Magnet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 610, '0x0262', nq'|X Accuracy 6|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 100, '0x64', nq'|おじぞうバッヂ (JizoBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 488, '0x01E8', nq'|Green Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', nq'|Honey|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 335, '0x014F', nq'|TM08|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 468, '0x01D4', nq'|Apricorn Box|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', nq'|Rule Book|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 452, '0x01C4', nq'|Oak's Letter|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 935, '0x03A7', nq'|Orange Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 857, '0x0359', nq'|Sun Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 44, '0x002C', nq'|Sacred Ash|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x0071', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 563, '0x0233', nq'|Steel Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', nq'|Yellow Flute|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', nq'|Thick Club|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', nq'|HM05|', q'|TMs and HMs|' , 3 );
insert into itemIDs( GEN )
values( 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 290, '0x0122', nq'|Power Belt|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 652, '0x028C', nq'|Rich Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 526, '0x020E', nq'|Data Card 22|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 900, '0x0384', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 420, '0x01A4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0x00C4', nq'|Focus Band|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 128, '0x0080', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 132, '0x0084', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 358, '0x0166', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', nq'|TM63|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 673, '0x02A1', nq'|Lucarionite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1028, '0x0404', nq'|Rhyhorn Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 509, '0x01FD', nq'|Data Card 05|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', nq'|Burn Heal|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', nq'|TM44|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', nq'|Bridge Mail D|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', nq'|TM15|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', nq'|Power Band|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 491, '0x01EB', nq'|Black Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 608, '0x0260', nq'|X Defense 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', nq'|TM50|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 610, '0x0262', nq'|X Accuracy 6|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 362, '0x016A', nq'|VS Seeker|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 331, '0x014B', nq'|TM43|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 505, '0x01F9', nq'|Data Card 01|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 921, '0x0399', nq'|Solganium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 440, '0x01B8', nq'|Galactic Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 230, '0x00E6', nq'|Focus Band|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', nq'|Rule Book|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 504, '0x01F8', nq'|R-Disk|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 773, '0x0305', nq'|Key Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', nq'|Escape Rope|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', nq'|TM49|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 99, '0x0063', nq'|Root Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', nq'|Thick Club|', q'|Items|' , 7 );
insert into itemIDs( GEN )
values( 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 378, '0x017A', nq'|TM51|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 475, '0x01DB', nq'|Card Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 290, '0x0122', nq'|Power Belt|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 336, '0x0150', nq'|TM48|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 499, '0x01F3', nq'|Sport Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 339, '0x0153', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 72, '0x0048', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', nq'|TM36|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', nq'|Sharp Beak|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 129, '0x0081', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 419, '0x01A3', nq'|TM92|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 932, '0x03A4', nq'|Kommonium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 27, '0x001B', nq'|Full Heal|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', nq'|TM63|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', nq'|Bridge Mail T|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 573, '0x023D', nq'|Battle CD 40|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 491, '0x01EB', nq'|Black Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 333, '0x014D', nq'|TM06|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 478, '0x01DE', nq'|Red Scale|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 269, '0x010D', nq'|Light Clay|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', nq'|Blue Shard|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 149, '0x0095', nq'|Bluk Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 137, '0x0089', nq'|Aspear Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', nq'|TM44|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 923, '0x039B', nq'|Ultranecrozium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 623, '0x026F', nq'|Gram 1|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', nq'|Coin Case|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 577, '0x0241', nq'|Battle CD 44|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 789, '0x0315', nq'|Ghostium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', nq'|Power Band|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 77, '0x004D', nq'|X Speed|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 244, '0x00F4', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x0070', nq'|Griseous Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', nq'|Mental Herb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 187, '0x00BB', nq'|King's Rock|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 448, '0x01C0', nq'|Sprayduck|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 126, '0x007E', nq'|Clothing Trunk|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 99, '0x0063', nq'|Root Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', nq'|Thick Club|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x006E', nq'|Nugget|', q'|Items|' , 3 );
insert into itemIDs( GEN )
values( 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 475, '0x01DB', nq'|Card Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0x00F2', nq'|Magnet|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 495, '0x01EF', nq'|Heavy Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0x00DC', nq'|Choice Band|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 176, '0x00B0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 290, '0x0122', nq'|Power Belt|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 547, '0x0223', nq'|Eject Button|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 727, '0x02D7', nq'|Scanner|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 887, '0x0377', nq'|Marble|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 296, '0x0128', nq'|TM08|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', nq'|Space Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x0076', nq'|Burn Drive|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 329, '0x0149', nq'|TM41|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', nq'|Bridge Mail T|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 50, '0x0032', nq'|Rare Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 333, '0x014D', nq'|TM06|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 357, '0x0165', nq'|TM30|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 116, '0x0074', nq'|Douse Drive|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 227, '0x00E3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 6, '0x0006', nq'|Net Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 168, '0xA8', nq'|Gorgeous Box|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 205, '0x00CD', nq'|Miracle Seed|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 371, '0x0173', nq'|TM44|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 722, '0x02D2', nq'|Soot Sack|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', nq'|Blue Scarf|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 610, '0x0262', nq'|X Accuracy 6|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 366, '0x016E', nq'|Teachy TV|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 190, '0x00BE', nq'|Kebia Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 524, '0x020C', nq'|Data Card 20|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 199, '0x00C7', nq'|Metal Coat|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', nq'|TM52|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 623, '0x026F', nq'|Gram 1|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x0076', nq'|Burn Drive|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 58, '0x003A', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', nq'|Power Band|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 971, '0x03CB', nq'|Quick Candy L|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 376, '0x0178', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 873, '0x0369', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 313, '0x0139', nq'|TM25|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 20, '0x14', nq'|Repel|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', nq'|Occa Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x0070', nq'|Griseous Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 579, '0x0243', nq'|Dragon Skull|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 660, '0x0294', nq'|Charizardite X|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', nq'|Mental Herb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 452, '0x01C4', nq'|Oak's Letter|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 939, '0x03AB', nq'|Yellow Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 260, '0x0104', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 484, '0x01E4', nq'|Mystery Egg|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x008F', nq'|Heart Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', nq'|TM07|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 708, '0x02C4', nq'|Lumiose Galette|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 72, '0x0048', nq'|Red Shard|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', nq'|Flame Orb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 835, '0x0343', nq'|Pikashunium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x0076', nq'|Burn Drive|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 959, '0x03BF', nq'|Roto Catch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 401, '0x0191', nq'|TM74|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 270, '0x010E', nq'|Life Orb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 182, '0x00B6', nq'|Durin Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', nq'|Iron|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 164, '0x00A4', nq'|Pamtre Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', nq'|TM63|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 447, '0x01BF', nq'|Super Rod|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 54, '0x0036', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 78, '0x004E', nq'|Escape Rope|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 599, '0x0257', nq'|X Speed 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 900, '0x0384', nq'|Lure|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', nq'|Blue Shard|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', nq'|TM52|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 29, '0x001D', nq'|Moomoo Milk|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', nq'|TM15|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 618, '0x026A', nq'|TM93|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 476, '0x01DC', nq'|Basement Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0xCF', nq'|TM16|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', nq'|Power Band|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 326, '0x0146', nq'|TM38|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x55', nq'|Red Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 587, '0x024B', nq'|Relic Vase|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 467, '0x01D3', nq'|Secret Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', nq'|Occa Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 775, '0x0307', nq'|Eon Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', nq'|Dawn Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', nq'|Watmel Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 88, '0x0058', nq'|Pearl|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', nq'|EnergyPowder|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 519, '0x0207', nq'|Data Card 15|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', nq'|TM31|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 286, '0x011E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 572, '0x023C', nq'|Cover Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 363, '0x016B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x8E', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 475, '0x01DB', nq'|Card Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 72, '0x0048', nq'|Red Shard|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', nq'|Amulet Coin|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', nq'|Light Clay|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 143, '0x8F', nq'|Metal Coat|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x0033', nq'|PP Up|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1041, '0x0411', nq'|Magikarp Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 301, '0x012D', nq'|Meadow Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x18', nq'|Water Stone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 108, '0x6C', nq'|ひよこ (Chick - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', nq'|HM07|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', nq'|Iron|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', nq'|Mystic Water|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 893, '0x037D', nq'|Tropical Shell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 270, '0x010E', nq'|Life Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', nq'|Loot Sack|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', nq'|TM52|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', nq'|TM25|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 535, '0x0217', nq'|Blue Orb|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 192, '0x00C0', nq'|DeepSeaTooth|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', nq'|X Sp. Def|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 537, '0x0219', nq'|Time Flute|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 409, '0x0199', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 86, '0x0056', nq'|Repel|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 460, '0x01CC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 941, '0x03AD', nq'|Rainbow Flower|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 706, '0x02C2', nq'|Makeup Bag|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 742, '0x02E6', nq'|Aqua Suit|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 409, '0x0199', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 62, '0x3E', nq'|Lemonade|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 623, '0x026F', nq'|Gram 1|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0x00FD', nq'|Shell Bell|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 433, '0x01B1', nq'|Journal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x21', nq'|X Accuracy|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 161, '0x00A1', nq'|Mago Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 470, '0x01D6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 540, '0x021C', nq'|Rocky Helmet|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', nq'|Metal Powder|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 587, '0x024B', nq'|Relic Vase|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 521, '0x0209', nq'|Data Card 17|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 775, '0x0307', nq'|Eon Flute|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 761, '0x02F9', nq'|Steelixite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 790, '0x0316', nq'|Dragonium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', nq'|Occa Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 433, '0x01B1', nq'|Journal|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 232, '0x00E8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', nq'|Honey|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', nq'|Watmel Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', nq'|TM31|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 787, '0x0313', nq'|Buginium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 456, '0x01C8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 539, '0x021B', nq'|Battle CD 06|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 314, '0x013A', nq'|Odd Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 487, '0x01E7', nq'|Yellow Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 519, '0x0207', nq'|Cry Analyzer|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', nq'|TM07|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 72, '0x0048', nq'|Red Shard|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 774, '0x0306', nq'|Meteorite Shard|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', nq'|TM47|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', nq'|TM50|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 512, '0x0200', nq'|Data Card 08|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', nq'|Seal Bag|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 347, '0x015B', nq'|TM20|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 449, '0x01C1', nq'|Poffin Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 578, '0x0242', nq'|Prop Case|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 511, '0x01FF', nq'|Poké Snack|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 352, '0x0160', nq'|TM25|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x13', nq'|Escape Rope|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', nq'|X Accuracy|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', nq'|X Sp. Def|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 48, '0x0030', nq'|Red Shard|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', nq'|Explorer Kit|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 875, '0x036B', nq'|Parcel|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 421, '0x01A5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 130, '0x0082', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', nq'|Fluffy Tail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0x00FD', nq'|Shell Bell|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 111, '0x6F', nq'|ゴールド (Gold - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 175, '0x00AF', nq'|Cornn Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 735, '0x02DF', nq'|Devon Scope|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 454, '0x01C6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 670, '0x029E', nq'|Scizorite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 544, '0x0220', nq'|Battle CD 11|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', nq'|Dire Hit|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 379, '0x017B', nq'|TM52|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 526, '0x020E', nq'|Krane Memo 4|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1040, '0x0410', nq'|Tauros Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 161, '0x00A1', nq'|Mago Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x0015', nq'|Awakening|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', nq'|Insect Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', nq'|TM35|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 356, '0x0164', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 769, '0x0301', nq'|Salamencite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 540, '0x021C', nq'|Rocky Helmet|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', nq'|Leaf Stone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 452, '0x01C4', nq'|Oak's Letter|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', nq'|X Defend|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 590, '0x024E', nq'|Relic Crown|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0x00B8', nq'|Occa Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 230, '0x00E6', nq'|Focus Band|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 433, '0x01B1', nq'|Journal|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 236, '0xEC', nq'|TM44|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', nq'|TM31|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', nq'|Watmel Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 449, '0x01C1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', nq'|TM07|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 203, '0x00CB', nq'|Salac Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 715, '0x02CB', nq'|Fairy Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 906, '0x038A', nq'|Poison Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 223, '0xDF', nq'|TM23|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 38, '0x0026', nq'|Lava Cookie|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', nq'|Seal Bag|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 270, '0x010E', nq'|Life Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0x00B7', nq'|Belue Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x003E', nq'|X Sp. Def|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 143, '0x008F', nq'|Figy Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 988, '0x03DC', nq'|Sandshrew Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 47, '0x002F', nq'|Shoal Shell|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 253, '0x00FD', nq'|Shell Bell|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 155, '0x009B', nq'|Qualot Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 242, '0x00F2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0xB3', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', nq'|TM24|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 412, '0x019C', nq'|TM85|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 403, '0x0193', nq'|TM76|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 726, '0x02D6', nq'|Eon Ticket|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1021, '0x03FD', nq'|Voltorb Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1029, '0x0405', nq'|Chansey Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 926, '0x039E', nq'|Kommonium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 337, '0x0151', nq'|TM10|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 230, '0x00E6', nq'|Focus Band|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 521, '0x0209', nq'|Data Card 17|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 753, '0x02F1', nq'|Sceptilite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 951, '0x03B7', nq'|Roto Prize Money|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 120, '0x78', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 519, '0x0207', nq'|Data Card 15|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 580, '0x0244', nq'|BalmMushroom|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 735, '0x02DF', nq'|Devon Scope|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', nq'|Thick Club|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 744, '0x02E8', nq'|Mega Bracelet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 595, '0x0253', nq'|X Sp. Def 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', nq'|Light Clay|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 642, '0x0282', nq'|Prof's Letter|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', nq'|Elixir|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 956, '0x03BC', nq'|Roto HP Restore|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', nq'|TM47|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', nq'|Grepa Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', nq'|Seal Bag|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 870, '0x0366', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 594, '0x0252', nq'|X Special 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 838, '0x0346', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0x00B7', nq'|Belue Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 0, '0x0000', nq'|Nothing|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1052, '0x041C', nq'|Moltres Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', nq'|Cornn Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 565, '0x0235', nq'|Health Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 142, '0x008E', nq'|Sitrus Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1049, '0x0419', nq'|Snorlax Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 908, '0x038C', nq'|Rock Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', nq'|TM01|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', nq'|Coin Case|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 34, '0x0022', nq'|Energy Powder|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 450, '0x01C2', nq'|Bicycle|', q'|Key items|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 375, '0x0177', nq'|TM48|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', nq'|Max Repel|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 317, '0x013D', nq'|TM29|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 412, '0x019C', nq'|TM85|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 627, '0x0273', nq'|Medal Box|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 161, '0x00A1', nq'|Mago Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', nq'|Dire Hit|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 490, '0x01EA', nq'|Wht Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 378, '0x017A', nq'|TM51|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 540, '0x021C', nq'|Rocky Helmet|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 657, '0x0291', nq'|Gardevoirite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', nq'|Big Root|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', nq'|Escape Rope|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 457, '0x01C9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 119, '0x0077', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 804, '0x0324', nq'|Snorlium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 616, '0x0268', nq'|Light Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 64, '0x0040', nq'|Fluffy Tail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 735, '0x02DF', nq'|Devon Scope|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 708, '0x02C4', nq'|Lumiose Galette|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 677, '0x02A5', nq'|Absolite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 146, '0x0092', nq'|Aguav Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', nq'|Elixir|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 632, '0x0278', nq'|Shiny Charm|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 374, '0x0176', nq'|TM47|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', nq'|Flame Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', nq'|Grepa Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 424, '0x01A8', nq'|HM05|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 578, '0x0242', nq'|Prop Case|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 86, '0x0056', nq'|Repel|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0x00B7', nq'|Belue Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 951, '0x03B7', nq'|Roto Prize Money|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 310, '0x0136', nq'|TM22|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 295, '0x0127', nq'|TM07|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 191, '0x00BF', nq'|Shuca Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 175, '0x00AF', nq'|Cornn Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 130, '0x0082', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 303, '0x012F', nq'|TM15|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 300, '0x012C', nq'|TM12|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 8, '0x08', nq'|Safari Ball|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 329, '0x0149', nq'|TM02|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 494, '0x01EE', nq'|Lure Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', nq'|Icy Rock|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x004D', nq'|Max Repel|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 908, '0x038C', nq'|Rock Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 31, '0x1F', nq'|Old Amber|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 628, '0x0274', nq'|DNA Splicers|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x75', nq'|Miracle Seed|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 425, '0x01A9', nq'|HM06|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 499, '0x01F3', nq'|Sport Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 383, '0x017F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', nq'|TM61|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 795, '0x031B', nq'|Bottle Cap|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 35, '0x23', nq'|HP Up|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 499, '0x01F3', nq'|Sport Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 452, '0x01C4', nq'|Oak's Letter|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 378, '0x017A', nq'|TM51|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 279, '0x0117', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', nq'|Big Root|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x0072', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 307, '0x0133', nq'|Mind Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 595, '0x0253', nq'|X Sp. Def 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 386, '0x0182', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 351, '0x015F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 406, '0x0196', nq'|TM79|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 603, '0x025B', nq'|X Attack 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 396, '0x018C', nq'|TM69|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 249, '0x00F9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x0033', nq'|PP Up|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 616, '0x0268', nq'|Light Stone|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 192, '0x00C0', nq'|DeepSeaTooth|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', nq'|Amulet Coin|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 520, '0x0208', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', nq'|Flame Orb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 183, '0x00B7', nq'|Belue Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 198, '0xC6', nq'|HM03|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 239, '0xEF', nq'|TM39|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0xF3', nq'|HM01|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 497, '0x01F1', nq'|Friend Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 366, '0x016E', nq'|TM39|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', nq'|Apicot Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 228, '0x00E4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 634, '0x027A', nq'|Grubby Hanky|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', nq'|TM73|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', nq'|Icy Rock|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 263, '0x0107', nq'|Good Rod|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 321, '0x0141', nq'|TM33|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', nq'|TM24|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 476, '0x01DC', nq'|Basement Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 427, '0x01AB', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 202, '0x00CA', nq'|Light Ball|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 628, '0x0274', nq'|DNA Splicers|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 843, '0x034B', nq'|Professor's Mask|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 429, '0x01AD', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 472, '0x01D8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', nq'|TM41|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 159, '0x009F', nq'|Cornn Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 388, '0x0184', nq'|TM61|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 17, '0x0011', nq'|Potion|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 397, '0x018D', nq'|TM70|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 199, '0x00C7', nq'|Metal Coat|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 746, '0x02EA', nq'|Mega Glasses|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', nq'|Flame Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 491, '0x01EB', nq'|Blk Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 27, '0x001B', nq'|Soda Pop|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', nq'|Big Root|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 21, '0x0015', nq'|Hyper Potion|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', nq'|Shoal Salt|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 414, '0x019E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 404, '0x0194', nq'|TM77|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0xD9', nq'|TM26|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 373, '0x0175', nq'|Ruby (item)|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 616, '0x0268', nq'|Light Stone|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 75, '0x4B', nq'|Exp. All|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 425, '0x01A9', nq'|HM06|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x0033', nq'|PP Up|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 347, '0x15B', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', nq'|Iron Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 40, '0x0028', nq'|Elixir|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 321, '0x0141', nq'|TM33|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', nq'|Revival Herb|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 548, '0x0224', nq'|Battle CD 15|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', nq'|TM30|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', nq'|Guard Spec.|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 76, '0x004C', nq'|X Defend|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 477, '0x01DD', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 517, '0x0205', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 130, '0x0082', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 894, '0x037E', nq'|Leaf Letter|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 445, '0x01BD', nq'|Old Rod|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 371, '0x0173', nq'|AuroraTicket|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', nq'|TM73|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 521, '0x0209', nq'|Data Card 17|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 627, '0x0273', nq'|Medal Box|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', nq'|TM10|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', nq'|Flame Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 376, '0x0178', nq'|TM49|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 253, '0x00FD', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 555, '0x022B', nq'|Battle CD 22|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 622, '0x026E', nq'|???|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 620, '0x026C', nq'|TM95|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', nq'|Coin Case|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 670, '0x029E', nq'|Scizorite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 119, '0x77', nq'|Focus Band|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 476, '0x01DC', nq'|Basement Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 214, '0x00D6', nq'|TwistedSpoon|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 998, '0x03E6', nq'|Diglett Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 128, '0x0080', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 696, '0x02B8', nq'|Mega Ring|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 296, '0x0128', nq'|Big Root|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 433, '0x01B1', nq'|Journal|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 740, '0x02E4', nq'|Contest Costume|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', nq'|Shoal Salt|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 44, '0x002C', nq'|Berry Juice|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', nq'|Like Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 376, '0x0178', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', nq'|Watmel Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 141, '0x008D', nq'|Lum Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', nq'|EnergyPowder|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 990, '0x03DE', nq'|Nidoran♂ Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 350, '0x015E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', nq'|Iron Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 196, '0x00C4', nq'|Focus Band|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 747, '0x02EB', nq'|Mega Anchor|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0x00DF', nq'|Amulet Coin|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 608, '0x0260', nq'|X Defend 6|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 328, '0x0148', nq'|TM01|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 519, '0x0207', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 352, '0x0160', nq'|Bike Voucher|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 379, '0x017B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 564, '0x0234', nq'|Normal Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x0C', nq'|Awakening|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 481, '0x01E1', nq'|Machine Part|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 460, '0x01CC', nq'|Coupon 1|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 778, '0x030A', nq'|Waterium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 445, '0x01BD', nq'|Old Rod|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 631, '0x0277', nq'|Oval Charm|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 477, '0x01DD', nq'|Squirt Bottle|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', nq'|Grepa Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 919, '0x0397', nq'|Dark Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', nq'|TM10|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', nq'|Flame Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0x00EB', nq'|Dragon Scale|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 957, '0x03BD', nq'|Roto PP Restore|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 127, '0x007F', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 280, '0x0118', nq'|Meteorite|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 647, '0x0287', nq'|Sachet|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 622, '0x026E', nq'|???|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 654, '0x028E', nq'|Boost Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 319, '0x013F', nq'|TM31|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 504, '0x01F8', nq'|Rage Candy Bar|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', nq'|Shoal Salt|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 595, '0x0253', nq'|X Sp. Def 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 945, '0x03B1', nq'|N-Solarizer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', nq'|Iron Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0xDB', nq'|TM28|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 388, '0x0184', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 487, '0x01E7', nq'|Yellow Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 375, '0x0177', nq'|TM48|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 279, '0x0117', nq'|Lagging Tail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', nq'|Paralyze Heal|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 505, '0x01F9', nq'|L-Disk|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 21, '0x15', nq'|BoulderBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 436, '0x01B4', nq'|Seal Bag|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x03', nq'|BrightPowder|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 802, '0x0322', nq'|Marshadium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', nq'|Sharp Beak|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 507, '0x01FB', nq'|Data Card 03|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 146, '0x0092', nq'|Aguav Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 426, '0x01AA', nq'|HM07|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 236, '0x00EC', nq'|Light Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 43, '0x002B', nq'|White Flute|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1015, '0x03F7', nq'|Grimer Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 647, '0x0287', nq'|Sachet|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', nq'|TM16|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 460, '0x01CC', nq'|Coupon 1|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 522, '0x020A', nq'|Data Card 18|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 664, '0x0298', nq'|Blazikenite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 445, '0x01BD', nq'|Old Rod|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 156, '0x009C', nq'|Hondew Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 262, '0x0106', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 173, '0x00AD', nq'|Grepa Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', nq'|Heart Scale|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0x00A4', nq'|Razz Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 774, '0x0306', nq'|Meteorite Shard|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0x00EB', nq'|Dragon Scale|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 104, '0x0068', nq'|Big Mushroom|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 298, '0x012A', nq'|Flame Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 14, '0x000E', nq'|Heal Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 444, '0x01BC', nq'|Coin Case|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x0020', nq'|Lemonade|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', nq'|Dire Hit|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 82, '0x52', nq'|King's Rock|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 489, '0x01E9', nq'|Pnk Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 351, '0x015F', nq'|TM24|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', nq'|Insect Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 504, '0x01F8', nq'|Rage Candy Bar|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', nq'|Elixir|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 75, '0x004B', nq'|X Attack|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 323, '0x0143', nq'|TM35|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 355, '0x0163', nq'|Card Key|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', nq'|Shoal Salt|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 960, '0x03C0', nq'|Health Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', nq'|Dusk Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 212, '0x00D4', nq'|NeverMeltIce|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 375, '0x0177', nq'|TM48|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x0095', nq'|Cheri Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 629, '0x0275', nq'|DNA Splicers|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x17', nq'|Thunderstone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 477, '0x01DD', nq'|Squirt Bottle|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 507, '0x01FB', nq'|Data Card 03|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 747, '0x02EB', nq'|Mega Anchor|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', nq'|Loot Sack|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1009, '0x03F1', nq'|Ponyta Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 142, '0x008E', nq'|Like Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', nq'|Yellow Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 992, '0x03E0', nq'|Vulpix Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 268, '0x010C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 610, '0x0262', nq'|X Accuracy 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 445, '0x01BD', nq'|Old Rod|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 340, '0x0154', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 358, '0x0166', nq'|TM31|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', nq'|Heart Scale|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 758, '0x02F6', nq'|Metagrossite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 266, '0x010A', nq'|Muscle Band|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0x00EB', nq'|Dragon Scale|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', nq'|Micle Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 760, '0x02F8', nq'|Slowbronite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 39, '0x0027', nq'|Blue Flute|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 82, '0x0052', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 390, '0x0186', nq'|TM63|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 208, '0xD0', nq'|TM17|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 471, '0x01D7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 518, '0x0206', nq'|Data Card 14|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 214, '0x00D6', nq'|TwistedSpoon|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 338, '0x0152', nq'|TM11|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 412, '0x019C', nq'|TM85|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 125, '0x7D', nq'|Hard Stone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 6, '0x06', nq'|Bicycle|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', nq'|Zoom Lens|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 142, '0x008E', nq'|Like Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 954, '0x03BA', nq'|Roto Encounter|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 461, '0x01CD', nq'|Coupon 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 221, '0x00DD', nq'|King's Rock|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', nq'|Dusk Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', nq'|Gooey Mulch|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 427, '0x01AB', nq'|HM08|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', nq'|Dawn Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 430, '0x01AE', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 559, '0x022F', nq'|Battle CD 26|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 108, '0x006C', nq'|Stardust|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 318, '0x013E', nq'|TM30|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 630, '0x0276', nq'|Permit|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', nq'|Loot Sack|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', nq'|X Special|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 273, '0x0111', nq'|Flame Orb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 513, '0x0201', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 525, '0x020D', nq'|Data Card 21|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 958, '0x03BE', nq'|Roto Boost|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0x00EB', nq'|Dragon Scale|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', nq'|Dusk Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', nq'|Micle Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 119, '0x0077', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 320, '0x0140', nq'|Pure Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 161, '0x00A1', nq'|Rabuta Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 853, '0x0355', nq'|Red Nectar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 73, '0x0049', nq'|Guard Spec.|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x0020', nq'|Lemonade|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 527, '0x020F', nq'|Data Card 23|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0x00C2', nq'|Smoke Ball|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 432, '0x01B0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 181, '0x00B5', nq'|Watmel Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0x00A2', nq'|Aguav Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', nq'|Dawn Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 138, '0x008A', nq'|Leppa Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 716, '0x02CC', nq'|Mega Charm|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 842, '0x034A', nq'|Fishing Rod|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 393, '0x0189', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 375, '0x0177', nq'|TM48|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x0033', nq'|PP Up|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x0095', nq'|Cheri Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 482, '0x01E2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 507, '0x01FB', nq'|Data Card 03|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 274, '0x0112', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 429, '0x01AD', nq'|Loot Sack|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0x00F2', nq'|Magnet|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', nq'|Hyper Potion|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 428, '0x01AC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 705, '0x02C1', nq'|Lens Case|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', nq'|Yellow Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 137, '0x0089', nq'|Aspear Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 819, '0x0333', nq'|Rockium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', nq'|Black Flute|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', nq'|Dusk Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 242, '0x00F2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', nq'|TM20|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x0020', nq'|Lemonade|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 240, '0x00F0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 796, '0x031C', nq'|Gold Bottle Cap|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 433, '0x01B1', nq'|Journal|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 601, '0x0259', nq'|X Sp. Def 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 560, '0x0230', nq'|Ghost Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 162, '0x00A2', nq'|Nomel Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 457, '0x01C9', nq'|Contest Pass|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 544, '0x0220', nq'|Binding Band|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 798, '0x031E', nq'|Decidium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 878, '0x036E', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x0095', nq'|Cheri Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 41, '0x29', nq'|Dome Fossil|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', nq'|Soft Sand|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 44, '0x002C', nq'|Berry Juice|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', nq'|Hyper Potion|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 308, '0x0134', nq'|Insect Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0x00F2', nq'|Magnet|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 495, '0x01EF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 710, '0x02C6', nq'|Jaw Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 705, '0x02C1', nq'|Lens Case|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 514, '0x0202', nq'|Excite Scent|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 420, '0x01A4', nq'|HM01|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 38, '0x0026', nq'|Ether|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 335, '0x014F', nq'|TM47|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 510, '0x01FE', nq'|Data Card 06|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 194, '0x00C2', nq'|Smoke Ball|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', nq'|Dusk Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 856, '0x0358', nq'|Purple Nectar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 256, '0x0100', nq'|Pink Scarf|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 422, '0x01A6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 210, '0xD2', nq'|TM10|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', nq'|TM20|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 97, '0x0061', nq'|Water Stone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 524, '0x020C', nq'|Data Card 20|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 721, '0x02D1', nq'|Devon Parts|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 504, '0x01F8', nq'|Rage Candy Bar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 266, '0x010A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 618, '0x026A', nq'|TM93|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 522, '0x020A', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 457, '0x01C9', nq'|Contest Pass|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', nq'|Dawn Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 741, '0x02E5', nq'|Magma Suit|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 484, '0x01E4', nq'|Mystery Egg|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 0, '0x0000', nq'|Nothing|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', nq'|Gooey Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 304, '0x0130', nq'|TM16|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', nq'|Iron Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 486, '0x01E6', nq'|Blue Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 508, '0x01FC', nq'|Data Card 04|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', nq'|Hyper Potion|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 616, '0x0268', nq'|Light Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', nq'|Soft Sand|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 242, '0x00F2', nq'|Magnet|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 966, '0x03C6', nq'|Health Candy L|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 127, '0x007F', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 163, '0x00A3', nq'|Iapapa Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 562, '0x0232', nq'|Dark Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', nq'|TM16|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 710, '0x02C6', nq'|Jaw Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1006, '0x03EE', nq'|Bellsprout Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 813, '0x032D', nq'|Fightinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 281, '0x0119', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 489, '0x01E9', nq'|Pnk Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', nq'|Hyper Potion|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 362, '0x016A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x006C', nq'|Dusk Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', nq'|Black Flute|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 117, '0x0075', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 498, '0x01F2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 845, '0x034D', nq'|Sparkling Stone|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0xC4', nq'|TM05|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x0020', nq'|Lemonade|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 728, '0x02D8', nq'|Go-Goggles|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 160, '0x00A0', nq'|Magost Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 89, '0x0059', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 166, '0x00A6', nq'|Nanab Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 55, '0x0037', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 16, '0x0010', nq'|Ice Heal|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 290, '0x0122', nq'|TM02|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 470, '0x01D6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 499, '0x01F3', nq'|Sport Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 839, '0x0347', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 421, '0x01A5', nq'|HM02|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', nq'|Light Clay|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 921, '0x0399', nq'|Solganium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 502, '0x01F6', nq'|GB Sounds|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 332, '0x014C', nq'|TM44|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 563, '0x0233', nq'|Battle CD 30|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 508, '0x01FC', nq'|System Lever|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 473, '0x01D9', nq'|Slowpoke Tail|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 484, '0x01E4', nq'|Mystery Egg|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 291, '0x0123', nq'|TM03|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 431, '0x01AF', nq'|Poké Radar|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', nq'|Soft Sand|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 250, '0xFA', nq'|HM08|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 950, '0x03B6', nq'|Roto Bargain|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 374, '0x0176', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 624, '0x0270', nq'|Gram 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 253, '0x00FD', nq'|Shell Bell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', nq'|TM22|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 979, '0x03D3', nq'|Charmander Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 593, '0x0251', nq'|Battle CD 60|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 156, '0x009C', nq'|Persim Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 355, '0x0163', nq'|TM28|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x61', nq'|Wht Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 474, '0x01DA', nq'|Clear Bell|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', nq'|Heart Scale|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', nq'|Black Flute|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 505, '0x01F9', nq'|Data ROM|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 237, '0x00ED', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 788, '0x0314', nq'|Rockium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', nq'|TM26|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 490, '0x01EA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 529, '0x0211', nq'|Data Card 25|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 85, '0x0055', nq'|Leaf Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 551, '0x0227', nq'|Battle CD 18|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 531, '0x0213', nq'|Voice Case 4|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 249, '0x00F9', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', nq'|Honey|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 342, '0x0156', nq'|HM04|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 560, '0x0230', nq'|Ghost Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 695, '0x02B7', nq'|Power Plant Pass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 57, '0x0039', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 26, '0x001A', nq'|Fresh Water|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', nq'|Gooey Mulch|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 431, '0x01AF', nq'|Poké Radar|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', nq'|Paralyze Heal|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 174, '0x00AE', nq'|Starf Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 662, '0x0296', nq'|Mewtwonite X|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', nq'|Big Mushroom|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 37, '0x0025', nq'|Revival Herb|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1035, '0x040B', nq'|Mr. Mime Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 251, '0x00FB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 506, '0x01FA', nq'|D-Disk|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x2A', nq'|Super Repel|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 525, '0x020D', nq'|Data Card 21|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', nq'|TM22|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 343, '0x0157', nq'|TM16|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 668, '0x029C', nq'|Banettite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 646, '0x0286', nq'|Whipped Dream|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 891, '0x037B', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', nq'|Icy Rock|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 441, '0x01B9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', nq'|Heart Scale|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 256, '0x0100', nq'|Pink Scarf|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 370, '0x0172', nq'|TM43|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1005, '0x03ED', nq'|Machop Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', nq'|TM24|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 549, '0x0225', nq'|Water Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 736, '0x02E0', nq'|S.S. Ticket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 679, '0x02A7', nq'|Alakazite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', nq'|TM26|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', nq'|Repel|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 154, '0x009A', nq'|Leppa Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 412, '0x019C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', nq'|Odd Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 727, '0x02D7', nq'|Scanner|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 164, '0x00A4', nq'|Razz Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 177, '0x00B1', nq'|Rabuta Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 93, '0x005D', nq'|Sun Stone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', nq'|Micle Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', nq'|Point Card|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', nq'|BrightPowder|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 12, '0x0C', nq'|Burn Heal|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 68, '0x0044', nq'|Black Flute|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 180, '0x00B4', nq'|Pamtre Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 766, '0x02FE', nq'|Mega Cuff|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 758, '0x02F6', nq'|Metagrossite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 734, '0x02DE', nq'|Storage Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 27, '0x1B', nq'|VolcanoBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 279, '0x0117', nq'|Lagging Tail|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 200, '0x00C8', nq'|Leftovers|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0x00A2', nq'|Aguav Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 932, '0x03A4', nq'|Kommonium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 858, '0x035A', nq'|Moon Flute|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 425, '0x01A9', nq'|HM06|', q'|TMs and HMs|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 596, '0x0254', nq'|X Defense 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 98, '0x0062', nq'|Gooey Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 269, '0x010D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 737, '0x02E1', nq'|HM07|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 81, '0x0051', nq'|Moon Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 408, '0x0198', nq'|TM81|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 534, '0x0216', nq'|Battle CD 01|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 264, '0x0108', nq'|Yellow Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 226, '0x00E2', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 124, '0x007C', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 213, '0xD5', nq'|TM13|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 525, '0x020D', nq'|Data Card 21|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0x00F0', nq'|Black Glasses|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 889, '0x0379', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x92', nq'|Leftovers|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 251, '0x00FB', nq'|Silk Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x0070', nq'|Griseous Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 123, '0x007B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 827, '0x033B', nq'|Incinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', nq'|Salac Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 815, '0x032F', nq'|Groundium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 549, '0x0225', nq'|Water Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 154, '0x9A', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 374, '0x0176', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', nq'|TM26|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 314, '0x013A', nq'|Odd Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', nq'|Repel|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 46, '0x002E', nq'|Shoal Salt|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', nq'|Blue Shard|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 311, '0x0137', nq'|TM23|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 506, '0x01FA', nq'|Data Card 02|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', nq'|Micle Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', nq'|TM10|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 70, '0x0046', nq'|Zinc|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 533, '0x0215', nq'|Disc Case|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 260, '0x0104', nq'|Red Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 400, '0x0190', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', nq'|Light Clay|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 393, '0x0189', nq'|TM66|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0x00A2', nq'|Aguav Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 61, '0x003D', nq'|X Sp. Atk|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 675, '0x02A3', nq'|Kangaskhanite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 796, '0x031C', nq'|Gold Bottle Cap|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 279, '0x0117', nq'|Lagging Tail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 596, '0x0254', nq'|X Defense 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 87, '0x0057', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 510, '0x01FE', nq'|Data Card 06|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 755, '0x02F3', nq'|Altarianite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 247, '0x00F7', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 858, '0x035A', nq'|Moon Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 124, '0x007C', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 127, '0x007F', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 864, '0x0360', nq'|Golden Nanab Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 69, '0x45', nq'|Coin Case|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 429, '0x01AD', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', nq'|TM22|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 681, '0x02A9', nq'|Mawilite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 156, '0x009C', nq'|Persim Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 122, '0x007A', nq'|Harbor Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 337, '0x0151', nq'|TM49|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 307, '0x0133', nq'|TM19|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 361, '0x0169', nq'|TM34|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 108, '0x6C', nq'|Magnet|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1002, '0x03EA', nq'|Growlithe Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 526, '0x020E', nq'|Data Card 22|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 65, '0x41', nq'|X Attack|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 103, '0x0067', nq'|Old Amber|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 399, '0x018F', nq'|TM72|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 634, '0x027A', nq'|Grubby Hanky|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 430, '0x01AE', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 243, '0x00F3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 495, '0x01EF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', nq'|Power Herb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 317, '0x013D', nq'|Wave Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', nq'|TM64|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 703, '0x02BF', nq'|Adventure Rules|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 781, '0x030D', nq'|Icium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 94, '0x005E', nq'|Honey|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 640, '0x0280', nq'|Assault Vest|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 560, '0x0230', nq'|Ghost Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 162, '0x00A2', nq'|Aguav Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 874, '0x036A', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 457, '0x01C9', nq'|Contest Pass|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1019, '0x03FB', nq'|Drowzee Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 581, '0x0245', nq'|Big Nugget|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 137, '0x89', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 918, '0x0396', nq'|Dragon Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', nq'|TM17|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 157, '0x009D', nq'|Lum Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 127, '0x007F', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 529, '0x0211', nq'|Voice Case 2|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 366, '0x016E', nq'|TM39|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 245, '0xF5', nq'|TM45|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', nq'|Stable Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x56', nq'|TinyMushroom|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', nq'|Heal Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 361, '0x0169', nq'|TM34|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 35, '0x0023', nq'|Max Ether|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 478, '0x01DE', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 499, '0x01F3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 353, '0x0161', nq'|TM26|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0xF7', nq'|HM05|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', nq'|Pamtre Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', nq'|Repel|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 154, '0x009A', nq'|Leppa Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 58, '0x3A', nq'|Dire Hit|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 834, '0x0342', nq'|Mewnium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 439, '0x01B7', nq'|Old Charm|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', nq'|Full Heal|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 314, '0x013A', nq'|TM26|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 533, '0x0215', nq'|Lock Capsule|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 481, '0x01E1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 516, '0x0204', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', nq'|Snow Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 153, '0x0099', nq'|Aspear Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 254, '0x00FE', nq'|Red Scarf|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 279, '0x0117', nq'|Lagging Tail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 484, '0x01E4', nq'|Mystery Egg|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x4B', nq'|Gold Leaf|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 510, '0x01FE', nq'|Data Card 06|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 47, '0x2F', nq'|Leaf Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 902, '0x0386', nq'|Max Lure|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', nq'|Shed Shell|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 756, '0x02F4', nq'|Galladite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 447, '0x01BF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', nq'|TM17|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 387, '0x0183', nq'|TM60|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', nq'|Favored Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 425, '0x01A9', nq'|HM06|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 240, '0x00F0', nq'|Black Glasses|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 156, '0x009C', nq'|Persim Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 201, '0xC9', nq'|TM01|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', nq'|Stable Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 311, '0x0137', nq'|Draco Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 255, '0x00FF', nq'|Lax Incense|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 192, '0x00C0', nq'|Coba Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 103, '0x67', nq'|なかよしバッヂ (FriendshipBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 904, '0x0388', nq'|Fighting Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 733, '0x02DD', nq'|Key to Room 6|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', nq'|Super Potion|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 586, '0x024A', nq'|Relic Gold|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0xEE', nq'|TM46|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 417, '0x01A1', nq'|TM90|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 59, '0x003B', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 485, '0x01E5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x84', nq'|Star Piece|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', nq'|Power Herb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 217, '0xD9', nq'|TM17|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 786, '0x0312', nq'|Psychium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 92, '0x005C', nq'|Nugget|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 411, '0x019B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 333, '0x014D', nq'|TM45|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 453, '0x01C5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 397, '0x018D', nq'|TM70|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 776, '0x0308', nq'|Normalium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0xD5', nq'|TM22|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 581, '0x0245', nq'|Big Nugget|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 840, '0x0348', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 113, '0x0071', nq'|Tea|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 443, '0x01BB', nq'|Vs. Seeker|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 95, '0x005F', nq'|Growth Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 759, '0x02F7', nq'|Sharpedonite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 565, '0x0235', nq'|Battle CD 32|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 91, '0x005B', nq'|Star Piece|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 688, '0x02B0', nq'|Maranga Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 292, '0x0124', nq'|TM04|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 42, '0x2A', nq'|Helix Fossil|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 156, '0x009C', nq'|Persim Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 641, '0x0281', nq'|Holo Caster|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', nq'|Stable Mulch|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', nq'|Azure Flute|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 767, '0x02FF', nq'|Cameruptite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 127, '0x007F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 117, '0x0075', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 20, '0x14', nq'|Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1044, '0x0414', nq'|Eevee Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', nq'|Super Potion|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 165, '0x00A5', nq'|Watmel Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 165, '0x00A5', nq'|Watmel Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', nq'|Power Herb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 132, '0x0084', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0x00DD', nq'|Lax Incense|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', nq'|DeepSeaTooth|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', nq'|TM29|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0x00F0', nq'|BlackGlasses|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 23, '0x0017', nq'|Full Heal|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 418, '0x01A2', nq'|TM91|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', nq'|Zoom Lens|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 303, '0x012F', nq'|Fist Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 501, '0x01F5', nq'|Photo Album|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 619, '0x026B', nq'|TM94|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 29, '0x1D', nq'|Carbos|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 126, '0x007E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x0D', nq'|Parlyz Heal|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 571, '0x023B', nq'|Pretty Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 344, '0x0158', nq'|TM17|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', nq'|Nanab Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 232, '0x00E8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', nq'|Pinap Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', nq'|TM40|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 547, '0x0223', nq'|Ein File F|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 161, '0x00A1', nq'|Rabuta Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0x00F0', nq'|Black Glasses|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 641, '0x0281', nq'|Holo Caster|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', nq'|Stable Mulch|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 161, '0xA1', nq'|Fast Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', nq'|Azure Flute|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 570, '0x023A', nq'|Swift Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 748, '0x02EC', nq'|Mega Stickpin|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', nq'|Super Potion|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 162, '0x00A2', nq'|Nomel Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 464, '0x01D0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', nq'|Repel|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 330, '0x014A', nq'|TM03|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 472, '0x01D8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 263, '0x0107', nq'|Green Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 284, '0x011C', nq'|Heat Rock|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 78, '0x004E', nq'|X Accuracy|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 498, '0x01F2', nq'|Moon Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 666, '0x029A', nq'|Houndoominite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 451, '0x01C3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 224, '0x00E0', nq'|Thick Club|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 569, '0x0239', nq'|Battle CD 36|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 456, '0x01C8', nq'|S.S. Ticket|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', nq'|Shed Shell|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x24', nq'|Nugget|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x004E', nq'|X Accuracy|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 96, '0x0060', nq'|Damp Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', nq'|Favored Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 124, '0x007C', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 136, '0x0088', nq'|Rawst Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 686, '0x02AE', nq'|Roseli Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 128, '0x0080', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 478, '0x01DE', nq'|Red Scale|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 450, '0x01C2', nq'|Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 19, '0x0013', nq'|Burn Heal|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 518, '0x0206', nq'|Bonsly Photo|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0xBB', nq'|Bluesky Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 347, '0x015B', nq'|TM20|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', nq'|Blue Orb|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x001A', nq'|Super Potion|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', nq'|TM34|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 826, '0x033A', nq'|Decidium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 761, '0x02F9', nq'|Steelixite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 248, '0x00F8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 763, '0x02FB', nq'|Glalitite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', nq'|Power Herb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 51, '0x0033', nq'|PP Up|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 551, '0x0227', nq'|Grass Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', nq'|TM64|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 176, '0x00B0', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 365, '0x016D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 337, '0x0151', nq'|TM49|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', nq'|Zoom Lens|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', nq'|Point Card|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0xF8', nq'|HM06|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 453, '0x01C5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1014, '0x03F6', nq'|Seel Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 553, '0x0229', nq'|Fighting Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 80, '0x0050', nq'|Poké Doll|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 193, '0xC1', nq'|TM03|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 498, '0x01F2', nq'|Moon Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 13, '0x000D', nq'|Dusk Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', nq'|Fluffy Tail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 785, '0x0311', nq'|Flyinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 914, '0x0392', nq'|Grass Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0xC9', nq'|TM10|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 478, '0x01DE', nq'|Red Scale|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 686, '0x02AE', nq'|Roseli Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 575, '0x023F', nq'|Battle CD 42|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', nq'|TM75|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 333, '0x014D', nq'|TM06|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 360, '0x0168', nq'|TM33|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 485, '0x01E5', nq'|Red Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 935, '0x03A7', nq'|Orange Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 297, '0x0129', nq'|TM09|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', nq'|Ice Heal|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 2, '0x0002', nq'|Ultra Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 719, '0x02CF', nq'|Acro Bike|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x9D', nq'|Heavy Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 851, '0x0353', nq'|Beast Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 636, '0x027C', nq'|Dropped Item|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 303, '0x012F', nq'|Fist Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 465, '0x01D1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 517, '0x0205', nq'|Data Card 13|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', nq'|Zoom Lens|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x0073', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 553, '0x0229', nq'|Fighting Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 644, '0x0284', nq'|Pixie Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 336, '0x0150', nq'|TM09|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 170, '0x00AA', nq'|Salac Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 168, '0x00A8', nq'|Pinap Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', nq'|Fluffy Tail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 568, '0x0238', nq'|Genius Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', nq'|Shed Shell|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 38, '0x26', nq'|Carbos|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0xA4', nq'|Friend Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', nq'|Big Mushroom|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 124, '0x007C', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 925, '0x039D', nq'|Lycanium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 251, '0xFB', nq'|TM51|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 269, '0x010D', nq'|Devon Goods|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0x00CE', nq'|BlackGlasses|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 28, '0x001C', nq'|Revive|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 847, '0x034F', nq'|Zygarde Cube|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', nq'|Sky Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 351, '0x015F', nq'|TM24|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 256, '0x0100', nq'|Pink Scarf|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', nq'|Macho Brace|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 376, '0x0178', nq'|TM49|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 910, '0x038E', nq'|Ghost Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 354, '0x0162', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 133, '0x0085', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 281, '0x0119', nq'|Black Sludge|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 219, '0x00DB', nq'|Mental Herb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 271, '0x010F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 702, '0x02BE', nq'|Honor of Kalos|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 559, '0x022F', nq'|Rock Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', nq'|Persim Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 54, '0x0036', nq'|Old Gateau|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x006D', nq'|Star Piece|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', nq'|Full Heal|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 222, '0xDE', nq'|TM30|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 566, '0x0236', nq'|Muscle Wing|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 157, '0x009D', nq'|Grepa Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 553, '0x0229', nq'|Fighting Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 268, '0x010C', nq'|Wailmer Pail|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', nq'|TM62|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x0050', nq'|Poké Doll|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', nq'|Shed Shell|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 445, '0x01BD', nq'|Old Rod|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 353, '0x0161', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 547, '0x0223', nq'|Eject Button|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 21, '0x0015', nq'|Awakening|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 384, '0x0180', nq'|TM57|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 87, '0x0057', nq'|Big Mushroom|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 138, '0x008A', nq'|Favored Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 56, '0x0038', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 138, '0x008A', nq'|Favored Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 299, '0x012B', nq'|TM11|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 478, '0x01DE', nq'|Red Scale|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 431, '0x01AF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 63, '0x003F', nq'|Poké Doll|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 228, '0x00E4', nq'|Smoke Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', nq'|Lucky Egg|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 207, '0x00CF', nq'|Black Belt|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', nq'|Sky Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 989, '0x03DD', nq'|Nidoran♀ Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', nq'|Macho Brace|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 281, '0x0119', nq'|Black Sludge|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 24, '0x0018', nq'|Revive|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0x00D3', nq'|Poison Barb|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 416, '0x01A0', nq'|TM89|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 241, '0x00F1', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 161, '0x00A1', nq'|Mago Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 294, '0x0126', nq'|TM06|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 93, '0x005D', nq'|Heart Scale|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 702, '0x02BE', nq'|Honor of Kalos|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 99, '0x0063', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 26, '0x001A', nq'|Fresh Water|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 75, '0x004B', nq'|Green Shard|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 37, '0x0025', nq'|Max Elixir|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 468, '0x01D4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 617, '0x0269', nq'|Dark Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 303, '0x012F', nq'|Fist Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 556, '0x022C', nq'|Flying Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 521, '0x0209', nq'|Data Card 17|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', nq'|Bright Powder|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 291, '0x0123', nq'|TM03|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 454, '0x01C6', nq'|Member Card|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 231, '0x00E7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', nq'|Full Heal|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x0073', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', nq'|Point Card|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 229, '0x00E5', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 655, '0x028F', nq'|Amaze Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 732, '0x02DC', nq'|Key to Room 4|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 556, '0x022C', nq'|Flying Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 613, '0x0265', nq'|Item Urge|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 302, '0x012E', nq'|Icicle Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 266, '0x010A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', nq'|TM62|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 776, '0x0308', nq'|Normalium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', nq'|Nanab Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 547, '0x0223', nq'|Eject Button|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 53, '0x0035', nq'|PP Max|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 131, '0x0083', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 852, '0x0354', nq'|Big Malasada|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 415, '0x019F', nq'|TM88|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 185, '0x00B9', nq'|Mental Herb|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 473, '0x01D9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 365, '0x016D', nq'|TM38|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 409, '0x0199', nq'|TM82|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 73, '0x0049', nq'|Blue Shard|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 418, '0x01A2', nq'|TM91|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 261, '0x0105', nq'|Blue Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 302, '0x012E', nq'|TM14|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', nq'|Macho Brace|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 187, '0x00BB', nq'|King's Rock|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 659, '0x0293', nq'|Venusaurite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 364, '0x016C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 147, '0x0093', nq'|Iapapa Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 784, '0x0310', nq'|Groundium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 303, '0x012F', nq'|Fist Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 529, '0x0211', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 140, '0x008C', nq'|Persim Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 205, '0x00CD', nq'|Miracle Seed|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x0073', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 119, '0x0077', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 424, '0x01A8', nq'|HM05|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 512, '0x0200', nq'|Cologne Case|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 757, '0x02F5', nq'|Audinite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 81, '0x0051', nq'|Fluffy Tail|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 471, '0x01D7', nq'|Dowsing MCHN|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', nq'|Nanab Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 374, '0x0176', nq'|TM47|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 484, '0x01E4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 407, '0x0197', nq'|TM80|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 553, '0x0229', nq'|Battle CD 20|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 19, '0x13', nq'|Super Potion|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 380, '0x017C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 354, '0x0162', nq'|Old Amber|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 547, '0x0223', nq'|Eject Button|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 846, '0x034E', nq'|Adrenaline Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 121, '0x0079', nq'|Orange Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 308, '0x0134', nq'|TM20|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 755, '0x02F3', nq'|Altarianite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 741, '0x02E5', nq'|Magma Suit|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 426, '0x01AA', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', nq'|Sky Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 824, '0x0338', nq'|Fairium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', nq'|Scope Lens|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 455, '0x01C7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 335, '0x014F', nq'|TM47|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 52, '0x0034', nq'|Zinc|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 161, '0x00A1', nq'|Rabuta Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', nq'|Macho Brace|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 869, '0x0365', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 771, '0x0303', nq'|Meteorite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 292, '0x0124', nq'|TM04|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', nq'|TM36|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 57, '0x0039', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', nq'|Full Heal|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 644, '0x0284', nq'|Pixie Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 509, '0x01FD', nq'|Data Card 05|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 566, '0x0236', nq'|Muscle Wing|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 424, '0x01A8', nq'|HM05|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 687, '0x02AF', nq'|Kee Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 414, '0x019E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 212, '0x00D4', nq'|Rowap Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 389, '0x0185', nq'|TM62|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0x00C3', nq'|Everstone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 737, '0x02E1', nq'|HM07|', q'|TMs and HMs|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 515, '0x0203', nq'|Data Card 11|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0x00A6', nq'|Nanab Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 123, '0x007B', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 37, '0x0025', nq'|Max Elixir|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 397, '0x018D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 539, '0x021B', nq'|Float Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 361, '0x0169', nq'|TM34|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 722, '0x02D2', nq'|Soot Sack|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 149, '0x0095', nq'|Cheri Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x2B', nq'|Max Repel|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 139, '0x008B', nq'|RSVP Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 668, '0x029C', nq'|Banettite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 365, '0x016D', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 340, '0x0154', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 302, '0x012E', nq'|Icicle Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 434, '0x01B2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 335, '0x014F', nq'|TM47|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 338, '0x0152', nq'|TM50|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 155, '0x009B', nq'|Oran Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 436, '0x01B4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 359, '0x0167', nq'|Silph Scope|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', nq'|Bright Powder|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', nq'|Qualot Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 519, '0x0207', nq'|Data Card 15|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 644, '0x0284', nq'|Pixie Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 509, '0x01FD', nq'|Data Card 05|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 432, '0x01B0', nq'|Point Card|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 163, '0x00A3', nq'|Spelon Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 60, '0x3C', nq'|Fresh Water|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 825, '0x0339', nq'|Pikanium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 123, '0x007B', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 239, '0x00EF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', nq'|Repel|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 901, '0x0385', nq'|Super Lure|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 125, '0x007D', nq'|Power-Up Pocket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 90, '0x005A', nq'|Stardust|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0x00D2', nq'|Custap Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 234, '0x00EA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 424, '0x01A8', nq'|HM05|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 668, '0x029C', nq'|Banettite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', nq'|TM65|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 704, '0x02C0', nq'|Strange Souvenir|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 409, '0x0199', nq'|TM82|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', nq'|TM67|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 277, '0x0115', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 198, '0x00C6', nq'|Scope Lens|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 394, '0x018A', nq'|TM67|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', nq'|Damp Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 844, '0x034C', nq'|Festival Ticket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 434, '0x01B2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 89, '0x59', nq'|Blu Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 838, '0x0346', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 133, '0x0085', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 372, '0x0174', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', nq'|TM60|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 659, '0x0293', nq'|Venusaurite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 321, '0x0141', nq'|Protector|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 413, '0x019D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 220, '0x00DC', nq'|Sea Incense|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 278, '0x0116', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 509, '0x01FD', nq'|Data Card 05|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 119, '0x0077', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', nq'|Metronome|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 523, '0x020B', nq'|Krane Memo 1|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 439, '0x01B7', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 123, '0x007B', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 59, '0x3B', nq'|Good Rod|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 58, '0x003A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 511, '0x01FF', nq'|Data Card 07|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 581, '0x0245', nq'|Battle CD 48|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', nq'|Red Orb|', q'|Key items|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 490, '0x01EA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 412, '0x019C', nq'|TM85|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 229, '0x00E5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 80, '0x50', nq'|Ether|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', nq'|Damp Mulch|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 362, '0x016A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 276, '0x0114', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 844, '0x034C', nq'|Festival Ticket|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', nq'|TM67|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 765, '0x02FD', nq'|Prison Bottle|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 189, '0x00BD', nq'|Amulet Coin|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 282, '0x011A', nq'|Icy Rock|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 373, '0x0175', nq'|TM46|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 473, '0x01D9', nq'|Slowpoke Tail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 348, '0x15C', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 471, '0x01D7', nq'|Dowsing Machine|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 281, '0x0119', nq'|Black Sludge|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', nq'|TM60|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 109, '0x6D', nq'|ブロンズ (Bronze - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 112, '0x0070', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 527, '0x020F', nq'|Data Card 23|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 452, '0x01C4', nq'|Oak's Letter|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 566, '0x0236', nq'|Muscle Wing|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', nq'|Qualot Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', nq'|Metronome|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 476, '0x01DC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', nq'|Choice Specs|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 168, '0x00A8', nq'|Pinap Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 378, '0x017A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 102, '0x0066', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 402, '0x0192', nq'|TM75|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 580, '0x0244', nq'|Balm Mushroom|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 442, '0x01BA', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 79, '0x004F', nq'|Repel|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 761, '0x02F9', nq'|Steelixite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 510, '0x01FE', nq'|Miror Radar|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', nq'|Moon Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 186, '0x00BA', nq'|Wacan Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 116, '0x0074', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0x00D6', nq'|White Herb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 246, '0xF6', nq'|HM04|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0x00D2', nq'|Custap Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 463, '0x01CF', nq'|Storage Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 409, '0x0199', nq'|TM82|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 302, '0x012E', nq'|Icicle Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 276, '0x0114', nq'|Zoom Lens|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 277, '0x0115', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 61, '0x003D', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 699, '0x02BB', nq'|Discount Coupon|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 405, '0x0195', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 251, '0x00FB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 856, '0x0358', nq'|Purple Nectar|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 952, '0x03B8', nq'|Roto Exp. Points|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 469, '0x01D5', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', nq'|Lava Cookie|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0xAC', nq'|Up-Grade|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 468, '0x01D4', nq'|Apricorn Box|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 263, '0x0107', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', nq'|TM19|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 387, '0x0183', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 443, '0x01BB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', nq'|Spell Tag|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 316, '0x013C', nq'|TM28|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 913, '0x0391', nq'|Water Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 344, '0x0158', nq'|TM17|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 281, '0x0119', nq'|Black Sludge|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 34, '0x0022', nq'|Ether|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 577, '0x0241', nq'|Poké Toy|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 13, '0x000D', nq'|Potion|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 388, '0x0184', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 348, '0x015C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 290, '0x0122', nq'|Power Belt|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 288, '0x0120', nq'|Sticky Barb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', nq'|Qualot Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 127, '0x007F', nq'|Catching Pocket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', nq'|Metronome|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 458, '0x01CA', nq'|Magma Stone|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 534, '0x0216', nq'|Red Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', nq'|Bluk Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x8B', nq'|Berry Juice|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 213, '0x00D5', nq'|Bright Powder|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 626, '0x0272', nq'|Xtransceiver|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 171, '0x00AB', nq'|Qualot Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 737, '0x02E1', nq'|HM07|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 312, '0x0138', nq'|Dread Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 383, '0x017F', nq'|TM56|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', nq'|Damp Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', nq'|Moon Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 83, '0x0053', nq'|Super Repel|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', nq'|TM65|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0x00D2', nq'|Custap Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0x00D6', nq'|White Herb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 782, '0x030E', nq'|Fightinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 83, '0x0053', nq'|Super Repel|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 345, '0x0159', nq'|TM18|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 22, '0x0016', nq'|Super Potion|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 807, '0x0327', nq'|Normalium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 536, '0x0218', nq'|Enigma Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 630, '0x0276', nq'|Permit|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x23', nq'|Metal Powder|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x09', nq'|Antidote|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 271, '0x010F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 435, '0x01B3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 462, '0x01CE', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 344, '0x0158', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 525, '0x020D', nq'|Krane Memo 3|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 241, '0x00F1', nq'|Black Belt|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 280, '0x0118', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 16, '0x0010', nq'|Cherish Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 190, '0x00BE', nq'|Cleanse Tag|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 527, '0x020F', nq'|Data Card 23|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 680, '0x02A8', nq'|Heracronite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', nq'|Sacred Ash|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 387, '0x0183', nq'|TM60|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 246, '0x00F6', nq'|Never-Melt Ice|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 26, '0x1A', nq'|HP Up|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 170, '0x00AA', nq'|Salac Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', nq'|Metronome|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 184, '0xB8', nq'|Lovely Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 134, '0x0086', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', nq'|HP Up|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 168, '0x00A8', nq'|Pinap Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', nq'|Belue Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 497, '0x01F1', nq'|Friend Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 638, '0x027E', nq'|Reveal Glass|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 431, '0x01AF', nq'|Poké Radar|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', nq'|Choice Specs|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x5B', nq'|Amulet Coin|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 417, '0x01A1', nq'|TM90|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', nq'|TM75|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', nq'|Bluk Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 380, '0x017C', nq'|TM53|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 373, '0x0175', nq'|TM46|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 762, '0x02FA', nq'|Pidgeotite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 357, '0x0165', nq'|TM30|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 719, '0x02CF', nq'|Acro Bike|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 381, '0x017D', nq'|TM54|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 406, '0x0196', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', nq'|TM75|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 907, '0x038B', nq'|Ground Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0x00A3', nq'|Iapapa Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 946, '0x03B2', nq'|N-Lunarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', nq'|Moon Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 302, '0x012E', nq'|Icicle Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 468, '0x01D4', nq'|Apricorn Box|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 394, '0x018A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', nq'|Lava Cookie|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x04', nq'|Great Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 972, '0x03CC', nq'|Health Candy XL|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 794, '0x031A', nq'|Pikanium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 46, '0x002E', nq'|Shoal Salt|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', nq'|TM66|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 635, '0x027B', nq'|Colress Machine|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 406, '0x0196', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', nq'|Potion|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 246, '0x00F6', nq'|Never-Melt Ice|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 527, '0x020F', nq'|Data Card 23|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 577, '0x0241', nq'|Poké Toy|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 631, '0x0277', nq'|Oval Charm|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 348, '0x015C', nq'|TM21|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 638, '0x027E', nq'|Reveal Glass|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 147, '0x0093', nq'|Bridge Mail V|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 168, '0x00A8', nq'|Pinap Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 45, '0x002D', nq'|HP Up|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 39, '0x0027', nq'|Max Ether|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', nq'|Choice Specs|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', nq'|Red Flute|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 574, '0x023E', nq'|Liberty Pass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 863, '0x035F', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 444, '0x01BC', nq'|Coin Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 216, '0xD8', nq'|TM16|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1025, '0x0401', nq'|Hitmonchan Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 115, '0x73', nq'|GS Ball|', q'|Key items|', q'|Crystal|', 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 684, '0x02AC', nq'|Latiasite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 357, '0x0165', nq'|TM30|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 570, '0x023A', nq'|Battle CD 37|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 56, '0x0038', nq'|Dire Hit|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 322, '0x0142', nq'|TM34|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', nq'|U-Disk|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 297, '0x0129', nq'|TM09|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0x00D2', nq'|Custap Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x0051', nq'|Moon Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 609, '0x0261', nq'|X Attack 6|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 486, '0x01E6', nq'|Ylw Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 55, '0x0037', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 60, '0x003C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 572, '0x023C', nq'|Battle CD 39|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x12', nq'|Potion|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', nq'|Lava Cookie|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 461, '0x01CD', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 635, '0x027B', nq'|Colress Machine|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', nq'|Spell Tag|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', nq'|Potion|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', nq'|Oran Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 175, '0x00AF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x006F', nq'|Odd Keystone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 577, '0x0241', nq'|Poké Toy|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 938, '0x03AA', nq'|Green Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', nq'|TM50|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 976, '0x03D0', nq'|Courage Candy XL|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 817, '0x0331', nq'|Psychium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 95, '0x005F', nq'|Fire Stone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 462, '0x01CE', nq'|Coupon 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 22, '0x0016', nq'|Super Potion|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 158, '0x9E', nq'|Flower Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 613, '0x0265', nq'|Item Urge|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 751, '0x02EF', nq'|Meteorite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 94, '0x005E', nq'|Moon Stone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x0096', nq'|Chesto Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 684, '0x02AC', nq'|Latiasite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 417, '0x01A1', nq'|TM90|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 357, '0x0165', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 357, '0x0165', nq'|TM30|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', nq'|Damp Mulch|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 913, '0x0391', nq'|Water Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 392, '0x0188', nq'|TM65|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 238, '0x00EE', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 12, '0x000C', nq'|Premier Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 16, '0x10', nq'|Full Restore|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 706, '0x02C2', nq'|Travel Trunk|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 733, '0x02DD', nq'|Key to Room 6|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 707, '0x02C3', nq'|Travel Trunk|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', nq'|Wise Glasses|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 346, '0x015A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 165, '0x00A5', nq'|Bluk Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 660, '0x0294', nq'|Charizardite X|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 554, '0x022A', nq'|Battle CD 21|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', nq'|Heat Rock|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 954, '0x03BA', nq'|Roto Encounter|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', nq'|Potion|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 377, '0x0179', nq'|TM50|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 827, '0x033B', nq'|Incinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 29, '0x001D', nq'|Moomoo Milk|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 543, '0x021F', nq'|Joy Scent|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 870, '0x0366', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', nq'|Everstone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0xA5', nq'|Moon Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', nq'|Red Flute|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 398, '0x018E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 417, '0x01A1', nq'|TM90|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 402, '0x0192', nq'|TM75|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 606, '0x025E', nq'|X Sp. Atk 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 390, '0x0186', nq'|TM63|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', nq'|Old Charm|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 311, '0x0137', nq'|TM23|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 550, '0x0226', nq'|Electric Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 707, '0x02C3', nq'|Travel Trunk|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', nq'|Lava Cookie|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 328, '0x0148', nq'|TM40|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 711, '0x02C7', nq'|Sail Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 467, '0x01D3', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 294, '0x0126', nq'|Power Weight|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', nq'|TM03|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 382, '0x017E', nq'|TM55|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x006F', nq'|Odd Keystone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 714, '0x02CA', nq'|Holo Caster|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', nq'|Everstone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 39, '0x0027', nq'|Max Ether|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 86, '0x0056', nq'|Tiny Mushroom|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1057, '0x0421', nq'|Magmar Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 613, '0x0265', nq'|Item Urge|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 419, '0x01A3', nq'|TM92|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 502, '0x01F6', nq'|GB Sounds|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 614, '0x0266', nq'|Reset Urge|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', nq'|Dusk Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 488, '0x01E8', nq'|Grn Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', nq'|Magost Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 97, '0x61', nq'|B4F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 301, '0x012D', nq'|Meadow Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 301, '0x012D', nq'|TM13|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 923, '0x039B', nq'|Ultranecrozium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 479, '0x01DF', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 6, '0x0006', nq'|Net Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 550, '0x0226', nq'|Electric Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', nq'|Wise Glasses|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 983, '0x03D7', nq'|Pidgey Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 282, '0x011A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', nq'|TM36|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', nq'|Tiny Mushroom|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 511, '0x01FF', nq'|Data Card 07|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x0031', nq'|Blue Shard|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 469, '0x01D5', nq'|Unown Report|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 292, '0x0124', nq'|TM04|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 299, '0x012B', nq'|Splash Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', nq'|TM04|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 469, '0x01D5', nq'|Unown Report|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0x00AB', nq'|Qualot Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 470, '0x01D6', nq'|Berry Pots|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 363, '0x016B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 521, '0x0209', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 463, '0x01CF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', nq'|Everstone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 584, '0x0248', nq'|Battle CD 51|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 862, '0x035E', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 869, '0x0365', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', nq'|Bluk Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 614, '0x0266', nq'|Reset Urge|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 230, '0x00E6', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 745, '0x02E9', nq'|Mega Pendant|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 739, '0x02E3', nq'|Contest Costume|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 653, '0x028D', nq'|Surprise Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 540, '0x021C', nq'|Battle CD 07|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 875, '0x036B', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 714, '0x02CA', nq'|Holo Caster|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 433, '0x01B1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 550, '0x0226', nq'|Electric Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 126, '0x007E', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0xA9', nq'|Sun Stone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 109, '0x6D', nq'|MiracleBerry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 452, '0x01C4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', nq'|TM36|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 394, '0x018A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 155, '0x009B', nq'|Qualot Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 136, '0x0088', nq'|Rawst Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 126, '0x007E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 103, '0x0067', nq'|TinyMushroom|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 459, '0x01CB', nq'|Parcel|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 522, '0x020A', nq'|Data Card 18|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0xBA', nq'|Morph Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 770, '0x0302', nq'|Beedrillite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 279, '0x0117', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', nq'|TM59|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 40, '0x0028', nq'|Yellow Flute|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 229, '0x00E5', nq'|Everstone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 165, '0x00A5', nq'|Bluk Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 24, '0x18', nq'|RainbowBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 364, '0x016C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 277, '0x0115', nq'|Blue Orb|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 367, '0x016F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0x00E8', nq'|Scope Lens|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 401, '0x0191', nq'|TM74|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 469, '0x01D5', nq'|Unown Report|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0x00D1', nq'|Mystic Water|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 496, '0x01F0', nq'|Love Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 59, '0x3B', nq'|Coin|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x16', nq'|Fire Stone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', nq'|TinyMushroom|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0x00D6', nq'|White Herb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 639, '0x027F', nq'|Weakness Policy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 33, '0x0021', nq'|Revival Herb|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 630, '0x0276', nq'|Permit|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 394, '0x018A', nq'|TM67|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 180, '0x00B4', nq'|White Herb|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 174, '0x00AE', nq'|Starf Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 466, '0x01D2', nq'|Gracidea|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 70, '0x0046', nq'|Zinc|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x006F', nq'|Odd Keystone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 33, '0x0021', nq'|Revival Herb|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 716, '0x02CC', nq'|Mega Charm|', q'|Key items|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 180, '0x00B4', nq'|White Herb|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 855, '0x0357', nq'|Pink Nectar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 273, '0x0111', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 86, '0x56', nq'|1F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', nq'|TM59|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 348, '0x015C', nq'|TM21|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 41, '0x0029', nq'|Max Elixir|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 470, '0x01D6', nq'|Berry Pots|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 556, '0x022C', nq'|Flying Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 391, '0x0187', nq'|TM64|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0x00E8', nq'|Scope Lens|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 427, '0x01AB', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 431, '0x01AF', nq'|Poké Radar|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0x00F0', nq'|BlackGlasses|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 582, '0x0246', nq'|Pearl String|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0xC5', nq'|TM06|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 237, '0x00ED', nq'|Soft Sand|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 789, '0x0315', nq'|Ghostium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 614, '0x0266', nq'|Reset Urge|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0xA3', nq'|Light Ball|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 13, '0x000D', nq'|Dusk Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 382, '0x017E', nq'|TM55|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 238, '0x00EE', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', nq'|TM79|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 66, '0x0042', nq'|Carbos|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', nq'|Red Orb|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 578, '0x0242', nq'|Prop Case|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 453, '0x01C5', nq'|Lunar Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 87, '0x0057', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', nq'|TinyMushroom|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0x00D6', nq'|White Herb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 589, '0x024D', nq'|Relic Statue|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 363, '0x016B', nq'|TM36|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 531, '0x0213', nq'|Steel Teeth|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 828, '0x033C', nq'|Primarium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', nq'|Star Piece|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', nq'|TM19|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 211, '0x00D3', nq'|Poison Barb|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', nq'|Heat Rock|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 183, '0x00B7', nq'|Belue Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 366, '0x016E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 536, '0x0218', nq'|Enigma Stone|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 158, '0x009E', nq'|Sitrus Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 485, '0x01E5', nq'|Red Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 493, '0x01ED', nq'|Level Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 469, '0x01D5', nq'|Unown Report|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 416, '0x01A0', nq'|TM89|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 193, '0x00C1', nq'|DeepSeaScale|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 680, '0x02A8', nq'|Heracronite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', nq'|Potion|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 153, '0x0099', nq'|Pomeg Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( GAME, GEN )
values( q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 857, '0x0359', nq'|Sun Flute|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 468, '0x01D4', nq'|Apricorn Box|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 55, '0x37', nq'|Itemfinder|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 168, '0x00A8', nq'|Liechi Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 348, '0x015C', nq'|TM21|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 470, '0x01D6', nq'|Berry Pots|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 556, '0x022C', nq'|Flying Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 479, '0x01DF', nq'|Lost Item|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 290, '0x0122', nq'|TM02|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 520, '0x0208', nq'|Data Card 16|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 189, '0x00BD', nq'|Chople Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 272, '0x0110', nq'|Toxic Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 744, '0x02E8', nq'|Mega Bracelet|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 759, '0x02F7', nq'|Sharpedonite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 592, '0x0250', nq'|Dire Hit 2|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', nq'|Smooth Rock|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 70, '0x0046', nq'|Zinc|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', nq'|Shock Drive|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 382, '0x017E', nq'|TM55|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 380, '0x017C', nq'|TM53|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 227, '0x00E3', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', nq'|Old Charm|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 368, '0x0170', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x0E', nq'|Full Restore|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 638, '0x027E', nq'|Reveal Glass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 332, '0x014C', nq'|TM44|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 589, '0x024D', nq'|Relic Statue|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 364, '0x016C', nq'|TM37|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', nq'|Star Piece|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x0067', nq'|Old Amber|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', nq'|TM19|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 188, '0x00BC', nq'|Yache Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', nq'|Heat Rock|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 916, '0x0394', nq'|Psychic Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 536, '0x0218', nq'|Enigma Stone|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x0094', nq'|Brick Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 680, '0x02A8', nq'|Heracronite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x006F', nq'|Odd Keystone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 665, '0x0299', nq'|Medichamite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x97', nq'|Dragon Scale|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', nq'|Zap Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x9B', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 131, '0x0083', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 375, '0x0177', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 408, '0x0198', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 121, '0x0079', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 729, '0x02D9', nq'|Meteorite|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 674, '0x02A2', nq'|Abomasite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 75, '0x004B', nq'|X Attack|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 367, '0x016F', nq'|Tri-Pass|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 306, '0x0132', nq'|TM18|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 508, '0x01FC', nq'|Data Card 04|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1022, '0x03FE', nq'|Exeggcute Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', nq'|Smooth Rock|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 734, '0x02DE', nq'|Storage Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0x00E3', nq'|Deep Sea Scale|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 208, '0x00D0', nq'|Magnet|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', nq'|Smooth Rock|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 117, '0x0075', nq'|Shock Drive|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', nq'|TM79|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 117, '0x0075', nq'|Shock Drive|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 86, '0x0056', nq'|Tiny Mushroom|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', nq'|Star Piece|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', nq'|Wise Glasses|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', nq'|Suite Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 364, '0x016C', nq'|TM37|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 520, '0x0208', nq'|Data Card 16|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 329, '0x0149', nq'|TM41|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', nq'|Grn ID Badge|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 506, '0x01FA', nq'|ID Card|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 284, '0x011C', nq'|Heat Rock|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 238, '0x00EE', nq'|Hard Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 331, '0x014B', nq'|TM43|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 128, '0x0080', nq'|Shadow Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', nq'|Rose Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 665, '0x0299', nq'|Medichamite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0xB0', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 669, '0x029D', nq'|Tyranitarite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 282, '0x011A', nq'|Icy Rock|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 125, '0x007D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 115, '0x0073', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', nq'|Quick Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 765, '0x02FD', nq'|Prison Bottle|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 427, '0x01AB', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 492, '0x01EC', nq'|Fast Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0x00B5', nq'|Macho Brace|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', nq'|Bubble Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 72, '0x0048', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 692, '0x02B4', nq'|TM98|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 508, '0x01FC', nq'|Data Card 04|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 926, '0x039E', nq'|Kommonium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 275, '0x0113', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1053, '0x041D', nq'|Dratini Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 686, '0x02AE', nq'|Roseli Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 397, '0x018D', nq'|TM70|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', nq'|Sharp Beak|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', nq'|Wide Lens|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 576, '0x0240', nq'|Dream Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 382, '0x017E', nq'|TM55|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 359, '0x0167', nq'|TM32|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 286, '0x011E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 270, '0x010E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 541, '0x021D', nq'|Ein File P|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 128, '0x0080', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 589, '0x024D', nq'|Relic Statue|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 283, '0x011B', nq'|Smooth Rock|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 821, '0x0335', nq'|Dragonium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 91, '0x005B', nq'|Star Piece|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', nq'|Lum Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 829, '0x033D', nq'|Tapunium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 624, '0x0270', nq'|Gram 2|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 260, '0x0104', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', nq'|Heal Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 77, '0x4D', nq'|Good Rod|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 255, '0xFF', nq'|Cancel|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 471, '0x01D7', nq'|Dowsing Machine|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 46, '0x2E', nq'|X Accuracy|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 905, '0x0389', nq'|Flying Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 409, '0x0199', nq'|TM82|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', nq'|TM05|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 714, '0x02CA', nq'|Holo Caster|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 864, '0x0360', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 229, '0x00E5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 318, '0x013E', nq'|Rose Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 346, '0x015A', nq'|TM19|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 716, '0x02CC', nq'|Mega Charm|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', nq'|Energy Powder|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 811, '0x032B', nq'|Grassium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 503, '0x01F7', nq'|Tidal Bell|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 71, '0x0047', nq'|Shoal Shell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 73, '0x0049', nq'|Blue Shard|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 92, '0x005C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 987, '0x03DB', nq'|Pikachu Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 191, '0x00BF', nq'|Soul Dew|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 228, '0xE4', nq'|TM36|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 107, '0x006B', nq'|Big Pearl|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 788, '0x0314', nq'|Rockium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', nq'|Mental Herb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 353, '0x0161', nq'|TM26|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 683, '0x02AB', nq'|Garchompite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', nq'|Wide Lens|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', nq'|Poffin Case|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 11, '0x000B', nq'|Luxury Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 496, '0x01F0', nq'|Love Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 128, '0x0080', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 35, '0x0023', nq'|Energy Root|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', nq'|Lum Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 638, '0x027E', nq'|Reveal Glass|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 541, '0x021D', nq'|Air Balloon|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 624, '0x0270', nq'|Gram 2|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 130, '0x0082', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 515, '0x0203', nq'|Data Card 11|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 685, '0x02AD', nq'|Latiosite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 805, '0x0325', nq'|Eevium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 304, '0x0130', nq'|Toxic Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 385, '0x0181', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', nq'|Soul Dew|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 249, '0x00F9', nq'|Charcoal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 211, '0xD3', nq'|TM20|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', nq'|HM02|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 252, '0x00FC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 780, '0x030C', nq'|Grassium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 0, '0x00', nq'|Nothing|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 50, '0x0032', nq'|Yellow Shard|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 816, '0x0330', nq'|Flyinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0x00E8', nq'|Scope Lens|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 290, '0x0122', nq'|TM02|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 437, '0x01B5', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', nq'|Wide Lens|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', nq'|Itemfinder|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', nq'|Mental Herb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0x00EE', nq'|Hard Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 762, '0x02FA', nq'|Pidgeotite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', nq'|Poffin Case|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', nq'|Rock Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', nq'|Pal Pad|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 350, '0x015E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1003, '0x03EB', nq'|Poliwag Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 530, '0x0212', nq'|Data Card 26|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0x00E3', nq'|Deep Sea Scale|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 736, '0x02E0', nq'|S.S. Ticket|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x006E', nq'|Oval Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 178, '0x00B2', nq'|Nomel Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 624, '0x0270', nq'|Gram 2|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 428, '0x01AC', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 39, '0x27', nq'|Calcium|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 65, '0x0041', nq'|Blue Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x5F', nq'|Mystic Water|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', nq'|TM42|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 717, '0x02CD', nq'|Mega Glove|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 314, '0x013A', nq'|TM26|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', nq'|Aspear Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 71, '0x0047', nq'|PP Max|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 450, '0x01C2', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 42, '0x002A', nq'|Black Flute|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 211, '0x00D3', nq'|Poison Barb|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 764, '0x02FC', nq'|Diancite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x0026', nq'|Lava Cookie|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 493, '0x01ED', nq'|Level Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 331, '0x014B', nq'|TM43|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', nq'|Mystic Water|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 503, '0x01F7', nq'|Tidal Bell|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 943, '0x03AF', nq'|N-Solarizer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 278, '0x0116', nq'|Scanner|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 357, '0x0165', nq'|TM30|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', nq'|Claw Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 814, '0x032E', nq'|Poisonium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', nq'|Galactic Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 361, '0x0169', nq'|Town Map|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 327, '0x0147', nq'|TM39|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0x00E8', nq'|Scope Lens|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 206, '0xCE', nq'|TM06|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 484, '0x01E4', nq'|Mystery Egg|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 482, '0x01E2', nq'|Silver Wing|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', nq'|Wide Lens|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 592, '0x0250', nq'|Dire Hit 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0x00EE', nq'|Hard Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 3, '0x0003', nq'|Great Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 745, '0x02E9', nq'|Mega Pendant|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 244, '0x00F4', nq'|Sharp Beak|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', nq'|Rock Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', nq'|Pal Pad|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', nq'|TM19|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 227, '0x00E3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 495, '0x01EF', nq'|Heavy Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', nq'|Lum Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 234, '0xEA', nq'|TM34|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', nq'|Razor Fang|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 546, '0x0222', nq'|Cell Battery|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 695, '0x02B7', nq'|Power Plant Pass|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 22, '0x16', nq'|CascadeBadge|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 164, '0x00A4', nq'|Pamtre Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 815, '0x032F', nq'|Groundium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', nq'|Up-Grade|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 417, '0x01A1', nq'|TM90|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 63, '0x003F', nq'|HP Up|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 717, '0x02CD', nq'|Mega Glove|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', nq'|Spell Tag|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 228, '0xE4', nq'|TM28|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 288, '0x0120', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 84, '0x0054', nq'|Water Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', nq'|Luck Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 2, '0x0002', nq'|Ultra Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 330, '0x014A', nq'|TM03|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 94, '0x005E', nq'|Moon Stone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 34, '0x0022', nq'|Energy Powder|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0x00FE', nq'|Red Scarf|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', nq'|Mystic Water|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 169, '0x00A9', nq'|Pomeg Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', nq'|Claw Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 309, '0x0135', nq'|Stone Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 361, '0x0169', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 83, '0x0053', nq'|Super Repel|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', nq'|RSVP Mail|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 944, '0x03B0', nq'|N-Lunarizer|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 482, '0x01E2', nq'|Silver Wing|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 218, '0x00DA', nq'|Soothe Bell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 501, '0x01F5', nq'|Photo Album|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 502, '0x01F6', nq'|GB Sounds|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', nq'|TM29|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 775, '0x0307', nq'|Eon Flute|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', nq'|Rock Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', nq'|Pal Pad|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 493, '0x01ED', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 822, '0x0336', nq'|Darkinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', nq'|Old Charm|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 567, '0x0237', nq'|Battle CD 34|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 475, '0x01DB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 98, '0x0062', nq'|Gooey Mulch|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 309, '0x0135', nq'|TM21|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 371, '0x0173', nq'|TM44|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', nq'|Razor Fang|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 370, '0x0172', nq'|TM43|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 962, '0x03C2', nq'|Tough Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 151, '0x0097', nq'|Wepear Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 80, '0x0050', nq'|Sun Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', nq'|Suite Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 695, '0x02B7', nq'|Power Plant Pass|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', nq'|Cherish Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 358, '0x0166', nq'|TM31|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 355, '0x0163', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 810, '0x032A', nq'|Electrium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 536, '0x0218', nq'|Enigma Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 388, '0x0184', nq'|TM61|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 485, '0x01E5', nq'|Red Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', nq'|Aspear Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 586, '0x024A', nq'|Battle CD 53|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 62, '0x3E', nq'|PP Up|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 426, '0x01AA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', nq'|Luck Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 630, '0x0276', nq'|Permit|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 731, '0x02DB', nq'|Key to Room 2|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 459, '0x01CB', nq'|Parcel|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 243, '0x00F3', nq'|Mystic Water|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 841, '0x0349', nq'|Forage Bag|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 204, '0x00CC', nq'|Hard Stone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 121, '0x0079', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 58, '0x003A', nq'|X Defense|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 170, '0x00AA', nq'|Kelpsy Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 350, '0x015E', nq'|TM23|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 267, '0x010B', nq'|Wise Glasses|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 265, '0x0109', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 750, '0x02EE', nq'|Mega Anklet|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 227, '0xE3', nq'|TM35|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 756, '0x02F4', nq'|Galladite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', nq'|RSVP Mail|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 797, '0x031D', nq'|Z-Ring|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 39, '0x0027', nq'|Max Ether|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 245, '0x00F5', nq'|Poison Barb|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 817, '0x0331', nq'|Psychium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 592, '0x0250', nq'|Dire Hit 2|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 33, '0x0021', nq'|Moomoo Milk|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 137, '0x0089', nq'|Greet Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 15, '0x0F', nq'|Parlyz Heal|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 482, '0x01E2', nq'|Silver Wing|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 502, '0x01F6', nq'|GB Sounds|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 252, '0xFC', nq'|TM52|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 219, '0x00DB', nq'|Shell Bell|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 122, '0x007A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 360, '0x0168', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', nq'|Magost Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 300, '0x012C', nq'|Zap Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 991, '0x03DF', nq'|Clefairy Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 494, '0x01EE', nq'|Lure Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 437, '0x01B5', nq'|Pal Pad|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x6E', nq'|Pearl|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 699, '0x02BB', nq'|Discount Coupon|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', nq'|Razor Fang|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', nq'|Suite Key|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 527, '0x020F', nq'|Data Card 23|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 239, '0x00EF', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 295, '0x0127', nq'|Shed Shell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 250, '0x00FA', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 124, '0x007C', nq'|Mech Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 322, '0x0142', nq'|TM34|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 218, '0x00DA', nq'|Up-Grade|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 16, '0x0010', nq'|Cherish Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 783, '0x030F', nq'|Poisonium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 115, '0x0073', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 408, '0x0198', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', nq'|Luck Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 754, '0x02F2', nq'|Sablenite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 818, '0x0332', nq'|Buginium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 386, '0x0182', nq'|TM59|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 150, '0x0096', nq'|Nanab Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', nq'|Light Ball|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 887, '0x0377', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 564, '0x0234', nq'|Battle CD 31|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 723, '0x02D3', nq'|Basement Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', nq'|TM66|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 797, '0x031D', nq'|Z-Ring|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 617, '0x0269', nq'|Dark Stone|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 503, '0x01F7', nq'|Tidal Bell|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 473, '0x01D9', nq'|Slowpoke Tail|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 287, '0x011F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', nq'|BridgeMail V|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 255, '0xFF', nq'|TM55|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', nq'|Rabuta Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 313, '0x0139', nq'|TM25|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 432, '0x01B0', nq'|Point Card|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 704, '0x02C0', nq'|Strange Souvenir|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 139, '0x008B', nq'|RSVP Mail|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 206, '0xCE', nq'|TM15|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 245, '0x00F5', nq'|Poison Barb|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 151, '0x0097', nq'|Wepear Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 243, '0x00F3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 477, '0x01DD', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 315, '0x013B', nq'|TM27|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', nq'|PP Max|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 752, '0x02F0', nq'|Swampertite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 436, '0x01B4', nq'|Seal Bag|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0x00E1', nq'|Stick|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', nq'|TM29|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 359, '0x0167', nq'|TM32|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 415, '0x019F', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 57, '0x39', nq'|Max Repel|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 743, '0x02E7', nq'|Pair of Tickets|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', nq'|Armor Fossil|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 451, '0x01C3', nq'|Suite Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 526, '0x020E', nq'|Data Card 22|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', nq'|Lum Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 148, '0x0094', nq'|Razz Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 349, '0x015D', nq'|TM22|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 423, '0x01A7', nq'|HM04|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', nq'|Dubious Disc|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 247, '0x00F7', nq'|Spell Tag|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 576, '0x0240', nq'|Battle CD 43|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 319, '0x013F', nq'|Luck Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 459, '0x01CB', nq'|Parcel|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 802, '0x0322', nq'|Marshadium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 455, '0x01C7', nq'|Azure Flute|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 717, '0x02CD', nq'|Mega Glove|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1033, '0x0409', nq'|Goldeen Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 229, '0x00E5', nq'|Everstone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 157, '0x009D', nq'|Grepa Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 588, '0x024C', nq'|Relic Band|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', nq'|TM66|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 252, '0x00FC', nq'|Up-Grade|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 60, '0x003C', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 164, '0x00A4', nq'|Pamtre Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', nq'|Quick Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 21, '0x0015', nq'|Hyper Potion|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 222, '0x00DE', nq'|Lucky Punch|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 303, '0x012F', nq'|Fist Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 836, '0x0344', nq'|Pikashunium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 560, '0x0230', nq'|Battle CD 27|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 594, '0x0252', nq'|X Sp. Atk 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', nq'|Yache Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 250, '0xFA', nq'|TM50|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 520, '0x0208', nq'|Data Card 16|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', nq'|Rabuta Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 333, '0x014D', nq'|TM06|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 309, '0x0135', nq'|TM21|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 384, '0x0180', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 144, '0x0090', nq'|Bridge Mail S|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 501, '0x01F5', nq'|Photo Album|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 320, '0x0140', nq'|Pure Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 303, '0x012F', nq'|TM15|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', nq'|Magost Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x1B', nq'|Protein|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 767, '0x02FF', nq'|Cameruptite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 356, '0x0164', nq'|TM29|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 121, '0x0079', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 285, '0x011D', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 439, '0x01B7', nq'|Old Charm|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', nq'|Energy Root|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 771, '0x0303', nq'|Meteorite|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 21, '0x0015', nq'|Hyper Potion|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 423, '0x01A7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 495, '0x01EF', nq'|Heavy Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 370, '0x0172', nq'|TM43|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 22, '0x0016', nq'|Super Potion|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', nq'|Yache Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 812, '0x032C', nq'|Icium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 459, '0x01CB', nq'|Parcel|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 617, '0x0269', nq'|Dark Stone|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 620, '0x026C', nq'|TM95|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 186, '0x00BA', nq'|Choice Band|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', nq'|Blue Flute|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 287, '0x011F', nq'|Choice Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 393, '0x0189', nq'|TM66|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 382, '0x017E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 231, '0xE7', nq'|TM31|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 485, '0x01E5', nq'|Red Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 270, '0x010E', nq'|Life Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 150, '0x0096', nq'|Nanab Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 264, '0x0108', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', nq'|Protein|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 489, '0x01E9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', nq'|TM79|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 114, '0x72', nq'|プチマスター (Petit Master - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 709, '0x02C5', nq'|Shalour Sable|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 520, '0x0208', nq'|Data Card 16|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0x00EE', nq'|Hard Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', nq'|Rabuta Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 502, '0x01F6', nq'|GB Sounds|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', nq'|Galactic Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 405, '0x0195', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 39, '0x0027', nq'|Max Ether|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 139, '0x008B', nq'|Oran Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 240, '0xF0', nq'|TM48|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 328, '0x0148', nq'|TM40|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 471, '0x01D7', nq'|Dowsing Machine|', q'|Key items|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', nq'|Kebia Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', nq'|PP Max|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 896, '0x0380', nq'|Small Bouquet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 64, '0x0040', nq'|Protein|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 385, '0x0181', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 8, '0x0008', nq'|Nest Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 408, '0x0198', nq'|TM81|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 259, '0x0103', nq'|Mach Bike|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 343, '0x0157', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 176, '0x00B0', nq'|Magost Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', nq'|Chesto Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 423, '0x01A7', nq'|HM04|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 548, '0x0224', nq'|Fire Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', nq'|Berry Juice|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 541, '0x021D', nq'|Battle CD 08|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 699, '0x02BB', nq'|Discount Coupon|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', nq'|Energy Root|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 307, '0x0133', nq'|TM19|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x006E', nq'|Oval Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 320, '0x0140', nq'|TM32|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 200, '0x00C8', nq'|Chilan Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', nq'|Heal Powder|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', nq'|Yache Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1024, '0x0400', nq'|Hitmonlee Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 407, '0x0197', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 948, '0x03B4', nq'|Left Poké Ball|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 597, '0x0255', nq'|X Attack 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 284, '0x011C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 183, '0x00B7', nq'|Quick Claw|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 45, '0x2D', nq'|Bike Voucher|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0x00B4', nq'|White Herb|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 405, '0x0195', nq'|TM78|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 18, '0x0012', nq'|Antidote|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 709, '0x02C5', nq'|Shalour Sable|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 663, '0x0297', nq'|Mewtwonite Y|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 457, '0x01C9', nq'|Contest Pass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 127, '0x007F', nq'|Bead Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', nq'|Protein|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', nq'|Figy Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 517, '0x0205', nq'|Data Card 13|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 238, '0x00EE', nq'|Hard Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', nq'|Galactic Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x0011', nq'|Awakening|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 233, '0x00E9', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x0018', nq'|Max Potion|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 177, '0x00B1', nq'|Rabuta Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', nq'|Spelon Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', nq'|Kebia Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 397, '0x018D', nq'|TM70|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 769, '0x0301', nq'|Salamencite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', nq'|X Accuracy|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 981, '0x03D5', nq'|Caterpie Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 228, '0x00E4', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 861, '0x035D', nq'|Silver Razz Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 535, '0x0217', nq'|Battle CD 02|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', nq'|Shoal Shell|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 423, '0x01A7', nq'|HM04|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 29, '0x001D', nq'|Max Revive|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 380, '0x017C', nq'|TM53|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x4C', nq'|Soft Sand|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 704, '0x02C0', nq'|Strange Souvenir|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', nq'|Berry Juice|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 941, '0x03AD', nq'|Rainbow Flower|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0xE2', nq'|TM34|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', nq'|Rawst Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x006E', nq'|Oval Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 424, '0x01A8', nq'|HM05|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', nq'|Yellow Flute|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 124, '0x007C', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', nq'|Dubious Disc|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 182, '0x00B6', nq'|Exp. Share|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', nq'|Toxic Plate|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', nq'|Heal Powder|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 196, '0x00C4', nq'|Focus Band|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 177, '0x00B1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 731, '0x02DB', nq'|Key to Room 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 371, '0x0173', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 516, '0x0204', nq'|Data Card 12|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 690, '0x02B2', nq'|TM96|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 229, '0xE5', nq'|TM29|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 429, '0x01AD', nq'|Loot Sack|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 605, '0x025D', nq'|X Speed 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 936, '0x03A8', nq'|Blue Petal|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 50, '0x32', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 360, '0x0168', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 220, '0xDC', nq'|TM28|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 545, '0x0221', nq'|Battle CD 12|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 690, '0x02B2', nq'|TM96|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', nq'|TM80|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 350, '0x015E', nq'|TM23|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 517, '0x0205', nq'|Data Card 13|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 356, '0x0164', nq'|Lift Key|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 497, '0x01F1', nq'|Friend Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', nq'|Wacan Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 23, '0x0017', nq'|Full Heal|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 113, '0x0071', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', nq'|Figy Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x0018', nq'|Max Potion|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', nq'|Kebia Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', nq'|Spelon Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 112, '0x70', nq'|Everstone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 40, '0x28', nq'|Rare Candy|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 391, '0x0187', nq'|TM64|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 276, '0x0114', nq'|Red Orb|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', nq'|Claw Fossil|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 465, '0x01D1', nq'|Vs. Recorder|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 423, '0x01A7', nq'|HM04|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 557, '0x022D', nq'|Psychic Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 280, '0x0118', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 101, '0x65', nq'|はやぶさバッヂ (FalconBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 135, '0x0087', nq'|Pecha Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 167, '0x00A7', nq'|Belue Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 295, '0x0127', nq'|TM07|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 711, '0x02C7', nq'|Sail Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 359, '0x0167', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 356, '0x0164', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 562, '0x0232', nq'|Battle CD 29|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 532, '0x0214', nq'|Voice Case 5|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 93, '0x005D', nq'|Sun Stone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 419, '0x01A3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', nq'|Toxic Plate|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 684, '0x02AC', nq'|Latiasite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', nq'|Heal Powder|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 370, '0x0172', nq'|TM43|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 166, '0xA6', nq'|Love Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 702, '0x02BE', nq'|Honor of Kalos|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 357, '0x0165', nq'|Helix Fossil|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 188, '0x00BC', nq'|Yache Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 234, '0x00EA', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x41', nq'|Elixer|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 450, '0x01C2', nq'|Bike|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0xBE', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', nq'|Soda Pop|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 350, '0x015E', nq'|TM23|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', nq'|TM80|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 406, '0x0196', nq'|TM79|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 781, '0x030D', nq'|Icium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 70, '0x46', nq'|Oak's Parcel|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', nq'|Figy Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x0018', nq'|Max Potion|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 190, '0x00BE', nq'|Kebia Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', nq'|Lax Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1051, '0x041B', nq'|Zapdos Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 126, '0x007E', nq'|Wave Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 348, '0x015C', nq'|TM21|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 774, '0x0306', nq'|Meteorite Shard|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 8, '0x08', nq'|Moon Stone|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 110, '0x006E', nq'|Oval Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 156, '0x009C', nq'|Hondew Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 380, '0x017C', nq'|TM53|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', nq'|Rawst Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 359, '0x0167', nq'|TM32|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 711, '0x02C7', nq'|Sail Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x0067', nq'|Old Amber|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 101, '0x0065', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 66, '0x0042', nq'|Yellow Flute|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 148, '0x0094', nq'|Bridge Mail M|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 230, '0x00E6', nq'|Focus Band|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 414, '0x019E', nq'|TM87|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 36, '0x0024', nq'|Heal Powder|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', nq'|Dubious Disc|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 813, '0x032D', nq'|Fightinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', nq'|Blue Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 948, '0x03B4', nq'|Left Poké Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 211, '0xD3', nq'|TM11|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x3F', nq'|Ether|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 94, '0x005E', nq'|Honey|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 516, '0x0204', nq'|Sun Shard|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 946, '0x03B2', nq'|N-Lunarizer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 881, '0x0371', nq'|Electric Seed|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', nq'|Soda Pop|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 279, '0x0117', nq'|Go-Goggles|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', nq'|Full Restore|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 81, '0x51', nq'|Max Ether|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 140, '0x008C', nq'|Thanks Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 829, '0x033D', nq'|Tapunium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 3, '0x0003', nq'|Great Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 194, '0x00C2', nq'|Tanga Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', nq'|Shuca Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', nq'|Lax Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', nq'|Douse Drive|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 119, '0x0077', nq'|Chill Drive|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 49, '0x0031', nq'|Blue Shard|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', nq'|X Accuracy|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 354, '0x0162', nq'|TM27|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', nq'|Shoal Shell|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 608, '0x0260', nq'|X Defense 6|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', nq'|Ganlon Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 364, '0x016C', nq'|TM37|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 281, '0x0119', nq'|Black Sludge|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x0067', nq'|Old Amber|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 324, '0x0144', nq'|Dubious Disc|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', nq'|Toxic Plate|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 693, '0x02B5', nq'|TM99|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 497, '0x01F1', nq'|Friend Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 210, '0xD2', nq'|TM19|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 471, '0x01D7', nq'|Dowsing MCHN|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 150, '0x0096', nq'|Chesto Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 287, '0x011F', nq'|Choice Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 532, '0x0214', nq'|Jade Orb|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 883, '0x0373', nq'|Misty Seed|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 51, '0x0033', nq'|Green Shard|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', nq'|Soda Pop|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', nq'|Full Restore|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 221, '0x00DD', nq'|Lax Incense|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0x00CF', nq'|Starf Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 302, '0x012E', nq'|TM14|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0xCA', nq'|TM11|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', nq'|Douse Drive|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 119, '0x0077', nq'|Chill Drive|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', nq'|Shuca Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', nq'|Lax Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x004F', nq'|X Special|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0xC2', nq'|TM04|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', nq'|Bridge Mail V|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', nq'|PP Max|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 382, '0x017E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 182, '0xB6', nq'|Litebluemail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 608, '0x0260', nq'|X Defense 6|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 74, '0x004A', nq'|Yellow Shard|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 487, '0x01E7', nq'|Yellow Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 334, '0x014E', nq'|TM46|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', nq'|Ganlon Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 53, '0x35', nq'|Revive|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x0A', nq'|Burn Heal|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 392, '0x0188', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1031, '0x0407', nq'|Kangaskhan Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 103, '0x0067', nq'|Old Amber|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x0039', nq'|X Attack|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 468, '0x01D4', nq'|Apricorn Box|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 310, '0x0136', nq'|TM22|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 609, '0x0261', nq'|X Attack 6|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 839, '0x0347', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 95, '0x005F', nq'|Fire Stone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', nq'|Liechi Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 965, '0x03C5', nq'|Quick Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', nq'|Aspear Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1050, '0x041A', nq'|Articuno Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 487, '0x01E7', nq'|Blu Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 110, '0x006E', nq'|Nugget|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 554, '0x022A', nq'|Poison Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 300, '0x012C', nq'|TM12|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 321, '0x0141', nq'|TM33|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 934, '0x03A6', nq'|Pink Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 566, '0x0236', nq'|Battle CD 33|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 669, '0x029D', nq'|Tyranitarite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 709, '0x02C5', nq'|Shalour Sable|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 287, '0x011F', nq'|Choice Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 532, '0x0214', nq'|Jade Orb|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', nq'|Soda Pop|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 5, '0x05', nq'|Town Map|' , 1 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 121, '0x0079', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0x00CF', nq'|Starf Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 446, '0x01BE', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 316, '0x013C', nq'|TM28|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', nq'|Shuca Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x003C', nq'|X Accuracy|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 255, '0x00FF', nq'|Lax Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 498, '0x01F2', nq'|Moon Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', nq'|TwistedSpoon|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', nq'|Ganlon Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 369, '0x0171', nq'|TM42|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 231, '0x00E7', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 619, '0x026B', nq'|TM94|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', nq'|Liechi Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 629, '0x0275', nq'|DNA Splicers|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 609, '0x0261', nq'|X Attack 6|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x0039', nq'|X Attack|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 143, '0x008F', nq'|Reply Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 793, '0x0319', nq'|Fairium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 509, '0x01FD', nq'|Data Card 05|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 772, '0x0304', nq'|Meteorite|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 207, '0x00CF', nq'|Black Belt|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 17, '0x0011', nq'|Awakening|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 219, '0x00DB', nq'|Shell Bell|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 585, '0x0249', nq'|Relic Silver|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x45', nq'|Mystery Egg|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 848, '0x0350', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 617, '0x0269', nq'|Dark Stone|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 726, '0x02D6', nq'|Eon Ticket|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 927, '0x039F', nq'|Solganium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 31, '0x001F', nq'|Energy Root|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 428, '0x01AC', nq'|Explorer Kit|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 9, '0x0009', nq'|Repeat Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 481, '0x01E1', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 287, '0x011F', nq'|Choice Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 590, '0x024E', nq'|Relic Crown|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 317, '0x013D', nq'|TM29|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 506, '0x01FA', nq'|Data Card 02|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 400, '0x0190', nq'|TM73|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 532, '0x0214', nq'|Jade Orb|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', nq'|Soothe Bell|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 873, '0x0369', nq'|S.S. Ticket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 121, '0x0079', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x54', nq'|Mint Berry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', nq'|Full Heal|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', nq'|Haban Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 517, '0x0205', nq'|Data Card 13|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 217, '0x00D9', nq'|Silk Scarf|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 446, '0x01BE', nq'|Good Rod|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 303, '0x012F', nq'|TM15|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 36, '0x0024', nq'|Elixir|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 149, '0x0095', nq'|Bluk Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 288, '0x0120', nq'|Devon Scope|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 294, '0x0126', nq'|Power Weight|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0x00BF', nq'|Shuca Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1016, '0x03F8', nq'|Shellder Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', nq'|Rule Book|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', nq'|Blue Orb|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 202, '0x00CA', nq'|Ganlon Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 750, '0x02EE', nq'|Mega Anklet|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 115, '0x0073', nq'|Autograph|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 488, '0x01E8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 752, '0x02F0', nq'|Swampertite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 95, '0x005F', nq'|Fire Stone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 248, '0x00F8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 145, '0x0091', nq'|Mago Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 43, '0x002B', nq'|Berry Juice|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', nq'|Liechi Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 342, '0x0156', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 557, '0x022D', nq'|Psychic Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 248, '0x00F8', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 234, '0xEA', nq'|TM42|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 928, '0x03A0', nq'|Lunalium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 78, '0x4E', nq'|PRZCureBerry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 501, '0x01F5', nq'|Elevator Key|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', nq'|Toxic Plate|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 212, '0x00D4', nq'|NeverMeltIce|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 536, '0x0218', nq'|Battle CD 03|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 153, '0x0099', nq'|Aspear Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 222, '0x00DE', nq'|Silver Powder|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 628, '0x0274', nq'|DNA Splicers|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 216, '0xD8', nq'|TM25|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 506, '0x01FA', nq'|Data Card 02|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', nq'|PP Max|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 590, '0x024E', nq'|Relic Crown|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 263, '0x0107', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 407, '0x0197', nq'|TM80|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0x00FE', nq'|Sea Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 265, '0x0109', nq'|S.S. Ticket|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 5, '0x0005', nq'|Safari Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x0018', nq'|Max Potion|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 671, '0x029F', nq'|Pinsirite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1000, '0x03E8', nq'|Psyduck Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x0093', nq'|Bridge Mail V|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 294, '0x0126', nq'|Power Weight|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 0, '0x0000', nq'|None|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 320, '0x0140', nq'|Pure Incense|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 732, '0x02DC', nq'|Key to Room 4|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 430, '0x01AE', nq'|Rule Book|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 843, '0x034B', nq'|Professor's Mask|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 56, '0x0038', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 63, '0x3F', nq'|S.S. Ticket|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', nq'|Liechi Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 811, '0x032B', nq'|Grassium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 486, '0x01E6', nq'|Blu Apricorn|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 57, '0x0039', nq'|X Attack|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 679, '0x02A7', nq'|Alakazite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 141, '0x008D', nq'|Inquiry Mail|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 490, '0x01EA', nq'|White Apricorn|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 220, '0x00DC', nq'|Choice Band|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 884, '0x0374', nq'|Grassy Seed|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 140, '0x008C', nq'|Persim Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 80, '0x0050', nq'|Poké Doll|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', nq'|Up-Grade|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', nq'|Blue Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', nq'|Blu ID Badge|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 521, '0x0209', nq'|Data Card 17|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 129, '0x0081', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 560, '0x0230', nq'|Ghost Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', nq'|Wepear Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', nq'|TM40|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', nq'|Explorer Kit|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 669, '0x029D', nq'|Tyranitarite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 89, '0x0059', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 745, '0x02E9', nq'|Mega Pendant|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 506, '0x01FA', nq'|Data Card 02|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0x00FE', nq'|Sea Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 215, '0x00D7', nq'|Charcoal|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 174, '0x00AE', nq'|Starf Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 186, '0x00BA', nq'|Wacan Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', nq'|Blue Flute|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 685, '0x02AD', nq'|Latiosite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 671, '0x029F', nq'|Pinsirite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 105, '0x0069', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', nq'|Max Elixir|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 440, '0x01B8', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 320, '0x0140', nq'|Pure Incense|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 49, '0x0031', nq'|Calcium|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 249, '0x00F9', nq'|Charcoal|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 764, '0x02FC', nq'|Diancite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 191, '0xBF', nq'|TM01|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 32, '0x20', nq'|Fire Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 425, '0x01A9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 389, '0x0185', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 517, '0x0205', nq'|Data Card 13|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 557, '0x022D', nq'|Psychic Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x0F', nq'|Max Potion|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 224, '0x00E0', nq'|Cleanse Tag|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 29, '0x1D', nq'|Escape Rope|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 248, '0x00F8', nq'|TwistedSpoon|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 577, '0x0241', nq'|Poké Toy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 252, '0x00FC', nq'|Up-Grade|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 532, '0x0214', nq'|Gear|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 100, '0x0064', nq'|Claw Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', nq'|Wepear Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', nq'|Explorer Kit|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x003D', nq'|X Special|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', nq'|Quick Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 501, '0x01F5', nq'|Photo Album|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 278, '0x0116', nq'|Iron Ball|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 23, '0x0017', nq'|Full Restore|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 685, '0x02AD', nq'|Latiosite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 119, '0x0077', nq'|Chill Drive|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 320, '0x0140', nq'|Pure Incense|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 346, '0x015A', nq'|HM08|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1011, '0x03F3', nq'|Magnemite Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 399, '0x018F', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 198, '0x00C6', nq'|Colbur Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 740, '0x02E4', nq'|Contest Costume|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 468, '0x01D4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 576, '0x0240', nq'|Dream Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 448, '0x01C0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 24, '0x0018', nq'|Revive|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 59, '0x003B', nq'|X Speed|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 48, '0x0030', nq'|Red Shard|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 185, '0x00B9', nq'|Mental Herb|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 635, '0x027B', nq'|Colress MCHN|', q'|Key items|', q'|Black 2, White 2|', 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 147, '0x93', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 349, '0x015D', nq'|Oak's Parcel|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0xCC', nq'|TM13|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 892, '0x037C', nq'|Polished Mud Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 746, '0x02EA', nq'|Mega Glasses|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 537, '0x0219', nq'|Prism Scale|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 489, '0x01E9', nq'|Pink Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0xD6', nq'|TM23|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 676, '0x02A4', nq'|Gyaradosite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 264, '0x0108', nq'|Yellow Scarf|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 323, '0x0143', nq'|TM35|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 822, '0x0336', nq'|Darkinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 392, '0x0188', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 24, '0x0018', nq'|Revive|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 195, '0x00C3', nq'|Everstone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 272, '0x0110', nq'|Acro Bike|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', nq'|Quick Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 216, '0x00D8', nq'|Dragon Fang|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 257, '0x0101', nq'|Green Scarf|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 158, '0x009E', nq'|Tamato Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 893, '0x037D', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 384, '0x0180', nq'|TM57|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', nq'|Coba Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 49, '0x31', nq'|Nugget|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 483, '0x01E3', nq'|Rainbow Wing|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 238, '0x00EE', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 498, '0x01F2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 107, '0x006B', nq'|Shiny Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 564, '0x0234', nq'|Normal Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 576, '0x0240', nq'|Dream Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 439, '0x01B7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', nq'|TM28|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', nq'|TM45|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 601, '0x0259', nq'|X Sp. Def 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 855, '0x0357', nq'|Pink Nectar|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 539, '0x021B', nq'|Float Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 411, '0x019B', nq'|TM84|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 489, '0x01E9', nq'|Pink Apricorn|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 676, '0x02A4', nq'|Gyaradosite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 596, '0x0254', nq'|X Defense 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 135, '0x0087', nq'|Pecha Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', nq'|Wepear Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 48, '0x0030', nq'|Red Shard|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', nq'|Haban Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 787, '0x0313', nq'|Buginium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 443, '0x01BB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', nq'|Max Elixir|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 131, '0x0083', nq'|unknown|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 416, '0x01A0', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 120, '0x0078', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 701, '0x02BD', nq'|TMV Pass|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 384, '0x0180', nq'|TM57|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', nq'|Coba Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 249, '0x00F9', nq'|Charcoal|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 219, '0xDB', nq'|TM19|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 612, '0x0264', nq'|Item Drop|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 144, '0x0090', nq'|Wiki Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 38, '0x26', nq'|Full Heal|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 67, '0x0043', nq'|Red Flute|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', nq'|Rawst Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 218, '0x00DA', nq'|Up-Grade|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 450, '0x01C2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x0007', nq'|Dive Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 557, '0x022D', nq'|Psychic Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 253, '0xFD', nq'|TM53|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 316, '0x013C', nq'|Full Incense|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x86', nq'|Pass|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 645, '0x0285', nq'|Ability Capsule|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 226, '0x00E2', nq'|DeepSeaTooth|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 818, '0x0332', nq'|Buginium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1026, '0x0402', nq'|Lickitung Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 386, '0x0182', nq'|TM59|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 458, '0x01CA', nq'|Magma Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 211, '0x00D3', nq'|Jaboca Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 601, '0x0259', nq'|X Sp. Def 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 48, '0x30', nq'|Lemonade|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 539, '0x021B', nq'|Float Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 445, '0x01BD', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', nq'|Armor Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 411, '0x019B', nq'|TM84|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 232, '0xE8', nq'|TM32|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 363, '0x016B', nq'|Fame Checker|', q'|Key items|', q'|FireRed, LeefGreen, Emerald|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 522, '0x020A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 218, '0xDA', nq'|TM18|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 77, '0x4D', nq'|Sharp Beak|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 278, '0x0116', nq'|Iron Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 492, '0x01EC', nq'|Fast Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 395, '0x018B', nq'|TM68|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 87, '0x0057', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 103, '0x0067', nq'|TinyMushroom|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', nq'|Pearl|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', nq'|Muscle Band|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 105, '0x0069', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 241, '0x00F1', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', nq'|Haban Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', nq'|Electirizer|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 48, '0x0030', nq'|Carbos|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 131, '0x0083', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 221, '0x00DD', nq'|King's Rock|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 584, '0x0248', nq'|Relic Copper|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 294, '0x0126', nq'|Power Weight|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', nq'|Poffin Case|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 384, '0x0180', nq'|TM57|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 441, '0x01B9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 766, '0x02FE', nq'|Mega Cuff|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 169, '0x00A9', nq'|Ganlon Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 85, '0x0055', nq'|Escape Rope|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 115, '0x0073', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 529, '0x0211', nq'|Data Card 25|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 564, '0x0234', nq'|Normal Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', nq'|Energy Root|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 380, '0x017C', nq'|TM53|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 292, '0x0124', nq'|Power Band|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', nq'|Damp Rock|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', nq'|TM28|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 419, '0x01A3', nq'|TM92|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 455, '0x01C7', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 748, '0x02EC', nq'|Mega Stickpin|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', nq'|Blue Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 539, '0x021B', nq'|Float Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 336, '0x0150', nq'|TM48|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 601, '0x0259', nq'|X Sp. Def 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 209, '0xD1', nq'|TM09|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 606, '0x025E', nq'|X Special 6|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 315, '0x013B', nq'|TM27|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 438, '0x01B6', nq'|Works Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1018, '0x03FA', nq'|Onix Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', nq'|Helix Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 113, '0x71', nq'|キャプテン (Captain - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', nq'|Pearl|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 590, '0x024E', nq'|Relic Crown|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 883, '0x0373', nq'|Misty Seed|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', nq'|Muscle Band|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 538, '0x021A', nq'|Eviolite|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 337, '0x0151', nq'|TM10|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 241, '0xF1', nq'|TM49|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', nq'|Electirizer|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 325, '0x0145', nq'|TM37|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 973, '0x03CD', nq'|Mighty Candy XL|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 197, '0x00C5', nq'|Haban Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 850, '0x0352', nq'|Ride Pager|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 413, '0x019D', nq'|TM86|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 918, '0x0396', nq'|Dragon Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 59, '0x003B', nq'|X Speed|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 208, '0x00D0', nq'|Magnet|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 561, '0x0231', nq'|Dragon Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 581, '0x0245', nq'|Big Nugget|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 425, '0x01A9', nq'|HM06|', q'|TMs and HMs|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 176, '0x00B0', nq'|Magost Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 584, '0x0248', nq'|Relic Copper|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', nq'|Protein|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 449, '0x01C1', nq'|Poffin Case|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', nq'|Skull Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 942, '0x03AE', nq'|Surge Badge|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 478, '0x01DE', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 257, '0x0101', nq'|Green Scarf|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', nq'|Silk Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 486, '0x01E6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 558, '0x022E', nq'|Bug Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 651, '0x028B', nq'|Poké Flute|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x0098', nq'|Rawst Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 359, '0x0167', nq'|TM32|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 178, '0x00B2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 809, '0x0329', nq'|Waterium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 529, '0x0211', nq'|Data Card 25|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 564, '0x0234', nq'|Normal Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 27, '0x001B', nq'|Soda Pop|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', nq'|Miracle Seed|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 484, '0x01E4', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', nq'|Energy Root|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', nq'|Damp Rock|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 475, '0x01DB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 355, '0x0163', nq'|TM28|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 694, '0x02B6', nq'|TM100|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 233, '0x00E9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 690, '0x02B2', nq'|TM96|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 221, '0xDD', nq'|TM21|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 261, '0x0105', nq'|Blue Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 235, '0xEB', nq'|TM43|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 794, '0x031A', nq'|Pikanium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 391, '0x0187', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', nq'|Armor Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 156, '0x9C', nq'|Sacred Ash|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 547, '0x0223', nq'|Battle CD 14|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 32, '0x0020', nq'|Lemonade|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 411, '0x019B', nq'|TM84|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', nq'|TM40|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1017, '0x03F9', nq'|Gastly Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 836, '0x0344', nq'|Pikashunium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', nq'|TM05|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 603, '0x025B', nq'|X Attack 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', nq'|Pearl|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', nq'|Muscle Band|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 683, '0x02AB', nq'|Garchompite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 172, '0x00AC', nq'|Apicot Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 167, '0x00A7', nq'|Wepear Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 270, '0x010E', nq'|Soot Sack|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 131, '0x0083', nq'|unknown|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 46, '0x002E', nq'|Protein|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 12, '0x000C', nq'|Premier Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 585, '0x0249', nq'|Relic Silver|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 345, '0x0159', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 98, '0x0062', nq'|Leaf Stone|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 795, '0x031B', nq'|Bottle Cap|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 999, '0x03E7', nq'|Meowth Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 258, '0x0102', nq'|Yellow Scarf|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 87, '0x0057', nq'|Big Mushroom|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', nq'|Miracle Seed|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', nq'|Damp Rock|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 679, '0x02A7', nq'|Alakazite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 59, '0x003B', nq'|X Speed|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 104, '0x0068', nq'|Armor Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 5, '0x0005', nq'|Safari Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 214, '0x00D6', nq'|TwistedSpoon|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 225, '0x00E1', nq'|Soul Dew|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 8, '0x0008', nq'|Nest Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', nq'|Azure Flute|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 967, '0x03C7', nq'|Mighty Candy L|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', nq'|Helix Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 603, '0x025B', nq'|X Attack 3|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 332, '0x014C', nq'|TM05|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 367, '0x016F', nq'|TM40|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1045, '0x0415', nq'|Porygon Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 88, '0x0058', nq'|Pearl|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 653, '0x028D', nq'|Surprise Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 159, '0x009F', nq'|Cornn Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 647, '0x0287', nq'|Sachet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 266, '0x010A', nq'|Muscle Band|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 152, '0x98', nq'|Berserk Gene|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 503, '0x01F7', nq'|Tidal Bell|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 245, '0x00F5', nq'|Poison Barb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 584, '0x0248', nq'|Relic Copper|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 837, '0x0345', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 205, '0x00CD', nq'|Apicot Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 505, '0x01F9', nq'|Data Card 01|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 535, '0x0217', nq'|Blue Orb|', q'|Key items|', q'|X, Y|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 152, '0x0098', nq'|Pinap Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 515, '0x0203', nq'|Vivid Scent|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 223, '0xDF', nq'|TM31|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 330, '0x014A', nq'|TM42|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1007, '0x03EF', nq'|Tentacool Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 92, '0x5C', nq'|7F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 529, '0x0211', nq'|Data Card 25|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 458, '0x01CA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', nq'|Soothe Bell|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 98, '0x62', nq'|かみなりバッヂ (ThunderBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 545, '0x0221', nq'|Vivid Scent|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 512, '0x0200', nq'|Data Card 08|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 607, '0x025F', nq'|X Sp. Def 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', nq'|Damp Rock|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 196, '0xC4', nq'|HM01|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 488, '0x01E8', nq'|Grn Apricorn|', q'|Items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 353, '0x0161', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 329, '0x0149', nq'|TM02|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 791, '0x0317', nq'|Darkinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 169, '0x00A9', nq'|Pomeg Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 297, '0x0129', nq'|TM09|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 128, '0x80', nq'|Machine Part|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 455, '0x01C7', nq'|Azure Flute|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 603, '0x025B', nq'|X Attack 3|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 49, '0x0031', nq'|Blue Shard|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 28, '0x001C', nq'|Lemonade|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 729, '0x02D9', nq'|Meteorite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 304, '0x0130', nq'|TM16|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 993, '0x03E1', nq'|Jigglypuff Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 183, '0x00B7', nq'|Quick Claw|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 237, '0x00ED', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', nq'|Coba Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 100, '0x0064', nq'|Claw Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 302, '0x012E', nq'|TM14|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 561, '0x0231', nq'|Dragon Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 446, '0x01BE', nq'|Good Rod|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 649, '0x0289', nq'|Snowball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 505, '0x01F9', nq'|Data Card 01|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 107, '0x006B', nq'|Big Pearl|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 19, '0x0013', nq'|Burn Heal|', q'|Medicine|', q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 645, '0x0285', nq'|Ability Capsule|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 970, '0x03CA', nq'|Courage Candy L|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 359, '0x0167', nq'|TM32|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 194, '0x00C2', nq'|Smoke Ball|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', nq'|Soothe Bell|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 368, '0x0170', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 768, '0x0300', nq'|Lopunnite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x65', nq'|Pnk Apricorn|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 550, '0x0226', nq'|Electric Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0x00C2', nq'|Tanga Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 611, '0x0263', nq'|Ability Urge|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 493, '0x01ED', nq'|Level Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 141, '0x8D', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 712, '0x02C8', nq'|Looker Ticket|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 683, '0x02AB', nq'|Garchompite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', nq'|Focus Sash|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 60, '0x3C', nq'|Silver Leaf|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 297, '0x0129', nq'|Choice Specs|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0x00C0', nq'|Coba Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 327, '0x0147', nq'|Razor Fang|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', nq'|Magmarizer|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 49, '0x31', nq'|X Attack|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 134, '0x0086', nq'|Chesto Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 95, '0x5F', nq'|10F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 427, '0x01AB', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 446, '0x01BE', nq'|Good Rod|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 230, '0xE6', nq'|TM38|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 294, '0x0126', nq'|Power Weight|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 1, '0x0001', nq'|Master Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 770, '0x0302', nq'|Beedrillite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 196, '0x00C4', nq'|Kasib Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 596, '0x0254', nq'|X Defend 2|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 334, '0x014E', nq'|TM46|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 731, '0x02DB', nq'|Key to Room 2|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 692, '0x02B4', nq'|TM98|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 323, '0x0143', nq'|Magmarizer|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 225, '0x00E1', nq'|Soul Dew|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 479, '0x01DF', nq'|Lost Item|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 123, '0x007B', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 201, '0x00C9', nq'|Dragon Scale|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 218, '0x00DA', nq'|Soothe Bell|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', nq'|Shoal Shell|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 868, '0x0364', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 546, '0x0222', nq'|Battle CD 13|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 592, '0x0250', nq'|Battle CD 59|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 96, '0x0060', nq'|Thunderstone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 127, '0x7F', nq'|Card Key|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 328, '0x0148', nq'|TM40|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 327, '0x0147', nq'|Razor Fang|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', nq'|Water Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', nq'|Metal Powder|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 543, '0x021F', nq'|Battle CD 10|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 209, '0xD1', nq'|TM18|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 498, '0x01F2', nq'|Moon Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 255, '0x00FF', nq'|Blue Scarf|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x009B', nq'|Oran Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 63, '0x003F', nq'|HP Up|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', nq'|Helix Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 517, '0x0205', nq'|Moon Shard|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 611, '0x0263', nq'|Ability Urge|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 254, '0xFE', nq'|TM54|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 163, '0x00A3', nq'|Spelon Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1013, '0x03F5', nq'|Doduo Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 339, '0x0153', nq'|HM01|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', nq'|Electirizer|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 333, '0x014D', nq'|TM45|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 561, '0x0231', nq'|Dragon Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 907, '0x038B', nq'|Ground Memory|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', nq'|Focus Sash|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 621, '0x026D', nq'|Xtransceiver|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 309, '0x0135', nq'|TM21|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 646, '0x0286', nq'|Whipped Dream|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', nq'|Spelon Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 210, '0x00D2', nq'|Custap Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', nq'|Silk Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 76, '0x004C', nq'|X Defend|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 662, '0x0296', nq'|Mewtwonite X|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 479, '0x01DF', nq'|Lost Item|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0xEF', nq'|TM47|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 13, '0x000D', nq'|Potion|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', nq'|Colbur Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 936, '0x03A8', nq'|Blue Petal|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 195, '0xC3', nq'|TM04|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', nq'|HM02|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 144, '0x0090', nq'|Wiki Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 368, '0x0170', nq'|TM41|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 551, '0x0227', nq'|Grass Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 232, '0x00E8', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 349, '0x015D', nq'|TM22|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', nq'|Water Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', nq'|BrightPowder|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0x00C2', nq'|Tanga Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 848, '0x0350', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0x00CF', nq'|Starf Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 188, '0x00BC', nq'|SilverPowder|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 557, '0x022D', nq'|Battle CD 24|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 15, '0x000F', nq'|Burn Heal|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 611, '0x0263', nq'|Ability Urge|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 654, '0x028E', nq'|Boost Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 308, '0x0134', nq'|TM20|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 395, '0x018B', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 105, '0x0069', nq'|Skull Fossil|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 903, '0x0387', nq'|Pewter Crunchies|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x001E', nq'|Fresh Water|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 132, '0x0084', nq'|Retro Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 47, '0x002F', nq'|Shoal Shell|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 322, '0x0142', nq'|Electirizer|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', nq'|Focus Sash|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 428, '0x01AC', nq'|Explorer Kit|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 56, '0x38', nq'|Super Repel|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 114, '0x0072', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 352, '0x0160', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', nq'|Cornn Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', nq'|Magmarizer|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 446, '0x01BE', nq'|Good Rod|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 507, '0x01FB', nq'|Music Disc|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 751, '0x02EF', nq'|Meteorite|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 179, '0x00B3', nq'|Spelon Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 650, '0x028A', nq'|Safety Goggles|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 480, '0x01E0', nq'|Pass|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 171, '0xAB', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 166, '0x00A6', nq'|Durin Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 470, '0x01D6', nq'|Berry Pots|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 526, '0x020E', nq'|Data Card 22|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 30, '0x001E', nq'|EnergyPowder|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', nq'|Silk Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 785, '0x0311', nq'|Flyinium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 32, '0x20', nq'|Rare Candy|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 235, '0x00EB', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 271, '0x010F', nq'|Power Herb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 254, '0xFE', nq'|HM12|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', nq'|Petaya Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 193, '0x00C1', nq'|DeepSeaScale|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 11, '0x000B', nq'|Luxury Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 876, '0x036C', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', nq'|HM02|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 91, '0x5B', nq'|6F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 551, '0x0227', nq'|Grass Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 888, '0x0378', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', nq'|Water Stone|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 561, '0x0231', nq'|Battle CD 28|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 751, '0x02EF', nq'|Meteorite|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 80, '0x50', nq'|Ice Berry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 801, '0x0321', nq'|Tapunium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 339, '0x0153', nq'|TM12|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 67, '0x43', nq'|X Speed|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 252, '0x00FC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 474, '0x01DA', nq'|Clear Bell|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 101, '0x0065', nq'|Helix Fossil|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', nq'|TM58|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 148, '0x94', nq'|Teru-sama|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 457, '0x01C9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', nq'|Red Scarf|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 379, '0x017B', nq'|TM52|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 467, '0x01D3', nq'|Secret Key|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', nq'|Focus Sash|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 50, '0x32', nq'|PP Up|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 512, '0x0200', nq'|Data Card 08|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 865, '0x0361', nq'|Silver Pinap Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 305, '0x0131', nq'|TM17|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 442, '0x01BA', nq'|Town Map|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 584, '0x0248', nq'|Relic Copper|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 81, '0x51', nq'|Poison Barb|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 516, '0x0204', nq'|Data Card 12|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 996, '0x03E4', nq'|Paras Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 306, '0x0132', nq'|TM18|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 589, '0x024D', nq'|Relic Statue|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', nq'|Air Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 786, '0x0312', nq'|Psychium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 728, '0x02D8', nq'|Go-Goggles|', q'|Key items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 480, '0x01E0', nq'|Pass|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 251, '0x00FB', nq'|Silk Scarf|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 550, '0x0226', nq'|Battle CD 17|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', nq'|Rare Bone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 933, '0x03A5', nq'|Z-Power Ring|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 145, '0x0091', nq'|BridgeMail D|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 901, '0x0385', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 198, '0x00C6', nq'|Colbur Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 509, '0x01FD', nq'|Mayor's Note|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 421, '0x01A5', nq'|HM02|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 551, '0x0227', nq'|Grass Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 17, '0x11', nq'|Super Potion|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 498, '0x01F2', nq'|Moon Ball|', q'|Poké Balls|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 136, '0x0088', nq'|Lustrous Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 84, '0x0054', nq'|Water Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 792, '0x0318', nq'|Steelium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', nq'|Metal Powder|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 325, '0x0145', nq'|Reaper Cloth|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 280, '0x0118', nq'|Destiny Knot|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 492, '0x01EC', nq'|Fast Ball|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', nq'|Red Scarf|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 467, '0x01D3', nq'|Secret Key|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 969, '0x03C9', nq'|Smart Candy L|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 334, '0x014E', nq'|TM46|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 691, '0x02B3', nq'|TM97|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 947, '0x03B3', nq'|Ilima's Normalium Z|', q'|Key items|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 729, '0x02D9', nq'|Meteorite|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 573, '0x023D', nq'|Plume Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 929, '0x03A1', nq'|Ultranecrozium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 863, '0x035F', nq'|Silver Nanab Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 64, '0x0040', nq'|Fluffy Tail|', q'|Battle items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 898, '0x0382', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 62, '0x003E', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', nq'|Leaf Stone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 209, '0x00D1', nq'|Micle Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 646, '0x0286', nq'|Whipped Dream|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 440, '0x01B8', nq'|Galactic Key|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 234, '0x00EA', nq'|Leftovers|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', nq'|TM87|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 76, '0x004C', nq'|Super Repel|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 919, '0x0397', nq'|Dark Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x007B', nq'|Glitter Mail|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 123, '0x7B', nq'|Heal Powder|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 662, '0x0296', nq'|Mewtwonite X|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 18, '0x0012', nq'|Parlyz Heal|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 7, '0x07', nq'|Bicycle|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 425, '0x01A9', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 192, '0xC0', nq'|TM02|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 444, '0x01BC', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 534, '0x0216', nq'|Red Orb|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 400, '0x0190', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 213, '0x00D5', nq'|BrightPowder|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 257, '0x0101', nq'|Metal Powder|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 97, '0x0061', nq'|Water Stone|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 800, '0x0320', nq'|Primarium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 232, '0xE8', nq'|TM40|', q'|TMs and HMs|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 730, '0x02DA', nq'|Key to Room 1|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 249, '0x00F9', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 154, '0x009A', nq'|Kelpsy Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 215, '0x00D7', nq'|Charcoal|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 151, '0x0097', nq'|Wepear Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0x00C2', nq'|Tanga Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', nq'|Max Elixir|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 271, '0x010F', nq'|Basement Key|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 653, '0x028D', nq'|Surprise Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 4, '0x0004', nq'|Poké Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0x00C4', nq'|Kasib Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 975, '0x03CF', nq'|Smart Candy XL|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 633, '0x0279', nq'|Plasma Card|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', nq'|Magmarizer|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 48, '0x0030', nq'|Carbos|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 544, '0x0220', nq'|Excite Scent|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 105, '0x69', nq'|ひのたまバッヂ (FireballBadge - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 35, '0x0023', nq'|Max Ether|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 531, '0x0213', nq'|Data Card 27|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x6A', nq'|Smoke Ball|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', nq'|Leaf Stone|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 245, '0x00F5', nq'|Poison Barb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 459, '0x01CB', nq'|Parcel|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 650, '0x028A', nq'|Safety Goggles|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 501, '0x01F5', nq'|Photo Album|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 270, '0x010E', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 410, '0x019A', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', nq'|TM87|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 25, '0x0019', nq'|Max Revive|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 440, '0x01B8', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 88, '0x0058', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 14, '0x000E', nq'|Antidote|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 65, '0x0041', nq'|Blue Flute|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 100, '0x0064', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 633, '0x0279', nq'|Plasma Card|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x0047', nq'|Shoal Shell|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', nq'|TM71|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 768, '0x0300', nq'|Lopunnite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 750, '0x02EE', nq'|Mega Anklet|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 508, '0x01FC', nq'|Data Card 04|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 651, '0x028B', nq'|Poké Flute|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', nq'|Petaya Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 114, '0x0072', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 306, '0x0132', nq'|Sky Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 154, '0x009A', nq'|Kelpsy Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 430, '0x01AE', nq'|Rule Book|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 34, '0x22', nq'|Water Stone|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 202, '0x00CA', nq'|Light Ball|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', nq'|Metal Powder|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 955, '0x03BB', nq'|Roto Stealth|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 871, '0x0367', nq'|???|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 479, '0x01DF', nq'|Lost Item|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 276, '0x0114', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x009B', nq'|Oran Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 219, '0x00DB', nq'|Shell Bell|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 293, '0x0125', nq'|TM05|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1020, '0x03FC', nq'|Krabby Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 15, '0x000F', nq'|Burn Heal|', q'|Items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 305, '0x0131', nq'|Earth Plate|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 465, '0x01D1', nq'|Vs. Recorder|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 159, '0x009F', nq'|Figy Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 516, '0x0204', nq'|Data Card 12|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 340, '0x0154', nq'|TM13|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 480, '0x01E0', nq'|Pass|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 48, '0x0030', nq'|Carbos|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 47, '0x002F', nq'|Shoal Shell|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 173, '0x00AD', nq'|Lansat Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 85, '0x0055', nq'|Leaf Stone|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 678, '0x02A6', nq'|Charizardite Y|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 514, '0x0202', nq'|Data Card 10|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 414, '0x019E', nq'|TM87|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 246, '0x00F6', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1, '0x0001', nq'|Master Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 583, '0x0247', nq'|Comet Shard|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 725, '0x02D5', nq'|Letter|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', nq'|Miracle Seed|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 208, '0xD0', nq'|TM08|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', nq'|TM71|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', nq'|Hondew Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 909, '0x038D', nq'|Bug Memory|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 152, '0x0098', nq'|Rawst Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 486, '0x01E6', nq'|Blue Apricorn|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 770, '0x0302', nq'|Beedrillite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 854, '0x0356', nq'|Yellow Nectar|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 59, '0x003B', nq'|X Speed|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 472, '0x01D8', nq'|Blue Card|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 79, '0x4F', nq'|Burnt Berry|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 354, '0x0162', nq'|TM27|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 181, '0xB5', nq'|Surf Mail|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x009B', nq'|Oran Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 122, '0x007A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 441, '0x01B9', nq'|Red Chain|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 496, '0x01F0', nq'|Love Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 194, '0x00C2', nq'|Tanga Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 451, '0x01C3', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 465, '0x01D1', nq'|Vs. Recorder|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', nq'|SecretPotion|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 7, '0x0007', nq'|Dive Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 278, '0x0116', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 73, '0x0049', nq'|Guard Spec.|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 160, '0xA0', nq'|Lure Ball|', q'|Poké Balls|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 323, '0x0143', nq'|Magmarizer|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 102, '0x0066', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 51, '0x33', nq'|X Defend|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 678, '0x02A6', nq'|Charizardite Y|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 611, '0x0263', nq'|Ability Urge|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 553, '0x0229', nq'|Fighting Gem|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 600, '0x0258', nq'|X Special 3|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 555, '0x022B', nq'|Ground Gem|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 930, '0x03A2', nq'|Mimikium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 877, '0x036D', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 113, '0x71', nq'|Spell Tag|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 698, '0x02BA', nq'|Common Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 239, '0x00EF', nq'|Miracle Seed|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 598, '0x0256', nq'|X Accuracy 2|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 398, '0x018E', nq'|TM71|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 466, '0x01D2', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 25, '0x0019', nq'|Max Revive|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 172, '0x00AC', nq'|Hondew Berry|', q'|Berries|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 359, '0x0167', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', nq'|Petaya Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 719, '0x02CF', nq'|Acro Bike|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', nq'|TM45|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 528, '0x0210', nq'|DNA Sample|', q'|Key items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 140, '0x008C', nq'|Bloom Mail|', q'|Mail|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 472, '0x01D8', nq'|Blue Card|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 257, '0x0101', nq'|Metal Powder|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 798, '0x031E', nq'|Decidium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 777, '0x0309', nq'|Firium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1056, '0x0420', nq'|Meltan Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 354, '0x0162', nq'|TM27|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 155, '0x009B', nq'|Oran Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 922, '0x039A', nq'|Lunalium Z|', q'|Z-Crystals|', q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 655, '0x028F', nq'|Amaze Mulch|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 358, '0x0166', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', nq'|Skull Fossil|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 43, '0x2B', nq'|Secret Key|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 637, '0x027D', nq'|Dropped Item|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 927, '0x039F', nq'|Solganium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 387, '0x0183', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 41, '0x0029', nq'|Max Elixir|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 569, '0x0239', nq'|Clever Wing|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x001E', nq'|Fresh Water|', q'|Medicine|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Poké Balls|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 15, '0x000F', nq'|Quick Ball|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 48, '0x0030', nq'|Carbos|', q'|Medicine|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 514, '0x0202', nq'|Data Card 10|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0x00C4', nq'|Kasib Berry|', q'|Berries|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 571, '0x023B', nq'|Pretty Wing|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 75, '0x004B', nq'|Green Shard|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 431, '0x01AF', nq'|Poké Radar|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 134, '0x0086', nq'|Sweet Heart|', q'|Medicine|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 287, '0x011F', nq'|Claw Fossil|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 555, '0x022B', nq'|Ground Gem|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 538, '0x021A', nq'|Battle CD 05|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 111, '0x6F', nq'|Big Pearl|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 395, '0x018B', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 94, '0x5E', nq'|9F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 30, '0x001E', nq'|EnergyPowder|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 118, '0x76', nq'|Thick Club|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 615, '0x0267', nq'|Dire Hit 3|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 90, '0x5A', nq'|5F (G)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 633, '0x0279', nq'|Plasma Card|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 500, '0x01F4', nq'|Park Ball|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 204, '0x00CC', nq'|Petaya Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 253, '0x00FD', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 9, '0x0009', nq'|Repeat Ball|', q'|Poké Balls|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Poké Balls|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 372, '0x0174', nq'|TM45|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 645, '0x0285', nq'|Ability Capsule|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 656, '0x0290', nq'|Gengarite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 408, '0x0198', nq'|TM81|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 112, '0x0070', nq'|Griseous Orb|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 146, '0x0092', nq'|Aguav Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 272, '0x0110', nq'|Toxic Orb|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 133, '0x0085', nq'|Cheri Berry|', q'|Berries|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 420, '0x01A4', nq'|HM01|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 637, '0x027D', nq'|Dropped Item|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 655, '0x028F', nq'|Amaze Mulch|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 207, '0x00CF', nq'|Starf Berry|', q'|Berries|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 453, '0x01C5', nq'|Lunar Wing|', q'|Key items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 806, '0x0326', nq'|Mewnium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', nq'|Skull Fossil|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 258, '0x0102', nq'|Yellow Scarf|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 479, '0x01DF', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 180, '0xB4', nq'|Brick Piece|', q'|Items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 116, '0x74', nq'|エクセレント (Excellent - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 465, '0x01D1', nq'|Vs. Recorder|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 53, '0x0035', nq'|PP Max|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 131, '0x0083', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 658, '0x0292', nq'|Ampharosite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 467, '0x01D3', nq'|Secret Key|', q'|Key items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Poké Balls|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 203, '0xCB', nq'|TM03|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 377, '0x0179', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 30, '0x001E', nq'|Fresh Water|', q'|Medicine|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 61, '0x3D', nq'|Super Rod|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 947, '0x03B3', nq'|Ilima Normalium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 501, '0x01F5', nq'|Elevator Key|', q'|Key items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 514, '0x0202', nq'|Data Card 10|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 571, '0x023B', nq'|Pretty Wing|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 106, '0x006A', nq'|Rare Bone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 223, '0x00DF', nq'|Metal Powder|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 301, '0x012D', nq'|TM13|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', nq'|TM58|', q'|TMs|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 249, '0x00F9', nq'|Charcoal|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 250, '0x00FA', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 163, '0x00A3', nq'|Spelon Berry|', q'|Berries|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 285, '0x011D', nq'|Storage Key|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 106, '0x006A', nq'|Rare Bone|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 390, '0x0186', nq'|unknown|' , q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 71, '0x47', nq'|Silver Wing|', q'|Key items|' , 2 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 574, '0x023E', nq'|Liberty Pass|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 116, '0x0074', nq'|Douse Drive|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 952, '0x03B8', nq'|Roto Exp. Points|' , q'|Ultra Sun, Ultra Moon|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 380, '0x017C', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 469, '0x01D5', nq'|Unown Report|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 831, '0x033F', nq'|Aloraichium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 246, '0x00F6', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x0045', nq'|White Flute|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 656, '0x0290', nq'|Gengarite|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 408, '0x0198', nq'|TM81|', q'|TMs and HMs|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', nq'|TM58|', q'|TMs and HMs|' , 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 133, '0x0085', nq'|unknown|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 472, '0x01D8', nq'|Blue Card|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 272, '0x0110', nq'|Toxic Orb|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 658, '0x0292', nq'|Ampharosite|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 733, '0x02DD', nq'|Key to Room 6|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 534, '0x0216', nq'|Red Orb|', q'|Key items|', q'|HeartGold, SoulSilver|', 4 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 896, '0x0380', nq'|???|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 105, '0x0069', nq'|Skull Fossil|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 260, '0x0104', nq'|Red Scarf|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 10, '0x000A', nq'|Timer Ball|', q'|Poké Balls|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 296, '0x0128', nq'|TM08|', q'|TMs and HMs|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 45, '0x002D', nq'|HP Up|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 110, '0x006E', nq'|Oval Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 383, '0x017F', nq'|TM56|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 658, '0x0292', nq'|Ampharosite|', q'|Items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 341, '0x0155', nq'|HM03|', q'|TMs and HMs|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 464, '0x01D0', nq'|SecretPotion|', q'|Key items|' , 5 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 196, '0x00C4', nq'|Kasib Berry|', q'|Berries|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 90, '0x005A', nq'|unknown|' , q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 573, '0x023D', nq'|Plume Fossil|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 92, '0x005C', nq'|unknown|' , 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 133, '0x0085', nq'|Cheri Berry|', q'|Berries|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 173, '0x00AD', nq'|Grepa Berry|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 763, '0x02FB', nq'|Glalitite|', q'|Items|', q'|Omega Ruby, Alpha Sapphire|', 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 555, '0x022B', nq'|Ground Gem|', q'|Items|' , 5 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 62, '0x003E', nq'|X Sp. Def|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 107, '0x006B', nq'|Shiny Stone|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 76, '0x4C', nq'|Old Rod|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 749, '0x02ED', nq'|Mega Tiara|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 791, '0x0317', nq'|Darkinium Z|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 574, '0x023E', nq'|Liberty Pass|', q'|Key items|' , 6 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 275, '0x0113', nq'|Eon Ticket|', q'|Key items|' , 3 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 1027, '0x0403', nq'|Koffing Candy|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 330, '0x014A', nq'|TM42|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 294, '0x0126', nq'|TM06|', q'|TMs and HMs|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 244, '0xF4', nq'|TM44|' , 1 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 808, '0x0328', nq'|Firium Z|', q'|Z-Crystals|' , 7 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 648, '0x0288', nq'|Luminous Moss|', q'|Items|' , 7 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 107, '0x6B', nq'|たまご (Egg - D)|' , 1 );
insert into itemIDs( ID, HEX, NAME , GAME, GEN )
values( 463, '0x01CF', nq'|Storage Key|' , q'|Let's Go|', 7 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 98, '0x0062', nq'|Leaf Stone|', q'|Items|', q'|XD|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 69, '0x0045', nq'|White Flute|', q'|Items|' , 4 );
insert into itemIDs( ID, HEX, NAME, POKCET, GAME, GEN )
values( 76, '0x004C', nq'|X Defend|', q'|Items|', q'|Colosseum|', 3 );
insert into itemIDs( ID, HEX, NAME, POKCET , GEN )
values( 385, '0x0181', nq'|TM58|', q'|TMs and HMs|' , 5 );
insert into itemIDs( ID, HEX, NAME , GEN )
values( 133, '0x0085', nq'|unknown|' , 5 );