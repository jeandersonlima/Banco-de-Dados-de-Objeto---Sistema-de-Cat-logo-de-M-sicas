# 🎵 Catálogo Digital de Músicas - Banco de Dados Objeto Oracle

## 📖 Sobre o Projeto

Este projeto consiste no desenvolvimento de um Banco de Dados Orientado a Objetos utilizando Oracle Database para gerenciamento de um catálogo digital de músicas.

O sistema foi projetado para armazenar, organizar e recuperar informações relacionadas a artistas, álbuns e faixas musicais, explorando os recursos do modelo objeto-relacional do Oracle. A modelagem orientada a objetos permite representar entidades complexas do domínio musical de forma mais natural, utilizando tipos de objetos, encapsulamento de atributos e métodos, além de relacionamentos entre objetos.

O projeto tem caráter acadêmico e tem como objetivo demonstrar a utilização dos principais recursos de Banco de Dados Objeto disponíveis no Oracle Database.

---

## 🎯 Objetivos

### Objetivos de Armazenamento

* Armazenar objetos complexos representando artistas, álbuns e faixas musicais.
* Encapsular atributos e comportamentos em tipos de objetos Oracle.
* Utilizar referências entre objetos (REF) para representar relacionamentos.
* Demonstrar o uso de tabelas de objetos (Object Tables).
* Demonstrar o uso de colunas do tipo objeto em tabelas relacionais.

### Objetivos de Consulta

* Consultar artistas, álbuns e faixas armazenados no sistema.
* Navegar entre objetos relacionados utilizando referências.
* Executar funções membro definidas nos tipos de objetos.
* Consultar atributos específicos de objetos armazenados em colunas de objeto.

### Objetivos de Atualização e Remoção

* Atualizar atributos de objetos armazenados no banco.
* Remover registros utilizando condições sobre atributos de objetos.
* Inserir novas instâncias de objetos utilizando diferentes formas de construção.

---

## 🛠 Tecnologias Utilizadas

* Oracle Database
* SQL
* PL/SQL
* Oracle Object Types
* Object Tables
* REF Objects
* Member Functions

---

## 🗂 Estrutura do Modelo de Dados

O banco de dados é composto por três principais tipos de objetos:

### 👨‍🎤 T_ARTISTA

Representa os artistas cadastrados no sistema.

#### Atributos

* Nome artístico
* Gênero musical principal
* País de origem
* Ano de início da carreira
* Biografia resumida

---

### 💿 T_ALBUM

Representa os álbuns musicais.

#### Atributos

* Título do álbum
* Ano de lançamento
* Gravadora responsável
* Referência ao artista

#### Métodos

* Função para retornar a descrição completa do álbum.

---

### 🎵 T_FAIXA

Representa as músicas pertencentes aos álbuns.

#### Atributos

* Título da faixa
* Duração em segundos
* Número da faixa
* Referência ao álbum

#### Métodos

* Função para retornar a duração formatada no padrão `mm:ss`.

---

## 🔗 Relacionamentos

O sistema utiliza referências entre objetos para representar os relacionamentos do domínio musical.

### Artista → Álbum

Um artista pode possuir vários álbuns.

### Álbum → Faixa

Um álbum pode conter várias faixas musicais.

Esses relacionamentos são implementados utilizando referências (REF) do Oracle, permitindo navegação entre objetos armazenados.

---

## ⚙ Funcionalidades Implementadas

### Cadastro

* Inserção de artistas.
* Inserção de álbuns.
* Inserção de faixas.

### Consultas

* Listagem de artistas.
* Listagem de álbuns.
* Listagem de faixas.
* Navegação entre objetos relacionados.
* Consulta de atributos específicos de objetos.

### Métodos de Objeto

* Geração de descrição completa de álbum.
* Formatação automática de duração de músicas.

### Manipulação de Dados

* Atualização de atributos de objetos.
* Exclusão de registros com base em atributos de objetos.
* Inserção utilizando construtores de objetos Oracle.

---

## 📊 Exemplos de Consultas

### Consultar todos os artistas

```sql
SELECT * FROM TB_ARTISTA;
```

### Consultar todos os álbuns

```sql
SELECT * FROM TB_ALBUM;
```

### Consultar todas as faixas

```sql
SELECT * FROM TB_FAIXA;
```

### Executar função de duração formatada

```sql
SELECT f.get_duracao_formatada()
FROM TB_FAIXA f;
```

### Executar função de descrição do álbum

```sql
SELECT a.get_descricao()
FROM TB_ALBUM a;
```

---

## 📚 Conceitos de Banco de Dados Objeto Aplicados

* Tipos de Objetos (Object Types)
* Tabelas de Objetos (Object Tables)
* Colunas de Objetos
* Métodos Membro (Member Functions)
* Construtores de Objetos
* Referências entre Objetos (REF)
* Encapsulamento
* Modelo Objeto-Relacional

---

## 🚀 Como Executar

1. Abrir o Oracle SQL Developer.
2. Executar os scripts de criação dos tipos de objetos.
3. Executar os scripts de criação das tabelas de objetos.
4. Executar os scripts de inserção dos dados.
5. Executar os scripts de consultas e testes.

---

## 👨‍💻 Autor(es)

Projeto desenvolvido para a disciplina de Banco de Dados Objeto utilizando Oracle Database.

---

## 📄 Licença

Projeto desenvolvido para fins acadêmicos e educacionais.
