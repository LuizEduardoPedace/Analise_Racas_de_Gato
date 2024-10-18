# Introdução 🙋‍♂️

Está procurando adquirir um gato 🐈? 

Um animal de estimação pode ser o seu maior companheiro ou um incômodo se escolhido de forma errada. É muito importante pesquisar sobre a raça do animal que está disposto a adquirir para verificar se ela é compatível com o seu perfil. Portanto, realizei uma análise sobre várias características atreladas à raças de gatos para ajudá-lo na sua escolha! 

Aqui vai uma série de considerações que talvez você não tenha considerado antes de escolher que tipo de gato comprar:
- O valor de um gato variar bastante dependendo da raça, já considerou se o gato de sua escolha está dentro do seu orçamento?
- Tem alergia a pelo curto de gato? Que tal escolher uma raça que tenha pelo longo?
- Não gostaria que seu felino saísse sozinho de casa? Existem raças mais propensas a permanecer em casa!
- Possui objetos delicados em casa? Já considerou comprar uma raça que possui um traço de temperamento mais calmo?
- Gostaria de um bichinho para aliviar um pouco a solidão? Existem raças com um traço mais amoroso dentre as demais!

Como pode ver, existem uma série de fatores que podemos considerar para tornar a escolha do felino a mais compatível possível com o seu perfil, a fim evitar possíveis constrangimentos e a chance de abandono destes.

# Ferramentas Utilizadas 🛠️
- **PostgreSQL:** O software utilizado para criar um database;
- **Visual Studio Code:** O ambiente utilizado para criar os códigos com facilidade e rapidez;
- **SQL:** A linguagem de programação utilizada para manipular os dados com facilidade;
- **Python:** A linguagem de programação utilizada para criar visualizações dos resultados de forma de fácil compreensão;
- **Jupyter Notebook:** Formato de arquivo utilizado com a linguagem de programação python para organização do código de forma que seja de fácil entendimento para quem for ler;
- **Git & GitHub:** O software utilizado para monitorar as modificações feitas no projeto no decorrer do desenvolvimento, e publicá-lo em um repositório de fácil acesso aos dados utilizados, os códigos construídos e o relatório final.

# Escolha do *Dataset* 📈

Depois de escolhido que tipo de pergunta estamos interessados em responder, é chegada a etapa da escolha do *dataset* correto atrelado às suas expectativas e ao problema em questão.

O *dataset* escolhido está disponibilizado no repositório bem [aqui](/cat_breed_characteristics.csv). Nele está contido colunas como *breedname*, *lapcat*, *fur*, dentre outras que serão utilizadas e discorridas no decorrer da análise.

# Limpeza e Processamento de Dados ✔️

Ao colorcar-se em mãos de um *dataset*, o primeiro passo utilizado por qualquer analista de dados é a checagem da possível existência de dados errôneos. É bastante comum algum dado não ter sido inserido em um formato correto ou a informação contida nele se distancia do conjunto de interesse, porquanto, a limpeza e transformação do *dataset* tornam-se necessárias.

Posteriormente, é necessário processar os dados de forma que é possível armazená-los em algum *database* (PostgreSQL) e manipulá-los na ferramenta de interesse (SQL).

# Criação do Database 🛢️

É de suma importância armazenar os dados utilizados em um ambiente seguro, de fácil acesso e com a possibilidade de compartilhamento para a equipe atrelada ao projeto. Para isso, foi utilizado o **PostgresSQL**, um software amplamente utilizado pelos analistas de dados por sua facilidade de acesso e confiabilidade.

Ao criar-se um *database* e tabelas atreladas a este, é necessário ter realizado as etapas anteriores (limpeza e processamento) com excelência para que não surjam possíveis *bugs* no projeto. O código utilizado para a criação do *database*, tabelas e inserção dos dados:
```sql
CREATE DATABASE pet_Analysis;
 
CREATE TABLE CatBreeds (
    BreedName VARCHAR(100),
    AltBreedName VARCHAR(100),
    LapCat VARCHAR(20),
    Fur VARCHAR(20),
    MaleWtKg DECIMAL(5,2),
    Temperament TEXT,
    AvgKittenPrice DECIMAL(10,2),
    MalaysiaPopularity INT,
    PopularityUS2017 INT
);

/*
Copiar no PSQL Tool:
\copy CatBreeds FROM 'C:/Users/pedac/OneDrive/Documentos/Projects for Data Science/pet_Analysis/cat/cat_breed_characteristics.csv' DELIMITER ',' CSV HEADER;
*/
```

# Análise 🔎

Chegou a hora de fazer a análise dos dados para responder as perguntas de interesse e obter *insghts* valiosos. Criei um [jupyter notebook](/jupyter_notebook.ipynb) bastante organizado e bem detalhado para as visualizações criadas, dê uma olhada!

##  Raças de Gato Mais Caras

De acordo com o *dataset*, quais as raças mais caras? Para isso, foi necessário ordenar as raças de acordo com seu preço médio:
```sql
SELECT
    breedname,
    avgkittenprice
FROM catbreeds
WHERE avgkittenprice IS NOT NULL
ORDER BY avgkittenprice DESC
LIMIT 10
```

![breedname_x_avgvalue](/assets/Top_10_raças_caras/breed%20x%20price.png)
*Gráfico de Barra das raças mais caras em função do preço.*

Podemos ver que o preço das raças de gato podem variar bastante, podendo chegar até **$2000,00**! Algumas raças bastante conhecidas como a **Sphynx** estão nessa lista, é esperado que os custos de cuidado para um gato desse tipo são elevados.

Dentre essas raças mais caras, existe algum tipo de característica em comum que as torna ter um preço maior que as demais? 

### Tipo de Pelo

Vamos primeiro analisar pelo tamanho do pelo, para isso, é necessário agrupar pelo tipo de pelo dentre as raças mais caras e realizar a contagem:
```sql
WITH Top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        fur
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT
    fur,
    COUNT(breedname)
FROM Top_10_breed
GROUP BY fur
```

Podemos notar que as únicas duas raças **sem pelo** estão entre as 10 raças de gatos mais caras, revelando que existe um alto valor agregado a essa característica. Além disso, é possível notar uma predominância do pelo curto com relação ao longo.

![lap_count x breed](/assets/Top_10_raças_caras/count%20breed%20x%20fur.png)
*Gráfico de barra da Distrinuição de gatos por tipo de pelagem para as Top 10 raças de gato mais caras.*

### Peso médio

Qual o peso médio das raças mais caras? Para isso, é necessário calcular a média de peso dentre as raças mais caras da seguinte forma:
```sql
WITH Top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        malewtkg
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT
    ROUND(AVG(malewtkg),1) AS weight_top_10
FROM Top_10_breed
```

Obtemos assim um valor de **5,2 kg**, vamos comparar este valor depois com o peso médio das raças mais baratas.

### Popularidade

As raças mais caras são as mais populares? Dê uma olhada:

| Nome da Raça                             | Popularidade |
|------------------------------------------|--------------|
| Extra-Toes Cat (Hemingway Polydactyl)     |              |
| Exotic Shorthair                         | 1            |
| British Shorthair                        | 5            |
| Maine Coon                               | 3            |
| Applehead Siamese                        |              |
| Chausie                                  |              |
| Munchkin                                 |              |
| Canadian Hairless                        | 8            |
| Sphynx (hairless cat)                    | 8            |
| American Curl                            | 26           |

*Tabela das raças mais caras em função da popularidade, espaços em branco não possuem dado agregado.*

É notável que a maior parte das raças mais caras são também as **mais populares**. Perceba que a raça mais popular do ano é a segunda mais cara.


### Traço de Temperamento

Agora, existe algum traço de temperamento atrelado as raças mais caras? Vamos investigar.

Para essa análise é necessário separar os traços de temperamento dentre as raças mais caras, depois é feita a contagem agrupando por traço:
```sql
WITH top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        Temperament
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT 
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait,
    COUNT(breedname) AS count_breed
FROM top_10_breed
GROUP BY Trait
ORDER BY count_breed DESC
LIMIT 12
```

Traços como **"Gentil"**, **"Afeituoso"**, **"Leal"** e **"Inteligente"** são os mais comuns dentre os gatos mais caros.

![count_breed_x_temperament](/assets/Top_10_raças_caras/count%20breed%20x%20temperament.png)
*Gráfico de barra para a Contagem de Traços de temperamento das raças de gato mais caras.*

### Preferência de Colo

O preço da raça está relacionado com o gato ser de colo ou não? Para realizar esta análise devemos agrupar pela preferência de colo dentre as raças mais caras e fazer a contagem.
```sql
WITH Top_10_breed AS (
    SELECT
        breedname,
        avgkittenprice,
        lapcat
    FROM catbreeds
    WHERE avgkittenprice IS NOT NULL
    ORDER BY avgkittenprice DESC
    LIMIT 10
)
SELECT
    lapcat,
    COUNT(breedname)
FROM Top_10_breed
GROUP BY lapcat
```

É indiscutível a preferência dos gatos pelo **colo**. 

![count_lap_top_10](/assets/Top_10_raças_caras/count%20lap.png)
*Gráfico de Barra da preferência de colo ou não para as raças de gato mais caras.*

É importante ressaltar que para as análises serem feitas de forma correta é necessário um bom entendimento do *dataset*, todo e qualquer resultado obtido deve ser pensado e discutido para não tomarmos conclusões errôneas. Ao olharmos a distribuição de preferência de colo do *dataset*, podemos perceber que grande parte das raças são de fato de colo, o que não revela a princípio uma associação desta característica com o preço da raça.

| Preferência de Colo | Contagem |
|---------------------|----------|
| Não Gosta           | 11       |
| Gosta               | 43       |

*Tabela da preferência de colo para todo o dataset.*


## Raças de Gato Mais Baratas

Vamos comparar os resultados obtidos com as raças mais baratas. Para isso, realizaremos as mesmas análises.

![top_13_breed](/assets/Top_12_raças_baratas/breed%20name%20x%20avgval.png)
*Gráfico de Barra das raças mais baratas em função do preço.*

Note a diferença de preço comparado as raças mais caras. Isso mostra que a escolha da raça do gato está de alguma forma atrelada à classe social do comprador.

### Tipo de Pelo

Vamos realizar a contagem do tipo de pelo para as raças de gato mais baratas e comparar com as mais caras.

![count_fur_x_breed_top_13](/assets/Top_12_raças_baratas/count%20fur%20x%20breed.png)
*Gráfico de Barra da contagem do tipo de pelo das raças de gato mais baratas.*

Notemos que o pelo **curto** predomina em detrimento dos demais. Ademais, não há raças de gato sem sem pelo dentre as mais baratas, mostrando que esse tipo de gato está atrelado a uma classe econômica mais elevada.
Comparando com o resultado obtido para as raças de gato mais caras, podemos notar que o pelo curto predomina nos dois domínios, no entanto, enquanto o pelo médio tem uma quantidade significante para as raças mais caras, ele possui apenas **1** contagem dentre as mais baratas. Com isso, de alguma forma o pelo médio está relacionado com um preço maior.

### Peso Médio

Utilizando um código similar ao caso das raças mais caras, obtemos um peso médio de **5,9 kg** para as raças mais baratas. O peso das duas classes é similar e não podemos inferir alguma relação do peso médio com o preço das raças de gato.

### Traço de Temperamento

Vamos realizar a contagem dos traços de temperamento para as raças de gato mais baratas utilizando um *script* similar ao caso anterior.

![count_trait_top_13](/assets/Top_12_raças_baratas/count%20trait.png)
*Gráfico de Barra da contagem de traços de temperamento para as raças mais baratas.*

Traços como **"Brincalhão"**, **"Ativo"**, **"Curioso"**, **"Calmo"** e **"Descontraído"** são os mais predominantes dentre as raças mais baratas.
Comparando os resultados percebemos que nas raças mais baratas há a predominância de determinados traços, o que não ocorre no outro conjunto. Os traços considerados são diferentes e possuem signficados ligeiramente distindos. Enquanto nas raças de gato mais caras há traços principalmente relacionados à afeição com o dono e inteligência, no outro conjunto percebemos que os mesmos dizem respeito à hiperatividade do felino.

## Raças de Gato Mais Populares 

Quais são as raças de gatos mais populares? Para realizar esta análise é preciso ordená-las por popularidade:
```sql
SELECT
    breedname,
    popularityus2017
FROM catbreeds
WHERE popularityus2017 IS NOT NULL
ORDER BY popularityus2017
LIMIT 11
```

Notemos que muitas das top 10 raças mais populares são também as **mais caras**. 

| Nome da Raça           | Popularidade |
|------------------------|--------------|
| Exotic Shorthair        | 1            |
| Persa                  | 2            |
| Maine Coon              | 3            |
| Ragdoll                | 4            |
| British Shorthair       | 5            |
| American Shorthair      | 6            |
| Abissínio              | 7            |
| Canadian Hairless       | 8            |
| Sphynx (gato sem pelo)  | 8            |
| Siamês                 | 9            |
| Scottish Fold           | 10           |

*Tabela das Top 10 raças de gato mais populares.*

Vamos verificar se existe alguma relação da popularidade com alguma característica em comum como feito anteriormente, e comparar com o obtido para as raças de gato menos populares segundo o *dataset*.



### Preço Médio

Para realizar essa análise é necessário calcular a média de preço no conjunto das raças de gato mais populares:
```sql
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        avgkittenprice
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT ROUND(AVG(avgkittenprice),2)
FROM top_pop
```
O preço médio do conjunto acima é **$1268,18**, um valor elevado considerando-se que a faixa de preço começa em $100,00.
Calculando-se a média de preço para as raças de gato menos populares de forma similar, obtemos um valor de **$763,64**, mais de **$500,00 de diferença**!

### Tipo de Pelo

Para essa análise é necessário agrupar pelo tipo de pelo e realizar a contagem dentre as raças de gato mais populares:
```sql
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        fur
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT fur, COUNT(breedname)
FROM top_pop
GROUP BY fur
```

Podemos perceber que o tipo de pelo **curto** predomina sobre os demais. As únicas duas raças **sem pelo** estão dentre as mais populares e não vemos nenhum gato de pelo médio nesse conjunto.

![count_fur_top_pop](/assets/Raças_mais_populares/count%20fur.png)
*Gráfico de Barra da contagem do tipo de pelo para as raças de gato mais populares.*

De modo análogo, podemos fazer o mesmo para as raças de felino menos populares:

![count_fur_bot_pop](/assets/Raças_menos_populares/count%20fur.png)
*Gráfico de Barra da contagem do tipo de pelo para as raças de gato menos populares.*

Desta vez o pelo **longo** predomina, enquanto o pelo curto só possui 1 contagem. Podemos ver também que há felinos com pelo médio no conjunto. Comparando-se os dois resultados, o pelo médio está de alguma forma associado a uma baixa popularidade, no que se distingue do pelo curto e sem pelo.

### Peso Médio

Podemos associar o peso médio com a popularidade da raça? Vamos dar uma olhada.

Para realizar esta análise é necessário calcular a média de peso para cada um dos conjuntos:
```sql
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        malewtkg
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT ROUND(AVG(malewtkg),2)
FROM top_pop
```

O peso médio obtido para as raças mais populares foi de **5,64 kg**, enquanto para as menos populares **4,91 kg**. Existe uma diferença de 0,73 kg entre os dois resultados, não podemos associar o peso com a popularidade da raça de gato com essa análise.

### Traço de Temperamento

Existe algum traço de temperamento atrelado a uma maior popularidade? E menor popularidade?

Para essa análise é necessário primeiramente separar os tipos de traço dentre o temperamento, agrupar por traço e por fim realizar a contagem dentre as raças de gato mais populares:
```sql
WITH top_pop AS (
    SELECT
        breedname,
        popularityus2017,
        Temperament
    FROM catbreeds
    WHERE popularityus2017 IS NOT NULL
    ORDER BY popularityus2017
    LIMIT 11
)
SELECT
    UNNEST(STRING_TO_ARRAY(Temperament, ', ')) AS Trait, 
    COUNT(breedname) AS count
FROM top_pop
GROUP BY Trait
ORDER BY count DESC
LIMIT 15
```

Traços como **"Gentil"**, **"Leal"**, **"Calmo"** e **"Afetuoso"** estão entre os mais comuns.

![count_trait_top_pop](/assets/Raças_mais_populares/count%20trait.png)
*Gráfico de Barra da contagem de Traço para as raças de gato mais populares.*

Podemos fazer o mesmo para as raças de gato mais baratas: Traços como **"Inteligente"**, **"Brincalhão"**, **"Afetuoso"** e **"Gentil"** se destacam.

![count_trait_bot_pop](/assets/Raças_menos_populares/count%20trait.png)
*Gráfico de Barra da contagem de Traço para as raças de gato menos populares.*

## Agrupar por Peso

Vamos agora agrupar as raças de gato por peso e obter alguns insights interessantes.

Primeiramente vamos agrupar por peso e calcular a popularidade média, a predominância pela preferência ou não de colo e do tipo de pelo:
```sql
WITH weight_div AS (
    SELECT
        malewtkg,
        fur,
        ROW_NUMBER() OVER (PARTITION BY malewtkg ORDER BY COUNT(fur) DESC) AS rn
    FROM catbreeds
    WHERE 
        malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla' AND
        popularityus2017 IS NOT NULL
    GROUP BY malewtkg, fur
    ORDER BY malewtkg DESC
), lap_div AS (
    SELECT
        malewtkg,
        lapcat,
        ROW_NUMBER() OVER (PARTITION BY malewtkg ORDER BY COUNT(lapcat) DESC) AS gn
    FROM catbreeds
    WHERE 
        malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla' AND
        popularityus2017 IS NOT NULL
    GROUP BY malewtkg, lapcat
    ORDER BY malewtkg DESC
), pop_avg AS (
    SELECT 
        malewtkg,
        ROUND(AVG(popularityus2017),2) AS avg_pop
        FROM catbreeds
        WHERE 
            malewtkg IS NOT NULL AND 
            breedname != 'Chinchilla' AND
            popularityus2017 IS NOT NULL
        GROUP BY malewtkg
), trait_div AS (
    SELECT
        malewtkg,
        Trait,
        ROW_NUMBER() OVER (PARTITION BY malewtkg ORDER BY COUNT(Trait) DESC) AS hn
    FROM cat_all
    WHERE 
        malewtkg IS NOT NULL AND 
        breedname != 'Chinchilla'
    GROUP BY malewtkg, Trait
    ORDER BY malewtkg DESC
)

SELECT
    pop_avg.malewtkg,
    avg_pop,
    lap_div.lapcat,
    weight_div.fur,
    trait_div.Trait
FROM pop_avg
JOIN weight_div ON weight_div.malewtkg = pop_avg.malewtkg
JOIN lap_div ON lap_div.malewtkg = pop_avg.malewtkg
JOIN trait_div ON trait_div.malewtkg = pop_avg.malewtkg
WHERE weight_div.rn = 1 AND lap_div.gn = 1 AND trait_div.hn = 1
ORDER BY pop_avg.malewtkg DESC
```

O peso de **7 kg** possui a **maior popularidade**, com uma média de **11** seguido de **3** kg com **15**. A preferência de todos os conjuntos é **colo** e o pelo **longo** predomina nos pesos de 7 kg e 4 kg, enquanto nos demais é o pelo **curto**. O traço de temperamento **"Inteligente"** está presente em três dos conjuntos como podemos ver.

| Peso (kg) | Pop. Média | Pref. de Colo | Pelo  | Traço          |
|-----------|------------|----------------|-------|----------------|
| 7.00      | 11.00      | Colo           | Longo | Gentil         |
| 6.00      | 21.80      | Colo           | Curto | Brincalhão     |
| 5.00      | 17.50      | Colo           | Curto | Inteligente    |
| 4.00      | 23.79      | Colo           | Longo | Inteligente    |
| 3.00      | 15.00      | Colo           | Curto | Inteligente    |


*Tabela do Peso, popularidade média, preferência de colo, Tipo de Pelo e Traço de Temperamento.*

Vamos agora obter a média de preço para cada um dos pesos. Para isso devemos agrupar por peso e calcular a média de todos os preços da seguinte forma:
```sql
SELECT
    malewtkg,
    ROUND(AVG(avgkittenprice),2) AS avg_price
FROM catbreeds
WHERE malewtkg IS NOT NULL
GROUP BY malewtkg
ORDER BY malewtkg DESC
```

Podemos averiguar que o peso de **7 kg** domina o preço médio com mais de **$1300,00** seguido do de **3 kg** com um pouco mais de **$1100,00**. O peso de **6 kg** possui o menor valor (~$600,00).

![avg_price_x_weight](/assets/agrupamento_peso/preço%20médio.png)
*Visualização do preço médio em função do peso.*

É notório a relação do preço com a popularidade, raças de gato com uma maior popularidade costumam ter preços maiores. Notemos também que não existe uma relação linear entre peso e nenhuma das características anteriores.

## Agrupar por Tipo de Pelo

Vamos agrupar as raças de gato pelo tipo de pelo e fazer uma análise análoga à anterior.

| Pelo   | Pop. Média | Pref. de Colo | Peso Médio (kg) | Traço        |
|--------|------------|----------------|------------------|--------------|
| Sem Pelo | 8.00     | Colo           | 5.00             | Gentil       |
| Longo  | 22.80      | Colo           | 5.13             | Inteligente  |
| Médio  | 27.63      | Colo           | 5.13             | Inteligente  |
| Curto  | 14.75      | Colo           | 4.69             | Brincalhão   |


*Tabela do Pelo, popularidade média, preferência de colo, Peso Médio e Traço de Temperamento.*

Podemos ver que o tipo sem pelo tem uma popularidade maior como já era de se esperar pelas análises anteriores seguido do pelo curto. A preferência de todos os conjuntos é pelo Colo e os pesos não distam de forma significante. O traço de temperamento **"Inteligente"** é o mais predominante em dois dos conjuntos. Podemos agora obter o valor médio para cada tipo de pelo.

![price_x_fur](/assets/agrupamento_pelo/preço%20médio.png)
*Visualização do preço médio em função do Tipo de Pelo.*

O **sem pelo** domina com um valor maior que **$1400,00** seguido do pelo médio. O pelo curto está em último com um valor inferior à $800,00.

Como anteriormente mencionado em [Tipo de Pelo (preço)](#tipo-de-pelo-1), o pelo médio está relacionado a um preço maior em detrimento dos demais com exceção do sem pelo. Como também, pela análise de [Tipo de Pelo (popularidade)](#tipo-de-pelo-2), o pelo médio esta atrelado à uma menor popularidade, como era de se esperar ele está em último lugar na tabela de popularidade. Esta seção vai ao encontro das análises obtidas anteriormente!

## Agrupar por Traços de Temperamento

Vamos considerar as mesma análises feitas anteriormente, mas desta vez agrupando por traço de temperamento. Para esta análise vamos considerar apenas os traços que se repetem ao menos duas vezes, pois ao averiguar o *dataset*, existem alguns traços de temperamento que são exclusivos de algumas raças de gato (e.g. Six-Toed).

![avg_price_x_trait](/assets/agrupamento_temperamento/preço%20médio.png)
*Gráfico de Barra do preço médio em função do traço de temperamento.*

Traços como **"Paciente"**, **"Inquisitivo"**, **"Doce"** e **"Independente"** possuem os **maiores** valores médios, enquanto que **"Calmo"**, **"Descontraído"**, **"Ativo"** e **"Curioso"** possuem os **menores**. Ao compararmos com [Traço de Temperamento (preço)](#traço-de-temperamento-1), podemos identificar alguns traços em comum (Curioso, Brincalhão, Calmo, Descontraído), revelando que tais traços podem estar atrelados de alguma forma a uma diminuição do preço.
Vamos fazer a mesma análise para a **popularidade**.

![pop_x_trait](/assets/agrupamento_temperamento/popularidade.png)
*Gráfico de Barra da Popularidade Média em função do traço de temperamento.*

Vemos que traços como **Independente**, **Amoroso**, **Inquisitivo** e **Doce** estão entre os **mais desejados**, enquanto que **Interativo**, **Exigente**, **Vivaz**, **Esperto** e **Dependente** estão entre os **menos desejados**. É interessante notar como tais traços de temperamento estão de alguma forma atrelados com características que não são muito bem-vindas em sua grande maioria. Comparando-se com [Traço de Temperamento (popularidade)](#traço-de-temperamento-2) podemos notar que existem muitos traços em comum nos dois conjuntos, **Amoroso**, **Independente**, **Doce**, **Inquisitivo** estão atrelado a uma **grande popularidade**, enquanto que **Brincalhão** e **Inteligente** estão relacionados a uma **menor popularidade**.


# Conslusão 📄

Primeiramente, investigamos o conjunto de dados e consideramos os conjuntos de interesse para realizar nossa análise. Ranqueamos as raças de gato por **preço** e **popularidade** e estudamos esses conjuntos para tentarmos compreender o que faz essas raças se destacarem dentre as demais. Posteriormente, agrupamos o conjunto de dados por **tipo de pelo**, **peso médio** e **temperamento** da raça para procurar possíveis correlações entre essas características, **preço médio**, **popularidade média** e **preferência de colo**.

As raças de gato podem possuir características bastante diferentes uma das outras, o que torna o público-alvo dedicada a cada uma diferente. O preço médio de um filhote de gato varia bastante dependendo da raça escolhida, podendo ir de **$100,00** até **$2000,00**!

No que diz respeito ao preço, existem certas características que podem tornar uma raça mais cara do que outra. Vimos que os felinos que possuem **pelo médio** ou são **sem pelo** costumam ter um valor **mais elevado** do que os demais. Além disso, raças que possuem um temperamento **paciente**, **inquisitivo**, **doce** e **amoroso** costumam ser as **mais caras**, enquanto que as que possuem um temperamento voltado para **curioso**, **brincalhão**, **calmo** e **descontraído** comumente são **mais baratas**. Por fim, as raças de gato com os maiores pesos médios (**7 kg**), como também as **mais populares**, são as **mais caras**!

As raças **Exotic Shorthair**, **Persa** e **Maine Coon** são as **mais populares** na época de coleta dos dados, foi revelado que gatos com **pelo médio** possuem uma **popularidade menor**, enquanto os **sem pelo** se sobressaem sobre os demais. Vimos que temperamento **Amoroso**, **Independente**, **Doce**, **Inquisitivo** são os **mais populares**, enquanto raças com traço **brincalhão** são as **menos populares**.