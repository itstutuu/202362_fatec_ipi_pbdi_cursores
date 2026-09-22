-- Active: 1788268286026@@localhost@5433@yt_channels
-- 1 database pro semestre inteiro
CREATE TABLE tb_top_youtubers(
	cod_top_youtubers SERIAL PRIMARY KEY,
	rank INT NULL,
	youtuber VARCHAR(200) NULL,
	subscribers INT NULL,
	video_views INT NULL,
	video_count INT NULL,
	category VARCHAR(200) NULL,
	started INT NULL
);

ALTER TABLE tb_top_youtubers
	ALTER COLUMN video_views TYPE BIGINT;

SELECT * FROM tb_top_youtubers;

-- Cursores - iterar as linhas da tabela para mostrar youtubers, fzd uma projeção da coluna
DO $$
DECLARE
	-- 1. Decalração do cursor (unbound)
	cur_nomes_youtubers REFCURSOR;
	v_youtuber VARCHAR(200);
BEGIN
	-- 2. abertura do cursor
	OPEN cur_nomes_youtubers FOR
		SELECT youtuber
			FROM
			tb_top_youtubers;
	LOOP
		3. 
		FETCH cur_nomes_youtubers INTO v_youtubers
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	CLOSE cur_nomes_youtubers;
END;
$$

-- cursor não vinculado de query dinâmica
-- exibindo noems de youtubers que começaram a partir de um nome específico
DO $$
DECLARE
	-- 1. Declaração
	cur_nomes_a_partir_de REFCURSOR;
	v_youtuber VARCHAR(200);
	v_ano INT := 2008;
	v_nome_tabela VARCHAR(200) := 'tb_top_youtuebrs';
BEGIN
	2. Abertura
	OPEN cur_nomes_a_partir_de FOR EXECUTE
	format(
		'SELECT youtuber FROM %s WHERE started >= $1',
		v_nome_tabela
	)
	USING v_ano;
	LOOP
		-- 3. Recuperação de dados
		FETCH cur_nomes_a_partir_de INTO v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	-- 4. Fechamento
	CLOSE cur_nomes_a_partir_de;
END;
$$

-- Cursores vinculados e não vinculados; dinâmicas e não dinâmicas.