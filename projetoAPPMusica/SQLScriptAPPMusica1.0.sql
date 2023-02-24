REM   Script: SQLScriptAPPMusica1.0
REM   Foi implementado a estrutura de modelo físico do projeto banco de dados do APPMusica.
No arquivo contem os Scripts da entidades do Banco de dados.

CREATE TABLE estilo(    
    id_estilo NUMBER (6) NOT NULL,    
    estilo  VARCHAR (20) NOT NULL,    
    CONSTRAINT estilo_pk  PRIMARY KEY(id_estilo)    
) ;

CREATE TABLE    album(    
    id_album    NUMBER(10) NOT NULL,    
    titulo      VARCHAR(120) NOT NULL,    
    ano_lancamento NUMBER(4) ,    
    img_capa     BLOB ,    
    gravadira    VARCHAR(120),    
    CONSTRAINT album_pk PRIMARY KEY (id_album)    
) ;

 CREATE TABLE artista(    
        id_artista    NUMERIC(10) NOT NULL ,    
        nome          VARCHAR(120)   NOT NULL,    
        bibliografia  VARCHAR(2000),    
        pais_id_pais  NUMBER (4) NOT NULL,    
        CONSTRAINT artista_pk PRIMARY KEY(id_artista),    
        CONSTRAINT artista_pais_fk FOREIGN KEY (pais_id_pais)    
            REFERENCES pais (id_pais)    
    ) ;

CREATE TABLE musica(    
    id_musica NUMBER(10) NOT NULL,    
    titulo  VARCHAR(80) NOT NULL,    
    duracao NUMBER(4) NOT NULL,    
    ano     NUMBER (4),    
    lertra CLOB,    
    arquivo BLOB NOT NULL,    
    tags VARCHAR (500),    
    artista_id_artista NUMBER(10),    
    estilo_id_estilo NUMBER(6),    
    CONSTRAINT musica_pk PRIMARY KEY(id_musica),    
    CONSTRAINT  musica_artista_fk FOREIGN KEY(artista_id_artista)    
        REFERENCES artista(id_artista),    
    CONSTRAINT musica_estilo_fk FOREIGN KEY (estilo_id_estilo)    
        REFERENCES estilo(id_estilo)    
)  ;

CREATE TABLE pais(    
id_pais NUMBER(4) NOT NULL,    
nome_pais VARCHAR (30) NOT NULL,    
sigla VARCHAR (3) NOT NULL,    
CONSTRAINT pais_pk PRIMARY KEY (id_pais)    
)  ;

CREATE TABLE rel_musica_album (    
  musica_id_musica NUMBER (20) NOT NULL,    
  album_id_album NUMBER (10) NOT NULL,    
  ordem_musica NUMBER (4) NOT NULL, 
  album_id_album  NUMBER(10) NOT NULL, 
  musica_id_musica NUMBER (20) NOT NULL, 
  CONSTRAINT rel_musica_album_album_fk FOREIGN KEY(album_id_album)    
  REFERENCES album(id_album),    
  CONSTRAINT  rel_musica_album_musica_fk FOREIGN KEY(musica_id_musica)    
  REFERENCES musica(id_musica)    
);

CREATE TABLE plano( 
  id_plano NUMBER(4) NOT NULL, 
  titulo VARCHAR2(20) NOT NULL, 
  decricao VARCHAR2(150), 
  valor NUMBER(6,2) NOT NULL, 
  vigencia NUMBER(3) NOT NULL, 
  CONSTRAINT plano_pk PRIMARY KEY(id_plano)     
);

CREATE TABLE usuario( 
  id_usuario NUMBER (10) NOT NULL, 
  email VARCHAR2(50) NOT NULL, 
  senha VARCHAR2(30) NOT NULL, 
  nome VARCHAR2(80) NOT NULL, 
  foto BLOB, 
  id_usuario_resp NUMBER(10), 
  plano_id_plano NUMBER(4) NOT NULL, 
  CONSTRAINT usuario_pk PRIMARY KEY(id_usuario), 
  CONSTRAINT id_reponsavel  FOREIGN KEY(id_usuario_resp) 
  REFERENCES usuario(id_usuario), 
  CONSTRAINT usuario_plano_fk FOREIGN KEY(plano_id_plano) 
  REFERENCES plano(id_plano) 
  );

CREATE TABLE cobranca ( 
  id_cobranca NUMBER(10) NOT NULL, 
  data_pgto DATE NOT NULL, 
  valor NUMBER(6,2) NOT NULL, 
  final_cartao NUMBER(4) NOT NULL, 
  usuario_id_usuario NUMBER(10) NOT NULL, 
  plano_id_plano NUMBER(4) NOT NULL, 
  CONSTRAINT cobranca_pk PRIMARY KEY(id_cobranca), 
  CONSTRAINT cobranca_usuario_fk FOREIGN KEY(usuario_id_usuario) 
  REFERENCES usuario(id_usuario), 
  CONSTRAINT cobranca_plano_fk FOREIGN KEY(plano_id_plano), 
  REFERENCES cobranca(id_plano) 
);

CREATE TABLE cartao_credito( 
  id_cartao NUMBER(10) NOT NULL, 
  nome_impresso VARCHAR2(30) NOT NULL, 
  numero NUMBER(16) NOT NULL, 
  validade_mes NUMBER2(2) NOT NULL, 
  validade_ano NUMBER(4) NOT NULL, 
  usuario_id_usuario NUMBER(10) NOT NULL, 
  CONSTRAINT cartao_credito_pk PRIMARY KEY(id_cartao), 
  CONSTRAINT cartao_credito_usuario_fk FOREIGN KEY(usuario_id_usuario) 
  REFERENCES cartao_credito(id_usuario), 
);

CREATE TABLE lista_reprod( 
  id_lista NUMBER(10) NOT NULL, 
  nome_lista VARCHAR2(20) NOT NULL, 
  usuario_is_usuario NUMBER(10) NOT NULL, 
  CONSTRAINT lista_reprod_pk PRIMARY KEY(id_lista), 
  CONSTRAINT lista_reprod_usuario_Fk FOREIGN KEY(usuario_id_usuario) 
  REFERENCES lista_reprod(id_usuario) 
  );

CREATE TABLE rel_lista_musica( 
  ordem_musica NUMBER(4) NOT NULL, 
  musica_id_musica NUMBER(20) NOT NULL, 
  lista_reprod_id_lista NUMBER(10) NOT NULL, 
  CONSTRAINT musica_fk FOREIGN KEY(musica_id_musica) 
  REFERENCES musica(id_musica), 
  CONSTRAINT lista_reprod_fk FOREIGN KEY(lista_rerpod_id_lista) 
  REFERENCES lista_reprod(id_lista) 
);

