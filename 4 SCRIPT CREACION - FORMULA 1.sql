create database bd_formula1;
GO

use bd_formula1;
go

	CREATE TABLE tb_direccion(
		cod_direccion numeric(10) NOT NULL,
		tipo_via varchar(25) NOT NULL DEFAULT 'CALLE',
		nombre_via varchar(100) NOT NULL,
		numero_via numeric(3) NULL,
		codigo_postal numeric(5) NOT NULL,
		municipio varchar(100) NOT NULL,
		ciudad varchar(50) NOT NULL,
		pais varchar(50) NOT NULL,

		constraint pk_tbdir_coddir PRIMARY KEY (cod_direccion),
		constraint uq_tbdir_coddir UNIQUE (cod_direccion),
		constraint ck_tbdir_tipvia CHECK (tipo_via IN ('CALLE', 'AVENIDA', 'PLAZA', 'CARRETERA')),
		constraint ck_tbdir_pais CHECK (pais IN ('ESPAÑA', 'BÉLGICA', 'ITALIA', 'USA', 'FRANCIA', 'AUSTRIA', 'AUSTRALIA', 'JAPÓN', 'ARABIA SAUDI', 'BRASIL')),
);

		CREATE TABLE tb_pilotos(
			superlicencia numeric(5) NOT NULL,
			nombre_piloto varchar(50) NOT NULL,
			apellido1_piloto varchar(50) NOT NULL,
			apellido2_piloto varchar(50) NULL,
			peso decimal(3,1) NOT NULL,
			altura_cm numeric(3) NOT NULL,
			num_carreras numeric(4) NOT NULL,
			num_victorias numeric(3) NOT NULL,

			constraint pk_tbpil_super PRIMARY KEY (superlicencia),
			constraint uq_tbpil_super UNIQUE (superlicencia),
);	

create table tb_gran_premio(
id_gp varchar(5) not null,
ano_creacion_gp date not null,
fecha_carrera date not null,
num_ganadores numeric(3) not null,

constraint pk_tbgp_idgp primary key (id_gp),
constraint uq_tbgp_idgp unique (id_gp),
);

create table tb_circuitos(
id_circuito varchar(5) not null,
nombre_circuito varchar(50) not null,
cod_direccion numeric(10) NOT NULL,
num_vueltas numeric(2) not null,
km_circuitos decimal(4,3) not null,
vuelta_rapida time not null,
num_aforo numeric(5)  not null,

constraint pk_tbcir_idcir primary key (id_circuito),
constraint uq_tbcir_idcir unique(id_circuito),
constraint fk_tbcir_tbdir_codcir foreign key (cod_direccion) references tb_direccion (cod_direccion),
constraint ck_tbcir_idcir CHECK(id_circuito LIKE ('[A-Z][A-Z]-[0-9][0-9]')),
);

	CREATE TABLE tb_motoristas(
		id_motor varchar(5) NOT NULL,
		marca varchar(20) NOT NULL,
		potencia_cv numeric(3) NOT NULL,
		num_componentes numeric(2) NOT NULL,
		fecha_entrega date NOT NULL,

		constraint pk_tbmot_idmot PRIMARY KEY (id_motor),
		constraint uq_tbmot_idmot UNIQUE (id_motor),
		constraint ck_tbmot_marca CHECK(marca IN ('MERCEDES', 'HONDA', 'FERRARI', 'RENAULT', 'AUDI')),
	);

	CREATE TABLE tb_escuderias(
		id_escuderia varchar(5) NOT NULL,
		id_motor varchar(5) NOT NULL,
		nombre_escuderia varchar (50) NOT NULL,
		nombre_jefe varchar(50) NOT NULL,
		ano_creacion date NOT NULL,
		num_pilotos numeric(1) NOT NULL,

		constraint pk_tbesc_idesc PRIMARY KEY(id_escuderia),
		constraint uq_tbesc_idesc_nomesc UNIQUE (id_escuderia, nombre_escuderia),
		constraint fk_tbesc_idmot FOREIGN KEY (id_motor) references tb_motoristas (id_motor),
	);

	CREATE TABLE tb_piloto_escuderia_circuito_participa_gran_premio(
		superlicencia numeric(5) NOT NULL,
		id_gp varchar(5) not null,
		id_circuito varchar(5) not null,
		id_escuderia varchar(5) NOT NULL,

		constraint pk_tbpilesccirpartgp_superidgpidciridesc PRIMARY KEY (superlicencia, id_gp, id_circuito, id_escuderia),
		constraint uq_tbpilesccirpartgp_superidgpidciridesc UNIQUE (superlicencia, id_gp, id_circuito, id_escuderia),
		constraint fk_tbpilesccirpartgp_tbpil_super FOREIGN KEY (superlicencia) references tb_pilotos (superlicencia),
		constraint fk_tbpilesccirpartgp_tbgp_idgp FOREIGN KEY (id_gp) references tb_gran_premio (id_gp),
		constraint fk_tbpilesccirpartgp_tbpcir_idcir FOREIGN KEY (id_circuito) references tb_circuitos (id_circuito),
		constraint fk_tbpilesccirpartgp_tbesc_idesc FOREIGN KEY (id_escuderia) references tb_escuderias (id_escuderia),
	);
	go
