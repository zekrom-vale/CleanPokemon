--Count the alolans
select count(*)
	from species
	where DEX_SUFFIX='A';

--What is the DEX of Charizard?
select DEX
	from mix
	where NAME='Charizard';

--What types are weak against Dragon attacks?
select TYPE DEFFENDER, json.DEF_SE ATTACKER
	from types cross join
		json_table(types.DEF_SE, '$[*]' COLUMNS(DEF_SE PATH '$')) as json
	where json.DEF_SE='Dragon';

--This value already exists but this is the reverse of the procedure that gathers the DEF_* values
--See TYPE_FINAL and GET_DEF and GET_ATK

/*
Requires multiple tables and joining
NOTE: The view mix is a massive joined table
*/

--What specie weighs the most?
select NAME, DEX, DEX_SUFFIX, CLASS
	from mix
	where WEIGHTKG=(select max(WEIGHTKG) from species);
	--Don't need mix

--For each pokemon how many forms do they have?
select NAME, DEX, count(*) as FORMS
	from mix
	group by NAME, DEX
	order by count(*) desc, Name;

--Who has a 3rd STAR bit as 1
select NAME, DEX, STAR
	from mix
	where BitAnd(8,STAR)!=0;

--For each pokemon what item(s) do they use to mega/primal evolve

select NAME, DEX, JSON_ARRAYAGG(ITEM_NAME absent on null) as items
	from mix
	group by NAME, DEX;

--What pokemon have item(s) to mega/primal evolve and what are they?
select NAME, DEX, JSON_ARRAYAGG(ITEM_NAME absent on null) as items
	from mix
	group by NAME, DEX
	having count(ITEM_NAME)>0;