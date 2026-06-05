```sql
-- Especificação do tipo T_ARTISTA
CREATE OR REPLACE TYPE T_ARTISTA AS OBJECT (
    nome_artistico  VARCHAR2(100),
    genero          VARCHAR2(50),
    pais_origem     VARCHAR2(50),
    ano_inicio      NUMBER(4),
    biografia       VARCHAR2(500),
    MEMBER FUNCTION get_descricao RETURN VARCHAR2
);
/

-- Corpo do tipo T_ARTISTA
CREATE OR REPLACE TYPE BODY T_ARTISTA AS
    MEMBER FUNCTION get_descricao RETURN VARCHAR2 IS
    BEGIN
        RETURN nome_artistico || ' (' || genero || ', ' || pais_origem || ', desde ' || ano_inicio || ')';
    END get_descricao;
END;
/

-- Especificação do tipo T_ALBUM
CREATE OR REPLACE TYPE T_ALBUM AS OBJECT (
    titulo          VARCHAR2(150),
    ano_lancamento  NUMBER(4),
    gravadora       VARCHAR2(100),
    artista         T_ARTISTA,
    MEMBER FUNCTION get_descricao RETURN VARCHAR2
);
/

-- Corpo do tipo T_ALBUM
CREATE OR REPLACE TYPE BODY T_ALBUM AS
    MEMBER FUNCTION get_descricao RETURN VARCHAR2 IS
    BEGIN
        RETURN titulo || ' - ' || artista.nome_artistico || ' (' || ano_lancamento || ')';
    END get_descricao;
END;
/

-- Especificação do tipo T_FAIXA
CREATE OR REPLACE TYPE T_FAIXA AS OBJECT (
    titulo          VARCHAR2(150),
    duracao_seg     NUMBER(5),
    num_faixa       NUMBER(3),
    MEMBER FUNCTION get_duracao_formatada RETURN VARCHAR2
);
/

-- Corpo do tipo T_FAIXA
CREATE OR REPLACE TYPE BODY T_FAIXA AS
    MEMBER FUNCTION get_duracao_formatada RETURN VARCHAR2 IS
        minutos NUMBER;
        segundos NUMBER;
    BEGIN
        minutos  := FLOOR(duracao_seg / 60);
        segundos := MOD(duracao_seg, 60);
        RETURN LPAD(minutos, 2, '0') || ':' || LPAD(segundos, 2, '0');
    END get_duracao_formatada;
END;
/

-- Sinônimo público para T_ARTISTA
CREATE PUBLIC SYNONYM T_ARTISTA FOR T_ARTISTA;
/

-- Sinônimo público para T_ALBUM
CREATE PUBLIC SYNONYM T_ALBUM FOR T_ALBUM;
/

-- Sinônimo público para T_FAIXA
CREATE PUBLIC SYNONYM T_FAIXA FOR T_FAIXA;
/

-- Descreve a estrutura do tipo T_ARTISTA
DESC T_ARTISTA

-- Descreve a estrutura do tipo T_ALBUM
DESC T_ALBUM

-- Descreve a estrutura do tipo T_FAIXA
DESC T_FAIXA

-- Tabela de objeto: cada linha É um objeto T_ARTISTA
CREATE TABLE TB_ARTISTA OF T_ARTISTA (
    nome_artistico NOT NULL
);

-- Tabela relacional com coluna de objeto T_ALBUM
CREATE TABLE TB_ALBUM (
    id_album    NUMBER PRIMARY KEY,
    album_obj   T_ALBUM
);

-- Tabela com coluna de objeto T_FAIXA e REF para TB_ARTISTA
CREATE TABLE TB_FAIXA (
    id_faixa        NUMBER PRIMARY KEY,
    faixa_obj       T_FAIXA,
    ref_artista     REF T_ARTISTA SCOPE IS TB_ARTISTA
);

INSERT INTO TB_ARTISTA VALUES (
    T_ARTISTA('Criolo', 'Hip-Hop', 'Brasil', 2006,
    'Rapper e cantor paulistano, um dos maiores nomes do hip-hop brasileiro.')
);

INSERT INTO TB_ARTISTA VALUES (
    T_ARTISTA('Alceu Valença', 'Forró', 'Brasil', 1972,
    'Cantor e compositor pernambucano, ícone da música nordestina.')
);

-- Em tabelas de objeto, a inserção sempre usa o construtor do tipo.
-- Para inserir especificando atributos, utiliza-se a seguinte forma alternativa:
INSERT INTO TB_ARTISTA (nome_artistico, genero, pais_origem, ano_inicio, biografia)
    VALUES ('Luedji Luna', 'Soul/MPB', 'Brasil', 2012,
    'Cantora baiana com trabalhos autorais de soul music e MPB.');

INSERT INTO TB_ALBUM VALUES (
    1,
    T_ALBUM('Nó na Orelha', 2011, ' Oloko Records',
        T_ARTISTA('Criolo', 'Hip-Hop', 'Brasil', 2006, 'Rapper paulistano.'))
);

INSERT INTO TB_ALBUM (id_album, album_obj) VALUES (
    2,
    T_ALBUM('Duas de Cinco', 2014, 'YB Music',
        T_ARTISTA('Alceu Valença', 'Forró', 'Brasil', 1972, 'Ícone nordestino.'))
);

INSERT INTO TB_FAIXA VALUES (
    1,
    T_FAIXA('Bogotá', 215, 1),
    (SELECT REF(a) FROM TB_ARTISTA a WHERE a.nome_artistico = 'Criolo')
);

INSERT INTO TB_FAIXA (id_faixa, faixa_obj, ref_artista) VALUES (
    2,
    T_FAIXA('Subirubirundum', 192, 2),
    (SELECT REF(a) FROM TB_ARTISTA a WHERE a.nome_artistico = 'Criolo')
);

-- Remover artista a partir de condição no atributo do objeto
DELETE FROM TB_ARTISTA WHERE ano_inicio < 1980;

-- Remover álbum a partir de condição
DELETE FROM TB_ALBUM WHERE id_album = 2;

-- Remover faixa a partir de condição
DELETE FROM TB_FAIXA WHERE faixa_obj.num_faixa > 5;

UPDATE TB_ARTISTA SET genero = 'Hip-Hop/Soul'
WHERE nome_artistico = 'Criolo';

UPDATE TB_ARTISTA
SET genero = 'MPB', pais_origem = 'Brasil'
WHERE nome_artistico = 'Luedji Luna';

UPDATE TB_ALBUM SET album_obj.gravadora = 'Universal Music'
WHERE id_album = 1;

UPDATE TB_ALBUM
SET album_obj.titulo = 'Nó na Orelha (Edição Especial)',
    album_obj.ano_lancamento = 2013
WHERE id_album = 1;

UPDATE TB_FAIXA
SET faixa_obj.duracao_seg = faixa_obj.duracao_seg + 10
WHERE faixa_obj.num_faixa = 1;

SELECT * FROM TB_ARTISTA;

SELECT * FROM TB_ALBUM;

SELECT * FROM TB_FAIXA;

-- Executa a função get_descricao do objeto album_obj em TB_ALBUM
SELECT id_album, a.album_obj.get_descricao()
FROM TB_ALBUM a;

SELECT a.album_obj.titulo, a.album_obj.ano_lancamento
FROM TB_ALBUM a
WHERE a.album_obj.ano_lancamento >= 2010;

SELECT VALUE(a) FROM TB_ARTISTA a;

SELECT f.faixa_obj.titulo,
       f.faixa_obj.get_duracao_formatada(),
       f.faixa_obj.num_faixa
FROM TB_FAIXA f
ORDER BY f.faixa_obj.num_faixa;

SELECT f.id_faixa,
       f.faixa_obj.titulo,
       DEREF(f.ref_artista).nome_artistico AS artista,
       DEREF(f.ref_artista).genero AS genero
FROM TB_FAIXA f;

DELETE FROM TB_FAIXA f
WHERE f.faixa_obj.titulo = 'Bogotá';

-- TB_FAIXA possui coluna de objeto (faixa_obj) e coluna REF (ref_artista)
INSERT INTO TB_FAIXA VALUES (
    3,
    T_FAIXA('Convoque Seu Buda', 305, 3),
    (SELECT REF(a) FROM TB_ARTISTA a WHERE a.nome_artistico = 'Criolo')
);
```