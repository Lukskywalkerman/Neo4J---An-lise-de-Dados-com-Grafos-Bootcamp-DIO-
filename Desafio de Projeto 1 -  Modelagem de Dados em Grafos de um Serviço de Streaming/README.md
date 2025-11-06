# 🎬 Projeto de Banco de Dados em Grafo para Serviço de Streaming

## 📌 Descrição do Problema

Você foi contratado por um novo serviço de streaming de filmes e séries. Sua primeira tarefa é projetar o banco de dados da plataforma. Diferente dos sistemas relacionais tradicionais, a empresa quer **focar nos relacionamentos** para criar um sistema de recomendação poderoso e personalizado.

---

## 🎯 Desafio

Modelar e criar um **grafo de conhecimento** que represente as entidades e conexões do serviço de streaming.

### 🧱 Entidades (Nós)
- `User` – Usuário da plataforma
- `Movie` – Filme
- `Series` – Série
- `Genre` – Gênero
- `Actor` – Ator/Atriz
- `Director` – Diretor(a)

### 🔗 Relacionamentos
- `(:User)-[:WATCHED {rating}]->(:Movie|:Series)`  
  Representa que um usuário assistiu a um conteúdo, com avaliação opcional.
- `(:Actor)-[:ACTED_IN]->(:Movie|:Series)`  
  Indica que um ator participou de um conteúdo.
- `(:Director)-[:DIRECTED]->(:Movie|:Series)`  
  Indica que um diretor dirigiu um conteúdo.
- `(:Movie|:Series)-[:IN_GENRE]->(:Genre)`  
  Classifica o conteúdo em um ou mais gêneros.

---

## 🛠️ Tecnologias Utilizadas
- **Neo4j** – Banco de dados de grafos
- **Cypher** – Linguagem de consulta para grafos

---

## 🧪 Exemplos de Consultas Cypher

```cypher
// Criar um usuário
CREATE (:User {name: 'Alice'})

// Criar um filme
CREATE (:Movie {title: 'Inception'})

// Relacionar usuário com filme assistido e nota
MATCH (u:User {name: 'Alice'}), (m:Movie {title: 'Inception'})
CREATE (u)-[:WATCHED {rating: 5}]->(m)
