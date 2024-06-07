create extension postgis;

create table if not exists complex_sportiv(
	fid serial primary key,
	nume varchar (100) not null,
	geom geometry ('Polygon', 4326) not null
);

create table if not exists eveniment_sportiv(
	fid serial primary key,
	tip_eveniment varchar (100) not null,
	data date null
);

create table evenimente_complex(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	eveniment_sportiv_fid integer not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid),
	foreign key(eveniment_sportiv_fid) references eveniment_sportiv(fid)
);

create table if not exists piste_alergat(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	numar_piste integer not null,
	lungime_piste integer not null,
	latime_piste integer not null,
	geom geometry ('LineString', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists retea_utilitati(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	tip_utilitate smallint not null,
	geom geometry ('LineString', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists puncte_resurse(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	tip_resurse varchar not null,
	contra_cost bool not null,
	geom geometry ('Point', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists cladiri(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	deservire_cladire varchar not null,
	capacitate_sportivi_personal int null,
	geom geometry ('Point', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists terenuri(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	tip_teren varchar not null,
	orar date not null,
	geom geometry ('Polygon', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists muzeu_trofee(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	nume_competite_castgata varchar not null,
	sport_competite_castgata varchar null,
	loc_obtinut smallint not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);