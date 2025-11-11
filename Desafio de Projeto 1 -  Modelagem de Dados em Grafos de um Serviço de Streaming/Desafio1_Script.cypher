
// ------------------------------------------------------------
// LUKFLIX - PROJETO DE GRAFO NEO4J
// ------------------------------------------------------------
// Criação de restrições para unicidade
CREATE CONSTRAINT unique_movie_title IF NOT EXISTS FOR (m:Movie) REQUIRE m.title IS UNIQUE;
CREATE CONSTRAINT unique_series_title IF NOT EXISTS FOR (s:Series) REQUIRE s.title IS UNIQUE;
CREATE CONSTRAINT unique_user_name IF NOT EXISTS FOR (u:User) REQUIRE u.name IS UNIQUE;
CREATE CONSTRAINT unique_actor_name IF NOT EXISTS FOR (a:Actor) REQUIRE a.name IS UNIQUE;
CREATE CONSTRAINT unique_director_name IF NOT EXISTS FOR (d:Director) REQUIRE d.name IS UNIQUE;
CREATE CONSTRAINT unique_genre_name IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// ------------------------------------------------------------
// CRIAÇÃO DOS NÓS (FILMES, SÉRIES, USUÁRIOS, ATORES, DIRETORES E GÊNEROS)
// ------------------------------------------------------------

// Filmes
CREATE (f1:Movie {title:'Nada de Novo no Front', subtitle:'All Quiet on the Western Front', year:2022});
CREATE (f2:Movie {title:'Conta Comigo', subtitle:'Stand by Me', year:1986});
CREATE (f3:Movie {title:'Bagagem de Risco', subtitle:'Carry On', year:2024});
CREATE (f4:Movie {title:'O Enfermeiro Noturno', subtitle:'The Good Nurse', year:2022});
CREATE (f5:Movie {title:'O Elixir', subtitle:'The Elixir', year:2025});

// Séries
CREATE (s1:Series {title:'Treta', year:2023, seasons:1});
CREATE (s2:Series {title:'Monstro: Ed Gein', year:2025, seasons:1});
CREATE (s3:Series {title:'The Office', year:2005, seasons:9});
CREATE (s4:Series {title:'Indomável', year:2025, seasons:1});
CREATE (s5:Series {title:'O Sangue de Zeus', year:2020, seasons:2});

// Usuários
CREATE (u1:User {name:'Lucindo'});
CREATE (u2:User {name:'Tatiana'});
CREATE (u3:User {name:'Ray'});
CREATE (u4:User {name:'Mariana'});
CREATE (u5:User {name:'Ângelo'});

// ------------------------------------------------------------
// GÊNEROS
CREATE (g1:Genre {name:'Guerra'});
CREATE (g2:Genre {name:'Aventura'});
CREATE (g3:Genre {name:'Ação'});
CREATE (g4:Genre {name:'Drama'});
CREATE (g5:Genre {name:'Terror'});
CREATE (g6:Genre {name:'Comédia'});
CREATE (g7:Genre {name:'Mistério'});
CREATE (g8:Genre {name:'Mitologia'});

// ------------------------------------------------------------
// RELACIONAMENTOS
// Filmes e gêneros
MATCH (f1:Movie {title:'Nada de Novo no Front'}), (g1:Genre {name:'Guerra'}) CREATE (f1)-[:HAS_GENRE]->(g1);
MATCH (f2:Movie {title:'Conta Comigo'}), (g2:Genre {name:'Aventura'}) CREATE (f2)-[:HAS_GENRE]->(g2);
MATCH (f3:Movie {title:'Bagagem de Risco'}), (g3:Genre {name:'Ação'}) CREATE (f3)-[:HAS_GENRE]->(g3);
MATCH (f4:Movie {title:'O Enfermeiro Noturno'}), (g4:Genre {name:'Drama'}) CREATE (f4)-[:HAS_GENRE]->(g4);
MATCH (f5:Movie {title:'O Elixir'}), (g5:Genre {name:'Terror'}) CREATE (f5)-[:HAS_GENRE]->(g5);

// Séries e gêneros
MATCH (s1:Series {title:'Treta'}), (g6:Genre {name:'Comédia'}) CREATE (s1)-[:HAS_GENRE]->(g6);
MATCH (s2:Series {title:'Monstro: Ed Gein'}), (g7:Genre {name:'Mistério'}) CREATE (s2)-[:HAS_GENRE]->(g7);
MATCH (s3:Series {title:'The Office'}), (g6:Genre {name:'Comédia'}) CREATE (s3)-[:HAS_GENRE]->(g6);
MATCH (s4:Series {title:'Indomável'}), (g7:Genre {name:'Mistério'}) CREATE (s4)-[:HAS_GENRE]->(g7);
MATCH (s5:Series {title:'O Sangue de Zeus'}), (g8:Genre {name:'Mitologia'}) CREATE (s5)-[:HAS_GENRE]->(g8);

// ------------------------------------------------------------
// ATORES E DIRETORES (apenas um exemplo simplificado)
CREATE (d5:Director {name:'Kimo Stamboel'});
MATCH (f5:Movie {title:'O Elixir'}), (d5) CREATE (d5)-[:DIRECTED]->(f5);
CREATE (a51:Actor {name:'Mikha Tambayong'}), (a52:Actor {name:'Eva Celia Latjuba'}),
       (a53:Actor {name:'Donny Damara'}), (a54:Actor {name:'Marthino Lio'}), (a55:Actor {name:'Dimas Anggara'});
MATCH (f5:Movie {title:'O Elixir'})
CREATE (a51)-[:ACTED_IN]->(f5), (a52)-[:ACTED_IN]->(f5), (a53)-[:ACTED_IN]->(f5),
       (a54)-[:ACTED_IN]->(f5), (a55)-[:ACTED_IN]->(f5);

// ------------------------------------------------------------
// AVALIAÇÕES DE USUÁRIOS
MATCH (u1:User {name:'Lucindo'}), (f1:Movie {title:'Nada de Novo no Front'}) CREATE (u1)-[:RATED {rating:'likeDuplo'}]->(f1);
MATCH (u2:User {name:'Tatiana'}), (s4:Series {title:'Indomável'}) CREATE (u2)-[:RATED {rating:'like'}]->(s4);
MATCH (u3:User {name:'Ray'}), (s4:Series {title:'Indomável'}) CREATE (u3)-[:RATED {rating:'likeDuplo'}]->(s4);
MATCH (u4:User {name:'Mariana'}), (s4:Series {title:'Indomável'}) CREATE (u4)-[:RATED {rating:'like'}]->(s4);
MATCH (u5:User {name:'Ângelo'}), (s4:Series {title:'Indomável'}) CREATE (u5)-[:RATED {rating:'like'}]->(s4);

/**************************************************************************************************
 🧩 CONCLUSÃO DO EXERCÍCIO – SISTEMA DE RECOMENDAÇÃO COM BANCO DE GRAFOS (NEO4J)

 O modelo desenvolvido representa um ecossistema simplificado de usuários, filmes e séries,
 utilizando o Neo4j para explorar relacionamentos típicos de plataformas de streaming,
 como avaliações, gêneros, diretores e atores.

 A estrutura foi projetada com nós representando usuários, obras, artistas, diretores e gêneros,
 interligados por arestas que indicam avaliações e colaborações criativas.

 Durante a implementação, observou-se que o grafo, apesar de coerente e funcional, possui um conjunto
 de dados reduzido e isolado — ou seja, cada obra apresenta atores, diretores e gêneros exclusivos,
 sem sobreposição entre os títulos. Essa característica limita o desempenho das consultas de
 recomendação baseadas em similaridade de conteúdo, pois não há elos compartilhados que permitam
 inferir proximidades entre obras.

 Em contrapartida, o modelo permanece plenamente adequado para demonstrar a estrutura conceitual
 de um sistema de recomendação, permitindo consultas baseadas em preferências de usuários
 (filtrando por avaliações “like” e “likeDuplo”) e explorando os vínculos entre entidades.

 Em um cenário real, recomendações mais eficazes surgiriam a partir de uma base ampliada, com atores,
 diretores e gêneros recorrentes, possibilitando correlações naturais e a aplicação de técnicas híbridas
 de recomendação (baseadas tanto em conteúdo quanto em comportamento).

 Assim, o exercício cumpre seu papel pedagógico ao ilustrar de forma clara os princípios de modelagem
 em grafos, consultas Cypher e análise relacional, destacando os limites e potencialidades do modelo
 em função do volume e da interconectividade dos dados.
**************************************************************************************************/
