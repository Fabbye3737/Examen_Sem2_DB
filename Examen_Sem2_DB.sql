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
	tip_utilitate varchar(100) not null,
	geom geometry ('LineString', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists puncte_resurse(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	tip_resurse varchar(100) not null,
	contra_cost bool not null,
	geom geometry ('Point', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists cladiri(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	deservire_cladire varchar(100) not null,
	capacitate_sportivi_personal integer null,
	geom geometry ('Point', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists terenuri(
	fid serial primary key,
	complex_sportiv_fid integer not null,
	tip_teren varchar(100) not null,
	orar date not null,
	geom geometry ('Polygon', 4326) not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

create table if not exists muzeu_trofee(
	fid serial primary key,
	complex_sportiv_fid integer not null unique,
	nume_competite varchar(100) not null,
	sport_competite varchar(100) null,
	loc_obtinut smallint not null,
	foreign key(complex_sportiv_fid) references complex_sportiv(fid)
);

select nume, ST_Area(geom) as Area from complex_sportiv;
select nume, ST_Perimeter(geom) as Perimeter from complex_sportiv;
select fid, nume, ST_Centroid(geom) as Centroid from complex_sportiv;

select ST_Length(geom) as length from piste_alergat;
select complex_sportiv_fid, numar_piste, ST_Centroid(geom) as Centroid from piste_alergat;

select fid, complex_sportiv_fid, ST_Length(geom) as length from retea_utilitati;
select tip_utilitate, ST_Centroid(geom) as Centroid from retea_utilitati;

select fid, complex_sportiv_fid, ST_Astext(geom) as location from puncte_resurse;
select tip_resurse, contra_cost, ST_Astext(geom) as location from puncte_resurse where contra_cost = true;
select tip_resurse, ST_Buffer(geom, 0.2) from puncte_resurse;
select ST_X(geom) X, ST_Y(geom) Y from puncte_resurse;

select ST_Centroid(geom) as Centroid from cladiri;
select deservire_cladire, ST_Buffer(geom, 0.5) from cladiri;

select fid, ST_Area(geom) as area from terenuri;
select complex_sportiv_fid, tip_teren, ST_Perimeter(geom) as perimeter from terenuri;