--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-12 19:54:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 258 (class 1255 OID 17275)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

BEGIN
		existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_id);
	if(existe <= 0) then
		existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
	if(existe <= 0) then
		raise exception 'não foi possível encontrar o id e pk da pessoa para realizar a associação do cadastro';
	end if;
	end if;
END;
$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 17280)
-- Name: validachavepessoaforn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoaforn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

BEGIN
		existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id);
	if(existe <= 0) then
		existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
	if(existe <= 0) then
		raise exception 'não foi possível encontrar o id e pk da pessoa para realizar a associação do cadastro';
	end if;
	end if;
END;
$$;


ALTER FUNCTION public.validachavepessoaforn() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 257 (class 1259 OID 17262)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 17247)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16868)
-- Name: avaliacao_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avaliacao_produto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avaliacao_produto_seq OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16552)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    name_descricacao character varying(100) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16916)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    data_pagamento date,
    data_vencimento date NOT NULL,
    descricao character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_total numeric(38,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    CONSTRAINT conta_pagar_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying, 'ALUGUEL'::character varying, 'FUNCIONARIO'::character varying, 'NEGOCIADA'::character varying, 'CANCELADA'::character varying])::text[])))
);


ALTER TABLE public.conta_pagar OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16939)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    data_pagamento date,
    data_vencimento date NOT NULL,
    descricao character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_total numeric(38,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    CONSTRAINT conta_receber_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying])::text[])))
);


ALTER TABLE public.conta_receber OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16640)
-- Name: conta_receber_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conta_receber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conta_receber_seq OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17030)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cup_desc (
    id bigint NOT NULL,
    cod_descricao character varying(255) NOT NULL,
    data_validade date NOT NULL,
    valor_porcentagem_desconto numeric(38,2),
    valor_real_desconto numeric(38,2)
);


ALTER TABLE public.cup_desc OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16985)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logradouro character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    CONSTRAINT endereco_tipo_endereco_check CHECK (((tipo_endereco)::text = ANY ((ARRAY['COBRANCA'::character varying, 'ENTREGA'::character varying])::text[])))
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16603)
-- Name: endereco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.endereco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.endereco_seq OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17008)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17013)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17035)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda_loja (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virtual_id bigint NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17040)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    name_desc character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17045)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_icms numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    id_conta_pagar bigint NOT NULL,
    id_pessoa bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17083)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_venda (
    id bigint NOT NULL,
    numero_nota_fiscal character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virtual_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16791)
-- Name: nota_fiscal_venda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nota_fiscal_venda_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nota_fiscal_venda_seq OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16760)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17090)
-- Name: pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL
);


ALTER TABLE public.pessoa OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17097)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_fisica (
    cpf character varying(255) NOT NULL,
    data_nascimento date,
    id bigint NOT NULL
);


ALTER TABLE public.pessoa_fisica OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17102)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_juridica (
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    inscricao_estadual character varying(255) NOT NULL,
    inscricao_municipal character varying(255),
    nome_fantazia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17109)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    alerta_quantidade_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_you_tube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    quantidade_alerta_estoque integer,
    quantidade_clique integer,
    quantidade_estoque integer NOT NULL,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(38,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16604)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_acesso OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16605)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_categoria_produto OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16675)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_conta_pagar OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16691)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_cup_desc OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16666)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_forma_pagamento OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16736)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_imagem_produto OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16852)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_item_venda_loja OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16606)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_marca_produto OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16749)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16765)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_nota_item_produto OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16607)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_pessoa OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16697)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_produto OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16801)
-- Name: seq_venda_compra_loja_virtual; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_venda_compra_loja_virtual
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_venda_compra_loja_virtual OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16776)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_id bigint,
    venda_compra_loja_virtual_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16783)
-- Name: status_rastreio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.status_rastreio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_rastreio_seq OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17116)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16596)
-- Name: usuario_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuario_acesso OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16608)
-- Name: usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_seq OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17123)
-- Name: venda_compra_loja_virtual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venda_compra_loja_virtual (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(38,2),
    valor_frete numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    cupom_desconto_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.venda_compra_loja_virtual OWNER TO postgres;

--
-- TOC entry 5123 (class 0 OID 17262)
-- Dependencies: 257
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5122 (class 0 OID 17247)
-- Dependencies: 256
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5083 (class 0 OID 16552)
-- Dependencies: 217
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5106 (class 0 OID 16916)
-- Dependencies: 240
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5107 (class 0 OID 16939)
-- Dependencies: 241
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5111 (class 0 OID 17030)
-- Dependencies: 245
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5108 (class 0 OID 16985)
-- Dependencies: 242
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5109 (class 0 OID 17008)
-- Dependencies: 243
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5110 (class 0 OID 17013)
-- Dependencies: 244
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5112 (class 0 OID 17035)
-- Dependencies: 246
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5113 (class 0 OID 17040)
-- Dependencies: 247
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5114 (class 0 OID 17045)
-- Dependencies: 248
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5115 (class 0 OID 17083)
-- Dependencies: 249
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5098 (class 0 OID 16760)
-- Dependencies: 232
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5116 (class 0 OID 17090)
-- Dependencies: 250
-- Data for Name: pessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5117 (class 0 OID 17097)
-- Dependencies: 251
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5118 (class 0 OID 17102)
-- Dependencies: 252
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5119 (class 0 OID 17109)
-- Dependencies: 253
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5100 (class 0 OID 16776)
-- Dependencies: 234
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5120 (class 0 OID 17116)
-- Dependencies: 254
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5084 (class 0 OID 16596)
-- Dependencies: 218
-- Data for Name: usuario_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5121 (class 0 OID 17123)
-- Dependencies: 255
-- Data for Name: venda_compra_loja_virtual; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 239
-- Name: avaliacao_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avaliacao_produto_seq', 1, false);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 225
-- Name: conta_receber_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conta_receber_seq', 1, false);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 219
-- Name: endereco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endereco_seq', 1, false);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 236
-- Name: nota_fiscal_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nota_fiscal_venda_seq', 1, false);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 220
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 221
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 227
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cup_desc', 1, false);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_forma_pagamento', 1, false);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 230
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 222
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 231
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 223
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 229
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_venda_compra_loja_virtual; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_venda_compra_loja_virtual', 1, false);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 235
-- Name: status_rastreio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.status_rastreio_seq', 1, false);


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 224
-- Name: usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_seq', 1, false);


--
-- TOC entry 4896 (class 2606 OID 17266)
-- Name: acesso acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 4894 (class 2606 OID 17251)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 16556)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 16923)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 16946)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 4868 (class 2606 OID 17034)
-- Name: cup_desc cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 4862 (class 2606 OID 16992)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 17012)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 2606 OID 17019)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 2606 OID 17039)
-- Name: item_venda_loja item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 17044)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4874 (class 2606 OID 17051)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 4876 (class 2606 OID 17089)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 4854 (class 2606 OID 16764)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 17101)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 4884 (class 2606 OID 17108)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 17096)
-- Name: pessoa pessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 17115)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 16782)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 17131)
-- Name: venda_compra_loja_virtual ukc30agr0qfwruqaoymp4chk2h1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT ukc30agr0qfwruqaoymp4chk2h1 UNIQUE (nota_fiscal_venda_id);


--
-- TOC entry 4878 (class 2606 OID 17129)
-- Name: nota_fiscal_venda uklwo38kb0aaxboalphfjlan8qr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT uklwo38kb0aaxboalphfjlan8qr UNIQUE (venda_compra_loja_virtual_id);


--
-- TOC entry 4852 (class 2606 OID 16600)
-- Name: usuario_acesso unique_usuario_acesso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT unique_usuario_acesso UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 4888 (class 2606 OID 17122)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 17127)
-- Name: venda_compra_loja_virtual venda_compra_loja_virtual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT venda_compra_loja_virtual_pkey PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2620 OID 17278)
-- Name: conta_pagar validachavepessoaavaliacaocontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4926 (class 2620 OID 17283)
-- Name: conta_receber validachavepessoaavaliacaocontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4928 (class 2620 OID 17285)
-- Name: endereco validachavepessoaavaliacaocontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4930 (class 2620 OID 17287)
-- Name: nota_fiscal_compra validachavepessoaavaliacaocontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4932 (class 2620 OID 17289)
-- Name: usuario validachavepessoaavaliacaocontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4934 (class 2620 OID 17291)
-- Name: venda_compra_loja_virtual validachavepessoaavaliacaocontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar BEFORE UPDATE ON public.venda_compra_loja_virtual FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4923 (class 2620 OID 17279)
-- Name: conta_pagar validachavepessoaavaliacaocontapagar1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar1 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4927 (class 2620 OID 17284)
-- Name: conta_receber validachavepessoaavaliacaocontapagar1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar1 BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4929 (class 2620 OID 17286)
-- Name: endereco validachavepessoaavaliacaocontapagar1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar1 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4931 (class 2620 OID 17288)
-- Name: nota_fiscal_compra validachavepessoaavaliacaocontapagar1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar1 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4933 (class 2620 OID 17290)
-- Name: usuario validachavepessoaavaliacaocontapagar1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar1 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4935 (class 2620 OID 17292)
-- Name: venda_compra_loja_virtual validachavepessoaavaliacaocontapagar1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagar1 BEFORE INSERT ON public.venda_compra_loja_virtual FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4924 (class 2620 OID 17281)
-- Name: conta_pagar validachavepessoaavaliacaocontapagarforn; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagarforn BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoaforn();


--
-- TOC entry 4925 (class 2620 OID 17282)
-- Name: conta_pagar validachavepessoaavaliacaocontapagarforn1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaocontapagarforn1 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public.validachavepessoaforn();


--
-- TOC entry 4936 (class 2620 OID 17276)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4937 (class 2620 OID 17277)
-- Name: avaliacao_produto validachavepessoaavaliacaoproduto1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto1 BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public.validachavepessoa();


--
-- TOC entry 4902 (class 2606 OID 17142)
-- Name: conta_pagar fk_conta_receber_pessoa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT fk_conta_receber_pessoa FOREIGN KEY (pessoa_id) REFERENCES public.pessoa(id);


--
-- TOC entry 4904 (class 2606 OID 17152)
-- Name: conta_receber fk_conta_receber_pessoa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT fk_conta_receber_pessoa FOREIGN KEY (pessoa_id) REFERENCES public.pessoa(id);


--
-- TOC entry 4903 (class 2606 OID 17147)
-- Name: conta_pagar fk_conta_receber_pessoa_forn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT fk_conta_receber_pessoa_forn FOREIGN KEY (pessoa_forn_id) REFERENCES public.pessoa(id);


--
-- TOC entry 4914 (class 2606 OID 17217)
-- Name: venda_compra_loja_virtual fk_cupom_desconto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT fk_cupom_desconto FOREIGN KEY (cupom_desconto_id) REFERENCES public.cup_desc(id);


--
-- TOC entry 4915 (class 2606 OID 17222)
-- Name: venda_compra_loja_virtual fk_endereco_cobranca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT fk_endereco_cobranca FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 4916 (class 2606 OID 17227)
-- Name: venda_compra_loja_virtual fk_endereco_entrega; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT fk_endereco_entrega FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 4917 (class 2606 OID 17232)
-- Name: venda_compra_loja_virtual fk_forma_pagamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT fk_forma_pagamento FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 4906 (class 2606 OID 17162)
-- Name: imagem_produto fk_imagem_produto_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT fk_imagem_produto_produto FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4899 (class 2606 OID 17072)
-- Name: nota_item_produto fk_nota_fiscal_compra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT fk_nota_fiscal_compra FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 4909 (class 2606 OID 17062)
-- Name: nota_fiscal_compra fk_nota_fiscal_compra_conta_pagar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT fk_nota_fiscal_compra_conta_pagar FOREIGN KEY (id_conta_pagar) REFERENCES public.conta_pagar(id);


--
-- TOC entry 4910 (class 2606 OID 17177)
-- Name: nota_fiscal_compra fk_nota_fiscal_compra_pessoa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT fk_nota_fiscal_compra_pessoa FOREIGN KEY (id_pessoa) REFERENCES public.pessoa(id);


--
-- TOC entry 4918 (class 2606 OID 17237)
-- Name: venda_compra_loja_virtual fk_nota_fiscal_venda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT fk_nota_fiscal_venda FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 4919 (class 2606 OID 17242)
-- Name: venda_compra_loja_virtual fk_pessoa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venda_compra_loja_virtual
    ADD CONSTRAINT fk_pessoa FOREIGN KEY (pessoa_id) REFERENCES public.pessoa(id);


--
-- TOC entry 4920 (class 2606 OID 17252)
-- Name: avaliacao_produto fk_pessoa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT fk_pessoa FOREIGN KEY (pessoa_id) REFERENCES public.pessoa(id);


--
-- TOC entry 4907 (class 2606 OID 17167)
-- Name: item_venda_loja fk_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4900 (class 2606 OID 17187)
-- Name: nota_item_produto fk_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4921 (class 2606 OID 17257)
-- Name: avaliacao_produto fk_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 4897 (class 2606 OID 17267)
-- Name: usuario_acesso fk_usuario_acesso_acesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT fk_usuario_acesso_acesso FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 4898 (class 2606 OID 17212)
-- Name: usuario_acesso fk_usuario_acesso_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT fk_usuario_acesso_usuario FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 4908 (class 2606 OID 17172)
-- Name: item_venda_loja fk_venda_compra_loja_virtual; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT fk_venda_compra_loja_virtual FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.venda_compra_loja_virtual(id);


--
-- TOC entry 4911 (class 2606 OID 17182)
-- Name: nota_fiscal_venda fk_venda_compra_loja_virtual; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT fk_venda_compra_loja_virtual FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.venda_compra_loja_virtual(id);


--
-- TOC entry 4901 (class 2606 OID 17202)
-- Name: status_rastreio fk_venda_compra_loja_virtual; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT fk_venda_compra_loja_virtual FOREIGN KEY (venda_compra_loja_virtual_id) REFERENCES public.venda_compra_loja_virtual(id);


--
-- TOC entry 4913 (class 2606 OID 17197)
-- Name: pessoa_juridica fkor0e1i8f3vc9f721q0wcx1nbp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT fkor0e1i8f3vc9f721q0wcx1nbp FOREIGN KEY (id) REFERENCES public.pessoa(id);


--
-- TOC entry 4912 (class 2606 OID 17192)
-- Name: pessoa_fisica fksrkbwlwurui650owdeqn7mbx6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT fksrkbwlwurui650owdeqn7mbx6 FOREIGN KEY (id) REFERENCES public.pessoa(id);


--
-- TOC entry 4905 (class 2606 OID 17157)
-- Name: endereco pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (pessoa_id) REFERENCES public.pessoa(id);


-- Completed on 2025-04-12 19:54:38

--
-- PostgreSQL database dump complete
--

