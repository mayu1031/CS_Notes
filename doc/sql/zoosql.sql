
-- SELECT basics
-- 1. The example uses a WHERE clause to show the population of 'France'. Note that strings (pieces of text that are data) should be in 'single quotes';
-- Modify it to show the population of Germany

SELECT population FROM world
  WHERE name = 'Germany';
  
-- 2. Checking a list The word IN allows us to check if an item is in a list. The example shows the name and population for the countries 'Brazil', 'Russia', 'India' and 'China'.
-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
  
-- 3. Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). The example below shows countries with an area of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;


-- SELECT from WORLD Tutorial
-- 1. Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population FROM world;

-- 2. How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name FROM world
  WHERE population > 200000000;
  
-- 3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population FROM world
  WHERE population > 200000000;
  
-- 4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000 FROM world
  WHERE continent = 'South America';

-- 5. Show the name and population for France, Germany, Italy
SELECT name, population FROM world
  WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Show the countries which have a name that includes the word 'United'
SELECT name FROM world
  WHERE name LIKE '%United%';

-- 7. Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population, area FROM world
  WHERE area > 3000000 or population > 250000000;
  
-- 8. Exclusive OR (XOR). Show the countries that are big by area or big by population but not both. Show name, population and area.
-- Australia has a big area but a small population, it should be included.
-- Indonesia has a big population but a small area, it should be included.
-- China has a big population and big area, it should be excluded.
-- United Kingdom has a small population and a small area, it should be excluded.
SELECT name, population, area FROM world
  WHERE (area > 3000000 and population < 250000000) OR (area < 3000000 and population > 250000000);
  
-- 9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
-- For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000,2) AS population, ROUND(gdp/1000000000,2) AS gdp FROM world
  WHERE continent = 'South America';
  
-- 10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(gdp/population,-3) AS gdp FROM world
  WHERE gdp>1000000000000;
  
-- 11. Greece has capital Athens.
-- Each of the strings 'Greece', and 'Athens' has 6 characters.
-- Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12. The capital of Sweden is Stockholm. Both words start with the letter 'S'.
-- Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
-- You can use the function LEFT to isolate the first character.
-- You can use <> as the NOT EQUALS operator.
SELECT name, capital FROM world
  WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital;
  
  
-- SELECT from Nobel Tutorial
-- 1. Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner FROM nobel
  WHERE yr =1950;
  
-- 2. Show who won the 1962 prize for Literature.
SELECT winner FROM nobel
  WHERE yr = '1962' AND subject = 'Literature';
 
-- 3. Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject FROM nobel 
 WHERE winner = 'Albert Einstein';
 
-- 4. Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner FROM nobel
  WHERE subject = 'Peace' AND yr >=2000;
  
-- 5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT yr, subject, winner FROM nobel
  WHERE subject = 'Literature' AND yr>=1980 AND yr<=1989;
  
-- 6. Show all details of the presidential winners:
-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama
SELECT * FROM nobel
  WHERE winner IN('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama');
  
-- 7. Show the winners with first name John
SELECT winner FROM nobel
  WHERE winner LIKE 'John%';
  
-- 8. Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT yr, subject, winner FROM nobel
  WHERE (subject = 'Physics' AND yr = '1980') OR (subject = 'Chemistry' AND yr = '1984');
  
-- 9. Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT yr, subject, winner FROM nobel
  WHERE yr = '1980' AND subject NOT IN  ('Chemistry','Medicine');
  
-- 10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT yr, subject, winner FROM nobel
  WHERE (subject ='Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr>=2004);
  
-- 11. Find all details of the prize won by PETER GRÜNBERG
SELECT *
FROM nobel
WHERE winner LIKE 'PETER GR%NBERG'

-- 12. Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
  WHERE winner = 'EUGENE O''NEILL';
  
-- 13. Knights in order
-- List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner,yr, subject FROM nobel
   WHERE winner LIKE 'sir%'
ORDER BY yr DESC, winner;

-- 14. The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
FROM nobel
WHERE yr='1984'
ORDER BY subject IN('Chemistry','Physics'), subject, winner


-- SELECT within SELECT Tutorial
-- 1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population > (SELECT population FROM world
                             WHERE name = 'Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
  WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world
WHERE name = 'United Kingdom');

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name,continent FROM world
  WHERE continent IN
 (SELECT continent FROM world
  WHERE name = 'Argentina' OR name = 'Australia')
  ORDER BY name;
  
-- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world
WHERE population > (SELECT population FROM world
                           WHERE name = 'Canada') 
AND population <(SELECT population FROM world
                        WHERE name = 'Poland')
                  
-- 5. Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world
                                WHERE name = 'Germany') *100), '%') FROM world
  WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world
  WHERE gdp > ALL(SELECT gdp FROM world
                         WHERE continent = 'Europe' AND gdp>0);
                         
-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, x.area FROM world x
   WHERE x.area >=ALL(SELECT y.area FROM world y
                             WHERE x.continent = y.continent 
                                   AND area>0);
                                   
-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x
WHERE x.name = (SELECT y.name FROM world y
                          WHERE x.continent = y.continent ORDER BY name LIMIT 1 )  
                          
-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population FROM world x
  WHERE 25000000 >= ALL(SELECT y.population FROM world y
                          WHERE x.continent = y.continent AND y.population>0)
                          
-- 10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent FROM world x
  WHERE x.population/3 > ALL(SELECT y.population FROM world y
                          WHERE x.continent = y.continent AND x.name <> y.name);
                          
                          
-- SUM and COUNT
-- 1. Show the total population of the world.
-- world(name, continent, area, population, gdp)
SELECT SUM(population)
FROM world

-- 2. List all the continents - just once each.
SELECT DISTINCT continent FROM world;

-- 3. Give the total GDP of Africa
SELECT SUM(gdp) FROM world
  WHERE continent = 'Africa';
  
-- 4. How many countries have an area of at least 1000000
SELECT COUNT(name) FROM world
  WHERE area> 1000000;
  
-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population) FROM world
  WHERE name IN ('Estonia','Latvia','Lithuania');
  
-- 6. For each continent show the continent and number of countries.
SELECT continent, count(name) FROM world
 GROUP BY continent
 
-- 7. For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, count(name) FROM world
 WHERE population > 10000000
 GROUP BY continent 
 
-- 8. List the continents that have a total population of at least 100 million.
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) > 100000000


-- The JOIN operation
-- 1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
  
-- 2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
-- Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game
where id = '1012';

-- 3. You can combine the two steps into a single query with a JOIN.
-- The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say 
ON (game.id=goal.matchid)
-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (matchid=id)
WHERE teamid = 'GER';

-- 4. Use the same JOIN as in the previous question.
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player FROM game JOIN goal ON (id = matchid)
  WHERE player LIKE 'Mario%';
  
-- 5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid = id)
 WHERE gtime<=10;
 
-- 6. To JOIN game with eteam you could use either
-- game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
-- Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname FROM game JOIN eteam ON (game.team1 = eteam.id)
  WHERE eteam.coach = 'Fernando Santos';
  
-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player FROM goal JOIN game ON (matchid = id)
  WHERE game.stadium = 'National Stadium, Warsaw';
  
-- 8. The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.
SELECT distinct player
  FROM game JOIN goal ON (id = matchid)
    WHERE (goal.teamid <> 'GER' AND game.team1 = 'GER') OR (goal.teamid <> 'GER' AND game.team2 = 'GER')
    
-- 9. Show teamname and the total number of goals scored.
SELECT teamname, count(teamid)
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(matchid)
  FROM game JOIN goal ON (game.id = goal.matchid)
  GROUP BY stadium
  
-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(matchid)
  FROM game JOIN goal ON (id=matchid)
  WHERE (game.team1 = 'POL' OR game.team2='POL')
  GROUP BY matchid, mdate
  
-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(matchid)
  FROM goal JOIN game ON (matchid = id)
  WHERE goal.teamid = 'GER'
  GROUP BY matchid, mdate;
  
-- 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
-- Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1.
-- Sort your result by mdate, matchid, team1 and team2.
SELECT mdate,team1,
 SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,team2, 
 SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
 FROM game left JOIN goal ON id = matchid 
  group by mdate,  matchid, team1,team2;


-- More JOIN operations
-- 1. List the films where the yr is 1962 [Show id, title]
select id,title from movie
where yr = '1962';

-- 2. Give year of 'Citizen Kane'.
SELECT yr FROM movie
  WHERE title = 'Citizen Kane';
  
-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr FROM movie
  WHERE title like '%Star Trek%'
  ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
  WHERE name = 'Glenn Close';
  
-- 5. What is the id of the film 'Casablanca'
SELECT id FROM movie
  WHERE title = 'Casablanca';
  
-- 6. Obtain the cast list for 'Casablanca'.
-- what is a cast list?
-- Use movieid=11768, (or whatever value you got from the previous question)
SELECT name FROM casting JOIN actor ON actorid = id
  WHERE movieid = '11768';
  
-- 7. Obtain the cast list for the film 'Alien'
SELECT name FROM actor JOIN casting ON actor.id =casting.actorid JOIN movie ON movie.id = casting.movieid 
   WHERE movie.title = 'Alien';

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT  title FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id
  WHERE actor.name ='Harrison Ford' 

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT  title AS titl FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id
  WHERE actor.name ='Harrison Ford' AND c
  
select title, count(name) from movie join casting on movie.id = casting.movieid join actor on casting.actorid = actor.id 
where movie.yr = '1978'
group by title
order by count(name) desc, title
asting.ord <> '1';
  
-- 10. List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id 
WHERE movie.yr = '1962' AND casting.ord = '1';

-- 11. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, count(*) FROM 
movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id
WHERE actor.name ='John Travolta'
GROUP BY yr
HAVING count(*)= (SELECT MAX(c) FROM
(SELECT yr, count(*) AS c FROM 
movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id
WHERE actor.name ='John Travolta'
GROUP BY yr) AS t)

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id
  WHERE casting.movieid IN (SELECT movieid FROM casting JOIN actor ON 
                                          casting.actorid = actor.id
                          WHERE name = 'Julie Andrews')
        AND casting.ord =1
        
-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON casting.actorid = actor.id 

WHERE casting.ord =1
GROUP BY name
HAVING COUNT(*)>=30
ORDER BY name

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
select title, count(name) from movie join casting on movie.id = casting.movieid join actor on casting.actorid = actor.id 
where movie.yr = '1978'
group by title
order by count(name) desc, title

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT name FROM movie JOIN casting ON movie.id = casting.movieid  JOIN actor ON casting.actorid = actor.id
 WHERE casting.movieid in (
SELECT movieid FROM movie JOIN casting ON movie.id = casting.movieid  JOIN actor ON casting.actorid = actor.id
WHERE actor.name ='Art Garfunkel') AND name <>'Art Garfunkel'


-- Using Null
-- 1. List the teachers who have NULL for their department.
select name from teacher
where dept is null

-- 2. Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

-- 3. Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name
FROM teacher left JOIN dept ON (teacher.dept = dept.id)

-- 4. SELECT teacher.name, dept.name
FROM teacher right JOIN dept ON (teacher.dept = dept.id)

-- 5. Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT name, COALESCE(mobile,'07986 444 2266') AS mobile FROM teacher

-- 6. Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher left JOIN dept ON teacher.dept = dept.id

-- 7. Use COUNT to show the number of teachers and the number of mobile phones.
SELECT COUNT(name), COUNT(mobile) FROM teacher

-- 8. Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT dept.name, COUNT(teacher.name) FROM teacher right JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name

-- 9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT teacher.name 
   ,CASE WHEN dept.id =1 then 'Sci'
        WHEN dept.id =2 then 'Sci'
        ELSE 'Art'
        END
FROM teacher left JOIN dept ON teacher.dept = dept.id

-- 10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
SELECT teacher.name 
   ,CASE WHEN dept.id =1 then 'Sci'
        WHEN dept.id =2 then 'Sci'
        WHEN dept.id =3 then 'Art'
        ELSE  'None'
        END
FROM teacher left JOIN dept ON teacher.dept = dept.id


-- Self join
-- 1. How many stops are in the database.
SELECT COUNT(name) FROM stops

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT id FROM stops
WHERE name = 'Craiglockhart'

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name FROM stops JOIN route ON stops.id = route.stop
  WHERE num = '4' AND company = 'LRT';
  
-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) =2

-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE
  a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart ')
  AND b.stop = (SELECT id FROM stops WHERE name = 'London Road')
  
-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT a.company, a.num, stopsa.name, stopsb.name 
FROM    route a JOIN route b ON (a.company = b.company AND a.num = b.num) 
        JOIN stops stopsa ON (a.stop = stopsa.id)  
        JOIN stops stopsb ON (b.stop = stopsb.id)
WHERE stopsa.name = 'Craiglockhart' AND stopsb.name = 'London Road' ;

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num FROM
  route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE a.stop = '115' AND b.stop = '137';

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT a.company, a.num FROM 
    route a JOIN route b ON (a.num = b.num AND a.company = b.company)
    JOIN stops stopsa ON (a.stop = stopsa.id)
    JOIN stops stopsb ON (b.stop = stopsb.id)
WHERE stopsa.name = 'Craiglockhart' AND stopsb.name = 'Tollcross';

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT distinct stopsa.name, a.company, a.num FROM 
    route a JOIN route b ON (a.num = b.num AND a.company = b.company)
    JOIN stops stopsa ON (a.stop = stopsa.id)
    JOIN stops stopsb ON (b.stop = stopsb.id)
WHERE stopsa.name = 'Craiglockhart' OR stopsb.name = 'Craiglockhart';

-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.
SELECT a.num, a.company, stopsb.name, c.num, c.company FROM 
   route a JOIN route b ON (a.num = b.num AND a.company = b.company)
  JOIN route c JOIN route d ON (c.num = d.num AND c.company = d.company)
  JOIN stops stopsa ON (a.stop = stopsa.id)
  JOIN stops stopsb ON (b.stop = stopsb.id)
  JOIN stops stopsc ON (c.stop = stopsc.id)
  JOIN stops stopsd ON (d.stop = stopsd.id)
WHERE stopsa.name = 'Craiglockhart' AND stopsd.name = 'Lochend' AND stopsb.name = stopsc.name;
