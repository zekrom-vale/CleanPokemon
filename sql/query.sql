/*
Requires only one table
*/
--Count the alolans
select count(*)
	from species
	where DEX_SUFFIX='A';

--What is the DEX of Charizard?
select DEX
	from pokemon
	where NAME='Charizard';

--For each effect number, how many dule types have that effectiveness
select effect, count(*)
	from duleTypeDEF
	group by effect
	order by effect;

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
select NAME, DEX, JSON_ARRAYAGG(ITEM absent on null) as items
	from mix
	group by NAME, DEX;
--Missing 6 and 150, they have items missing

--What pokemon have item(s) to mega/primal evolve and what are they?
select NAME, DEX, JSON_ARRAYAGG(ITEM absent on null) as items
	from mix
	group by NAME, DEX
	having count(ITEM)>0;

--What species are Dragons and Black?
select *
    from mix
    where COLOR='Black' and TYPE='Dragon';

--What pokemon are not within their GENERATION_DEX range
select NAME, DEX, GENERATION_GEN, GENERATION_DEX_MIN, GENERATION_DEX_MAX
    from mix
    where not DEX between GENERATION_DEX_MIN and GENERATION_DEX_MAX
    group by NAME, DEX, GENERATION_GEN, GENERATION_DEX_MIN, GENERATION_DEX_MAX;
--This expected to be empty, but it is not, so there are likely data bugs

/*
Uses sub-queries
*/

--What specie weighs the most?
select NAME, DEX, DEX_SUFFIX, CLASS
	from mix
	where WEIGHTKG=(select max(WEIGHTKG) from species);
	--Don't need mix

--What specie is the longest?
select NAME, DEX, DEX_SUFFIX, CLASS
	from mix
	where HEIGHT_M=(select max(HEIGHT_M) from species);
	--Don't need mix

--For all species how weak are they against dragon types?
select *
	from mix inner join duleTypeDEF
		on duleTypeDEF.TYPE=mix.TYPE
			and(
				duleTypeDEF.TYPE2=mix.TYPE2
				or
				duleTypeDEF.TYPE2 is null and mix.TYPE2 is null
			)
			and duleTypeDEF.ATK='Dragon';

--What species has the longest name?
select *
	from mix
	where length(mix.NAME)=(select max(length(pokemon.NAME)) from pokemon);

--What is the most used ability for the first ability?
with ability as(
	select ABILITY1, count(*) count
		from species
		group by ABILITY1
)
select *
	from ability
	where count=(select max(count) from count);

--For all types how many species have those types?
select *
	from
		(
			select Types.TYPE TYPE, Types2.TYPE TYPE2
				from Types cross join Types Types2
			UNION
			select Types.TYPE TYPE, NULL TYPE2
				from Types
		) typeConstruct
		full outer join
		(
			select TYPE, TYPE2, count(*) count
			from species
				group by TYPE, TYPE2
		) num
			on typeConstruct.TYPE=num.TYPE and (
				typeConstruct.TYPE2=num.TYPE2
				or
				typeConstruct.TYPE2 is null and num.TYPE2 is null
			);