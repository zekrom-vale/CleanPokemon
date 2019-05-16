--=REGEXREPLACE(JOIN(", ",A2:A17),"(\w+)","items.$0 ITEM_$0")
/*
This view contains most information about Species
*/
create or replace view mix as(
	select pokemon.NAME, pokemon.DEX, species.CLASS, species.DEX_SUFFIX, species.TYPE, species.TYPE2, species.COLOR, species.CALL_RATE_SM, species.CALL_RATE_USUM, species.STAR, species.CYCLES, species.WEIGHTKG, species.WEIGHTKG*2.20462 as WEIGHTLBS, species.HEIGHT_M, floor(species.HEIGHT_M*3.28084) as HEIGHT_FT, mod(species.HEIGHT_M*39.3701, 12) as HEIGHT_IN,
		--body.*,
body.BODY BODY, body.PARENT BODY_PARENT, body.DESCRIPTION BODY_DESCRIPTION, body.ID BODY_ID,
		--items.*,
items.NAME ITEM, items.GEN ITEM_GEN, items.GEN2 ITEM_GEN2, items.DESCRIPTION ITEM_DESCRIPTION, items.NOTE ITEM_NOTE, items.JAPANESE_KANA ITEM_JAPANESE_KANA, items.JAPANESE_ROMAJI ITEM_JAPANESE_ROMAJI, items.FRENCH ITEM_FRENCH, items.GERMAN ITEM_GERMAN, items.ITALIAN ITEM_ITALIAN, items.SPANISH ITEM_SPANISH, items.KOREAN_HANGUL ITEM_KOREAN_HANGUL, items.KOREAN_ROMANIZED ITEM_KOREAN_ROMANIZED, items.CHINESE_HANZI ITEM_CHINESE_HANZI, items.CHINESE_ROMANIZED ITEM_CHINESE_ROMANIZED, items.STAR ITEM_STAR,
		--eggGroups.*,
eggGroups.NAME EGG_GROUP, eggGroups.TYPE_ALIAS EGG_GROUP_TYPE_ALIAS, eggGroups.URL EGG_GROUP_URL,
		--eggGroups2.*,
eggGroups2.NAME EGG_GROUP2, eggGroups2.TYPE_ALIAS EGG_GROUP2_TYPE_ALIAS, eggGroups2.URL EGG_GROUP2_URL,
		--gender_ratio.*,
gender_ratio.KEY GENDER_RATIO_KEY, gender_ratio.MALE GENDER_RATIO_MALE, gender_ratio.FEMALE GENDER_RATIO_FEMALE, gender_ratio.UNBREEDABLE GENDER_RATIO_UNBREEDABLE,
		--ability.*,
ability.ID ABILITY_ID, ability.NAME ABILITY_NAME, ability.EFFECT ABILITY_EFFECT, ability.GENERATION ABILITY_GENERATION, ability.SINGLE ABILITY_SINGLE, ability.DUAL ABILITY_DUAL, ability.HIDDEN ABILITY_HIDDEN, ability.JAPANESE_KANA ABILITY_JAPANESE_KANA, ability.JAPANESE_ROMAJI ABILITY_JAPANESE_ROMAJI, ability.FRENCH ABILITY_FRENCH, ability.GERMAN ABILITY_GERMAN, ability.ITALIAN ABILITY_ITALIAN, ability.SPANISH ABILITY_SPANISH, ability.KOREAN_HANGUL ABILITY_KOREAN_HANGUL, ability.KOREAN_ROMANIZED ABILITY_KOREAN_ROMANIZED, ability.CHINESE_HANZI ABILITY_CHINESE_HANZI, ability.CHINESE_ROMANIZED ABILITY_CHINESE_ROMANIZED,
		--ability2.*,
ability2.ID ABILITY2_ID, ability2.NAME ABILITY2_NAME, ability2.EFFECT ABILITY2_EFFECT, ability2.GENERATION ABILITY2_GENERATION, ability2.SINGLE ABILITY2_SINGLE, ability2.DUAL ABILITY2_DUAL, ability2.HIDDEN ABILITY2_HIDDEN, ability2.JAPANESE_KANA ABILITY2_JAPANESE_KANA, ability2.JAPANESE_ROMAJI ABILITY2_JAPANESE_ROMAJI, ability2.FRENCH ABILITY2_FRENCH, ability2.GERMAN ABILITY2_GERMAN, ability2.ITALIAN ABILITY2_ITALIAN, ability2.SPANISH ABILITY2_SPANISH, ability2.KOREAN_HANGUL ABILITY2_KOREAN_HANGUL, ability2.KOREAN_ROMANIZED ABILITY2_KOREAN_ROMANIZED, ability2.CHINESE_HANZI ABILITY2_CHINESE_HANZI, ability2.CHINESE_ROMANIZED ABILITY2_CHINESE_ROMANIZED,
		--hidden_ability.*,
hidden_ability.ID HIDDEN_ABILITY_ID, hidden_ability.NAME HIDDEN_ABILITY_NAME, hidden_ability.EFFECT HIDDEN_ABILITY_EFFECT, hidden_ability.GENERATION HIDDEN_ABILITY_GENERATION, hidden_ability.SINGLE HIDDEN_ABILITY_SINGLE, hidden_ability.DUAL HIDDEN_ABILITY_DUAL, hidden_ability.HIDDEN HIDDEN_ABILITY_HIDDEN, hidden_ability.JAPANESE_KANA HIDDEN_ABILITY_JAPANESE_KANA, hidden_ability.JAPANESE_ROMAJI HIDDEN_ABILITY_JAPANESE_ROMAJI, hidden_ability.FRENCH HIDDEN_ABILITY_FRENCH, hidden_ability.GERMAN HIDDEN_ABILITY_GERMAN, hidden_ability.ITALIAN HIDDEN_ABILITY_ITALIAN, hidden_ability.SPANISH HIDDEN_ABILITY_SPANISH, hidden_ability.KOREAN_HANGUL HIDDEN_ABILITY_KOREAN_HANGUL, hidden_ability.KOREAN_ROMANIZED HIDDEN_ABILITY_KOREAN_ROMANIZED, hidden_ability.CHINESE_HANZI HIDDEN_ABILITY_CHINESE_HANZI, hidden_ability.CHINESE_ROMANIZED HIDDEN_ABILITY_CHINESE_ROMANIZED,
		pokemon.PAGE, pokemon.HABITAT, pokemon.LDEX, pokemon.LDEX_SUFFIX, pokemon.IQ_GROUP,
		--generation.*
generation.GEN GENERATION, generation.REGION GENERATION_REGION, generation.DEX_MIN GENERATION_DEX_MIN, generation.DEX_MAX GENERATION_DEX_MAX, generation.LDEX_MIN GENERATION_LDEX_MIN, generation.LDEX_MAX GENERATION_LDEX_MAX
	from
	species inner join pokemon
		on species.DEX=pokemon.DEX
	left join eggGroups
		on species.EGGGROUP1=eggGroups.NAME
	left join eggGroups eggGroups2
		on species.EGGGROUP2=eggGroups2.NAME
	left join body
		on species.BODY=body.BODY
	inner join gender_ratio
		on species.GENDER_RATIO=gender_ratio.key
	inner join ability
		on species.ABILITY1=ability.NAME
	left join ability ability2
		on species.ABILITY2=ability.NAME
	left join ability hidden_ability
		on species.HIDDEN_ABILITY=ability.NAME
	inner join generation
		on pokemon.GEN=generation.GEN
	left join items
		on species.ITEM=items.NAME
);
/*
This table contains JSON arrays of Super Effective, Not Very Effective, and Not Effective
moves for each defending type
*/
create or replace view typeDEF as(
	select Types.TYPE DEF, SE.ATK SE, NVE.ATK NVE, NE.ATK NE
	from
		Types
		full outer join
		(
			select DEF, json_arrayagg(ATK) ATK
			from SE
			group by DEF
		) SE
			on Types.TYPE=SE.DEF
		full outer join
		(
			select DEF, json_arrayagg(ATK) ATK
			from NVE
			group by DEF
		) NVE
			on Types.TYPE=NVE.DEF
		full outer join
		(
			select DEF, json_arrayagg(ATK) ATK
			from NE
			group by DEF
		) NE
			on Types.TYPE=NE.DEF
);

/*
This table contains JSON arrays of Super Effective, Not Very Effective, and Not Effective
moves for each attacking type
*/
create or replace view typeATK as(
	select Types.TYPE ATK, SE.DEF SE, NVE.DEF NVE, NE.DEF NE
	from
		Types
		full outer join
		(
			select ATK, json_arrayagg(DEF) DEF
			from SE
			group by ATK
		) SE
			on Types.TYPE=SE.ATK
		full outer join
		(
			select ATK, json_arrayagg(DEF) DEF
			from NVE
			group by ATK
		) NVE
			on Types.TYPE=NVE.ATK
		full outer join
		(
			select ATK, json_arrayagg(DEF) DEF
			from NE
			group by ATK
		) NE
			on Types.TYPE=NE.ATK
);

/*
Union SE, NVE, and NE together and create a column called effect (SE 2, NVE .5, NE 0)
*/
create or replace view longType as(
	select ATK, DEF, 2 as effect
	from SE
	UNION
	select ATK, DEF, .5 as effect
	from NVE
	UNION
	select ATK, DEF, 0 as effect
	from NE
);
/*
Union longType and the following sub-query together
	Intersect the following sub-query and longType
		select DEF and ATK
		from the cross of Type with itself
*/
create or replace view longTypeAll as(
	select ATK, DEF, effect
	from longType
	UNION
	select ATK, DEF, 1 as effect
	from(
		select DEF.TYPE DEF, ATK.TYPE ATK
		from Types DEF cross join Types ATK
		INTERSECT
		select ATK, DEF
		from longType
	)
);

/*
Create a utility table determining dule type interactions
This is intended to be static and therefore is a table
*/
create table typeInt(
	T1 number,
	T2 number,
	R number,
	CONSTRAINT pk_typeInt primary key(T1, T2)
);
insert into typeInt(T1, T2, R)values(0,0,0);
insert into typeInt(T1, T2, R)values(0,.5,0);
insert into typeInt(T1, T2, R)values(0,1,0);
insert into typeInt(T1, T2, R)values(0,2,0);

insert into typeInt(T1, T2, R)values(.5,0,0);
insert into typeInt(T1, T2, R)values(.5,1,.25);
insert into typeInt(T1, T2, R)values(.5,.5,.25);
insert into typeInt(T1, T2, R)values(.5,2,1);

insert into typeInt(T1, T2, R)values(1,0,0);
insert into typeInt(T1, T2, R)values(1,.5,.25);
insert into typeInt(T1, T2, R)values(1,2,2);
insert into typeInt(T1, T2, R)values(1,1,1);

insert into typeInt(T1, T2, R)values(2,0,0);
insert into typeInt(T1, T2, R)values(2,1,2);
insert into typeInt(T1, T2, R)values(2,.5,1);
insert into typeInt(T1, T2, R)values(2,2,4);

create or replace view duleTypeDEF as(
	select longTypeALL.ATK, longTypeALL.DEF TYPE, longTypeALL2.DEF TYPE2, typeInt.R effect
	from
		longTypeALL inner join longTypeALL longTypeALL2 on longTypeALL.ATK=longTypeALL2.ATK
		inner join typeInt
			on longTypeALL.effect=typeInt.T1 and longTypeALL2.effect=typeInt.T2
	where longTypeALL.DEF!=longTypeALL2.DEF
	-- Need make sure no Pokemon has duplicate types
	UNION
	select longTypeALL.ATK, longTypeALL.DEF TYPE, NULL TYPE2, 1 effect
	from longTypeALL
);