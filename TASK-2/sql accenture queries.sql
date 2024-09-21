CREATE TABLE Reaction_type (
    TYPE VARCHAR(50),
    Sentiment VARCHAR(50),
    Score INT
);

-- Insert the data
INSERT INTO Reaction_type (TYPE, Sentiment, Score) VALUES
('heart', 'positive', 60),
('want', 'positive', 70),
('disgust', 'negative', 0),
('hate', 'negative', 5),
('interested', 'positive', 30),
('indifferent', 'neutral', 20),
('love', 'positive', 65),
('super love', 'positive', 75),
('cherish', 'positive', 70),
('adore', 'positive', 72),
('like', 'positive', 50),
('dislike', 'negative', 10),
('intrigued', 'positive', 45),
('peeking', 'neutral', 35),
('scared', 'negative', 15),
('worried', 'negative', 12);

select * from reaction_type;




CREATE TABLE public.reactions (
    content_id VARCHAR(32),   -- Assuming UUID without hyphens
    user_id VARCHAR(32),      -- Assuming UUID without hyphens
    type TEXT,
    datetime TIMESTAMP  -- Use TIMESTAMP to handle date and time
);

select * from reactions 




CREATE TABLE public.content (
    content_id VARCHAR(32),   -- Assuming UUIDs are stored as VARCHAR without hyphens
    user_id VARCHAR(32),      -- Assuming UUIDs are stored as VARCHAR without hyphens
    type VARCHAR(10),         -- Media type like 'photo', 'video', etc.
    category VARCHAR(50)    -- Category description
);






SELECT DISTINCT
    reactions.content_id,
    reactions.user_id,
    reactions.type AS reaction_type,   -- Renaming to avoid ambiguity
    reactions.datetime,
    content.type AS content_type,       -- Renaming to avoid ambiguity
    content.category,
    reaction_type.type,
    reaction_type.sentiment,
    (reaction_type.score) 
FROM
    reactions
INNER JOIN
    content
ON
    content.content_id = reactions.content_id
INNER JOIN
    reaction_type
ON
    reaction_type.type = reactions.type;
	
	
	select * from reaction_type;
select * from reactions;
select * from content;
	
	
SELECT SUM(reaction_type.SCORE) AS TOP_CATEGORIES,
CONTENT.CATEGORY
FROM reaction_type
INNER JOIN
reactions
ON 
reactions.TYPE = reaction_type.TYPE
inner join 
content
on 
content.content_id = reactions.content_id
GROUP BY 
CONTENT.CATEGORY
order by
TOP_CATEGORIES desc;






WITH CategoryScores AS (
    SELECT
        content.category,
        SUM(reaction_type.score) AS total_score
    FROM
        reaction_type
    INNER JOIN
        reactions
    ON
        reactions.type = reaction_type.type
    INNER JOIN
        content
    ON
        content.content_id = reactions.content_id
    GROUP BY
        content.category
)
SELECT DISTINCT
    reactions.content_id,
    reactions.user_id,
    reactions.type AS reaction_type,   -- Renaming to avoid ambiguity
    reactions.datetime,
    content.type AS content_type,       -- Renaming to avoid ambiguity
    content.category,
    reaction_type.type,
    reaction_type.sentiment,
    reaction_type.score,
    cs.total_score AS category_total_score
FROM
    reactions
INNER JOIN
    content
ON
    content.content_id = reactions.content_id
INNER JOIN
    reaction_type
ON
    reaction_type.type = reactions.type
INNER JOIN
    CategoryScores cs
ON
    cs.category = content.category
ORDER BY
    cs.total_score DESC;

	
	
	



