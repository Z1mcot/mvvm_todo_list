CREATE TABLE t_ToDoItem (
    [id]        INTEGER NOT NULL PRIMARY KEY
    ,[name]     TEXT NOT NULL
    ,[isDone]   INTEGER
); -- разделитель между таблицами
-- CREATE TABLE t_NewTable (
    -- во всех таблицах должен быть столбец [id], он может иметь другой тип данных, но не название
    -- [id]        TEXT NOT NULL PRIMARY KEY 
    
    -- Прочие столбцы
-- ); -- После добавления таблицы 