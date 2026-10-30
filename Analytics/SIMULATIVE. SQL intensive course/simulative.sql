-- SQL. Практика 1. Задача 1
SELECT
	id,
	username,
	email,
	date_joined 
FROM users
ORDER BY 
	date_joined DESC,
	id ASC;



 
/*
 * SQL. Практика 2. Задача 1
 * 
 * Вывести информацию о пользователях, у которых: 
 * 
 *     - либо не указана фамилия 
 *     - либо количество очков опыта строго больше 100
 * 
 * Результат отсортировать по возрастанию id.
 */
SELECT
	id,
	username,
	score
FROM users
WHERE last_name IS NULL
	OR score > 100
ORDER BY id ASC;


/*
 * SQL. Практика 2. Задача 2
 * 
 * Вывести информацию об активных пользователях (is_active = 1), которые:
 * 
 *     - либо имеют количество очков опыта строго больше 500
 *     - либо относятся к компании с id = 7
 * 
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
	id,
	username,
	company_id,
	score
FROM users
WHERE is_active = 1
	AND (
		score > 500 OR company_id = 7
	)
ORDER BY id ASC;


/*
 * SQL. Практика 3. Задача 1
 */
SELECT
	id,
	username,
	first_name,
	last_name,
	LOWER(first_name) AS lower_first_name,
	UPPER(last_name) AS upper_last_name,
	length(username) AS length_username
FROM users
ORDER BY
	length_username DESC,
		id ASC;


/*
 * SQL. Практика 3. Задача 2
 * 
 * Требуется вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - почта
 *     - домен электронной почты
 * 
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
	id,
	username,
	email,
	substring(
		email
		FROM
			'@(.*)'
	) AS domain
FROM users
ORDER BY id ASC;


/* SQL. Практика 3. Задача 3
 * 
 * Требуется вывести информацию о пользователях, которые имеют домен электронной почты bk.ru
 * Результат отсортируйте по возрастанию поля id.
 */

SELECT
	id,
	username,
	email
FROM users
WHERE substring(
	email
	FROM
		'@(.*)'
) LIKE 'bk.ru'
ORDER BY id ASC;


/* ************************************************************
 * Полезные операторы (coalesce, nullif, case)
 ************************************************************ */


/*
 * SQL. Практика 4. Задача 1
 * 
 * Требуется вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - текстовое описание идентификатора формата "Идентификатор пользователя равен x", где x - значение id
 * 
 */
SELECT 
	id,
	username,
	concat_ws(' ', 'Идентификатор пользователя равен', id) AS text_user_id
FROM users
ORDER BY id ASC;


/*
 * SQL. Практика 4. Задача 2
 * 
 * Требуется вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - имя
 *     - фамилия
 *     - приветственное имя пользователя: 
 *         - если есть имя, то вывести имя пользователя
 *         - если имени нет, но есть фамилия, то вывести фамилию 
 *         - если отсутствуют как имя, так и фамилия, то вывести Дорогой друг
 * 
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
	id,
	username,
	first_name,
	last_name,
	CASE 
		WHEN first_name IS NOT NULL THEN first_name
		WHEN first_name IS NULL AND last_name IS NOT NULL THEN last_name 
		ELSE 'Дорогой друг'
	END AS display_name
FROM users
ORDER BY id ASC;


/*
 * SQL. Практика 4. Задача 3
 * 
 * Требуется вывести следующую информацию о пользователях:
 *     
 *     - идентификатор
 *     - логин
 *     - количество очков опыта на платформе
 *     - группа пользователя по количеству очков опыта на платформе

 * Правила присвоения группы пользователю по количеству очков опыта на платформе:
 * 
 *     - Если значение строго больше 300, то Мастер
 *     - Если значение строго больше 150, то Эксперт
 *     - Если значение строго больше 75, то Продвинутый
 *     - В остальных случаях Новичок
 */
SELECT
	id,
	username,
	score,
	CASE
		WHEN score > 300 THEN 'Мастер'
		WHEN score > 150 THEN 'Эксперт'
		WHEN score > 75 THEN 'Продвинутый'
		ELSE 'Новичок'
	END AS group_user
FROM users
ORDER BY id ASC;



/* ************************************************************
 * Скалярные функции (работа с датой и временем)
 ************************************************************ */


/*
 * SQL. Практика 5. Задача 1
 * 
 * Требуется вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - почта
 *     - дата и время регистрации
 *     - дата и время регистрации, округленная до первого числа месяца (например, 2022-04-21 12:20:00.000202 —> 2022-04-01 00:00:00)
 * 
 * Результат отсортируйте сначала по убыванию поля date_joined, а затем по возрастанию поля id.
 */
SELECT 
	id,
	username,
	email,
	date_joined,
	date_trunc('month', date_joined) AS registration_month_start
FROM users
ORDER BY 
	date_joined DESC,
	id ASC;


/* 
 * SQL. Практика 5. Задача 2
 * 
 * Требуется вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - почта
 *     - дата и время регистрации
 *     - дата и время регистрации, отформатированная в виде текста дата регистрации в формате DD Mon YYYY
 * 
 * Результат отсортируйте сначала по убыванию поля date_joined, а затем по возрастанию поля id.
 */
SELECT
	id,
	username,
	email,
	date_joined,
	to_char(date_joined, 'DD Mon YYYY') AS formatted_date
FROM users
ORDER BY
	date_joined DESC,
	id ASC;

/*
 * SQL. Практика 5. Задача 3
 * 
 * Требуется вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - почта
 *     - дата и время регистрации
 *     - дата и время регистрации в формате год-месяц (YYYY-MM)
 * 
 * Результат отсортируйте сначала по убыванию поля date_joined, а затем по возрастанию поля id.
 */
SELECT
	id,
	username,
	email,
	date_joined,
	to_char(date_joined, 'YYYY-MM') AS formatted_date
FROM users
ORDER BY 
	date_joined DESC,
	id ASC;


/*
 * SQL. Практика 5. Задача 4
 * 
 * Требуется вывести информацию о пользователях, которые зарегистрировались на платформе в течение 45 дней после 2022-01-01
 * Результат отсортируйте сначала по убыванию поля date_joined, а затем по возрастанию поля id.
 */
SELECT 
	id,
	username,
	date_joined
FROM users
WHERE
    date_joined BETWEEN make_date(2022, 01, 01) AND make_date(2022, 01, 01) + INTERVAL '45 days'
ORDER BY 
    date_joined DESC,
    id ASC;


/*
 * SQL. Практика 5. Задача 5
 * 
 * Требуется вывести информацию о пользователях, которые зарегистрировались на платформе в 2021 году
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
    id,
    username, 
    date_joined
FROM users
WHERE
    extract(YEAR FROM date_joined ) = 2021
ORDER BY id ASC;


/*
 * SQL. Практика 5. Задача 6
 * 
 * Требуется вывести информацию о пользователях, которые имеют домен электронной почты bk.ru и зарегистрировались на платформе в 2022 году.
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
    id,
    username,
    email,
    date_joined 
FROM users
WHERE
    substring(
        email
        FROM
            '@(.*)'
    ) LIKE 'bk.ru'
    AND extract(YEAR FROM date_joined ) = 2022
ORDER BY id ASC;


/*
 * SQL. Практика 5. Задача 7
 * 
 * Требуется вывести информацию о пользователях, которые зарегистрировались на платформе в 2021 году либо имеют количество очков опыта на платформе строго больше 100.
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
    id,
    username,
    email,
    date_joined,
    score
FROM users
WHERE
    extract(YEAR FROM date_joined ) = 2021
        OR score > 100
ORDER BY id ASC;


/*
 * SQL. Практика 5. Задача 8
 * 
 * Требуется вывести информацию о пользователях, которые имеют домен bk.ru либо yandex.ru и при этом зарегистрировались на платформе в 2021 году.
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT
    id,
    username,
    email,
    date_joined
FROM users
WHERE
    extract(YEAR FROM date_joined ) = 2021
        AND (
            email LIKE '%@bk.ru' 
                OR email LIKE '%@yandex.ru'
        )
ORDER BY id ASC;


/* ************************************************************
 * Соединение таблиц
 ************************************************************ */

/*
 * SQL. Практика 6. Задача 1
 * 
 * Необходимо вывести следующую информацию о пользователях, которые отправляли на выполнение код в период с 1 по 30 апреля 2021 года:
 * 
 *     - идентификатор пользователя
 *     - логин пользователя
 *     - дата и время регистрации пользователя
 *     - идентификатор задачи
 * 
 * Результат отсортируйте по возрастанию id и problem_id
 */
SELECT
    users.id,
    users.username,
    users.date_joined,
    --
    coderun.problem_id
FROM users
LEFT JOIN coderun
    ON coderun.user_id = users.id
WHERE 
    coderun.created_at BETWEEN make_date(2021, 04, 01) AND make_date(2021, 04, 30)
ORDER BY 
    users.id ASC,
    coderun.problem_id ASC;


/*
 * SQL. Практика 6. Задача 2
 * 
 * Требуется вывести следующую информацию:
 * 
 *     - название языка программирования
 *     - название задачи
 *     - сложность задачи
 * 
 * Оставьте только те языки программирования, для которых существуют задачи.
 * Результат отсортируйте по возрастанию problem_name.
 */
SELECT * FROM language;
SELECT * FROM problem;
SELECT * FROM languagetoproblem;

SELECT
    lang.name AS language_name,
    problem.name AS problem_name,
    problem.complexity
FROM languagetoproblem ltp
    LEFT JOIN (
        SELECT * FROM problem
    ) problem
        ON ltp.pr_id = problem.id
    LEFT JOIN (
        SELECT * FROM LANGUAGE
    ) lang
        ON ltp.lang_id = lang.id
ORDER BY problem_name ASC;

-- Или проще

SELECT
    lang.name AS language_name,
    prob.name AS problem_name,
    prob.complexity
FROM languagetoproblem ltp
    LEFT JOIN problem prob
        ON ltp.pr_id = prob.id
    LEFT JOIN language lang
        ON ltp.lang_id = lang.id
ORDER BY problem_name ASC;


/*
 * SQL. Практика 6. Задача 3
 * 
 * Выведите только те языки программирования, для которых не существует задач.
 * Результат отсортируйте по возрастанию language_name.
 */
SELECT * FROM language lang;
SELECT * FROM problem prob;
SELECT * FROM languagetoproblem ltp;

SELECT
    lang.name AS language_name
FROM "language" lang
    LEFT JOIN languagetoproblem ltp
        ON ltp.lang_id = lang.id
WHERE ltp.ltp_id IS NULL
ORDER BY language_name ASC;

-- Или
SELECT * FROM "language" lang
WHERE lang.id NOT IN (
    SELECT lang_id FROM languagetoproblem
);

-- Или через EXISTS
SELECT * FROM "language" lang
WHERE NOT EXISTS (
    SELECT 1 FROM languagetoproblem ltp
    WHERE ltp.lang_id = lang.id
);


/* 
 * SQL. Практика 6. Задача 4
 *
 * Требуется вывести следующую информацию:
 *
 *    - ID вопроса (question_id)
 *    - текст вопроса (question_value)
 *    - тег вопроса (question_tag)
 *    - текст правильного ответа (correct_answer_value)
 *
 * Оставьте только правильные ответы на вопросы.
 * Результат отсортируйте по возрастанию question_id
 */
SELECT * FROM testquestion tq;
SELECT * FROM testanswer ta;

SELECT
    tq.id AS question_id,
    tq.value AS question_value,
    tq.tag AS question_tag,
    --
    ta.value AS correct_answer_value
FROM testquestion tq
    LEFT JOIN testanswer ta
        ON ta.question_id = tq.id
WHERE ta.is_correct = TRUE
ORDER BY question_id ASC;


/*
 * SQL. Практика 6. Задача 5
 * 
 * Требуется вывести названия задач, которые никогда не отправлялись на проверку.
 * Результат отсортируйте по возрастанию name.
 */
SELECT * FROM problem;
SELECT * FROM codesubmit
WHERE time_spent IS NOT NULL;

SELECT name 
FROM problem prb
    LEFT JOIN codesubmit codes
        ON codes.problem_id = prb.id
WHERE codes.problem_id  IS NULL
ORDER BY prb.name ASC;


/*
 * SQL. Практика 6. Задача 6
 * 
 * Требуется вывести идентификаторы пользователей, которые никогда не отправляли на выполнение код.
 * Результат отсортируйте по возрастанию id.
 */
SELECT * FROM users LIMIT 10;
SELECT * FROM coderun LIMIT 10;

SELECT usr.id
FROM users usr
    LEFT JOIN coderun codes
        ON codes.user_id = usr.id
WHERE codes.user_id IS NULL
ORDER BY usr.id;


/*
 * SQL. Практика 6. Задача 7
 * 
 * Требуется вывести информацию о всех пользователях, которые зарегистрировались в 2021 году:
 * 
 *     - идентификатор пользователя (id)
 *     - логин пользователя (username)
 *     - дата и время регистрации пользователя (date_joined)
 *     - название компании к которой относится пользователь (company_name)
 * 
 * Если пользователь без компании, то выводите Без компании
 * Результат отсортируйте по возрастанию id. 
 */
SELECT * FROM users LIMIT 5;
SELECT * FROM company LIMIT 5;

SELECT
    users.id,
    users.username,
    users.date_joined,
    --
    CASE
        WHEN company.name IS NOT NULL THEN company.name
        ELSE 'Без компании'
    END AS company_name
FROM users
    LEFT JOIN company
        ON users.company_id  = company.id
WHERE extract(YEAR FROM date_joined ) = 2021
ORDER BY users.id ASC;


/*
 * SQL. Практика 6. Задача 8
 * 
 * Требуется вывести уникальные логины пользователей, которые отправляли на выполнение код, а также отправляли его на проверку.
 * Выведите только тех пользователей, которые зарегистрировались в апреле 2021.
 * Результат отсортируйте по возрастанию username.
 */
SELECT * FROM users LIMIT 5;
SELECT * FROM coderun LIMIT 5;
SELECT * FROM codesubmit LIMIT 5;

SELECT DISTINCT username 
FROM users
    LEFT JOIN coderun
        ON users.id = coderun.user_id
    LEFT JOIN codesubmit
        ON users.id = codesubmit.user_id
WHERE 
    coderun.user_id IS NOT NULL
    AND codesubmit.user_id IS NOT NULL
    AND users.date_joined BETWEEN make_date(2021, 04, 01) AND make_date(2021, 04, 30)
ORDER BY username ASC;


/*
 * SQL. Практика 6. Задача 9
 * 
 * Требуется вывести уникальные логины пользователей, которые отправляли на выполнение код, но не отправляли его на проверку.
 * Выведите только тех пользователей, которые зарегистрировались в апреле 2021.
 * Результат отсортируйте по возрастанию username.
 */
SELECT * FROM users LIMIT 5;
SELECT * FROM coderun LIMIT 5;
SELECT * FROM codesubmit LIMIT 5;

SELECT DISTINCT username 
FROM users
    LEFT JOIN coderun
        ON users.id = coderun.user_id
    LEFT JOIN codesubmit
        ON users.id = codesubmit.user_id
WHERE 
    coderun.user_id IS NOT NULL
    AND codesubmit.user_id IS NULL
    AND users.date_joined BETWEEN make_date(2021, 04, 01) AND make_date(2021, 04, 30)
ORDER BY username ASC;


/*
 * SQL. Практика 6. Задача 10
 * 
 * Требуется вывести уникальные идентификаторы пользователей, которые не решили ни одного теста.
 * Результат отсортируйте по возрастанию id.
 */

SELECT * FROM users LIMIT 5;
SELECT * FROM testresult LIMIT 5;

SELECT
    DISTINCT users.id
FROM users
    LEFT JOIN testresult
        ON testresult.user_id = users.id
WHERE testresult.user_id IS NULL
ORDER BY users.id;




/* ************************************************************
 * Объединение таблиц
 ************************************************************ */

/*
 * SQL. Практика 7. Задача 1
 * 
 * Напишите запрос, который из таблиц coderun и codesubmit объединяет информацию о всех операциях с кодом - запуск на выполнение и отправка на проверку.
 * Для записей из таблицы coderun укажите тип попытки run, а для codesubmit - submit
 */
SELECT * FROM coderun LIMIT 5;
SELECT * FROM codesubmit LIMIT 5;

SELECT
    user_id,
    problem_id,
    created_at,
    'run' AS attempt_type,
    language_id
FROM coderun
UNION ALL
SELECT 
    user_id,
    problem_id,
    created_at,
    'submit' AS attempt_type,
    language_id
FROM codesubmit;


/*
 * SQL. Практика 7. Задача 2
 * 
 * Напишите запрос, который из таблиц coderun и codesubmit выводит уникальные 
 * комбинации идентификаторов пользователей и идентификаторов задач, 
 * с которыми пользователи работали либо через выполнение кода либо через 
 * отправку кода на проверку.
 * Если пользователь работал с одной и той же задачей и через выполнение кода и 
 * через отправку кода на проверку, то такая комбинация должна быть выведена 
 * только один раз (используйте UNION)
 */
SELECT
    user_id,
    problem_id
FROM coderun
UNION 
SELECT 
    user_id,
    problem_id
FROM codesubmit;



/* ************************************************************
 * Группировки
 ************************************************************ */

/*
 * SQL. Практика 8. Задача 1
 * 
 * Вывести уровень сложности задач и количество задач для каждого уровня сложности.
 * Результат отсортируйте по возрастанию complexity.
 */
SELECT * FROM problem;

SELECT
    complexity,
    count(*) AS count_of_problems
FROM problem
GROUP BY complexity 
ORDER BY complexity ASC;


/*
 * SQL. Практика 8. Задача 2
 * 
 * Требуется вывести информацию только о тех пользователях, которые совершали транзакции типа Пополнение кошелька:
 * 
 *     - логин (username)
 *     - общая сумма транзакций (total_value)
 * 
 * Результат отсортируйте по возрастанию поля username.
 */
SELECT * FROM users;
SELECT * FROM "transaction";
SELECT * FROM transactiontype;

SELECT
    usr.username AS username,
    sum(tr.value) AS total_value
FROM "transaction" tr
    LEFT JOIN transactiontype trtype
        ON tr.type_id = trtype.TYPE
    LEFT JOIN users usr
        ON tr.user_id = usr.id
WHERE tr.type_id = 2
GROUP BY username
ORDER BY username ASC;


/*
 * SQL. Практика 8. Задача 3
 * 
 * Требуется вывести названия всех языков программирования и количество задач по этим языкам (language_name, problem_count).
 * Результат отсортируйте по возрастанию language_name.
 */
SELECT * FROM "language" ORDER BY name ASC;
SELECT * FROM languagetoproblem;
SELECT * FROM problem;

SELECT
    lang.name AS language_name,
    count(ltp.ltp_id) AS problem_count
FROM "language" lang
    LEFT JOIN languagetoproblem ltp
        ON ltp.lang_id = lang.id
GROUP BY lang."name" 
ORDER BY lang.name;


/*
 * SQL. Практика 8. Задача 4
 * 
 * Вывести информацию только о тех пользователях, которые совершали транзакции типа Пополнение кошелька
 *     - логин (username)
 *     - общая сумма транзакций (total_score)
 * 
 * Выведите только тех пользователей, у которых сумма пополнений кошелька превышает 500.
 * Результат отсортируйте по возрастанию username.
 */
SELECT * FROM users usr;
SELECT * FROM "transaction" tr;
SELECT * FROM transactiontype trt;

SELECT * FROM (
    SELECT
        usr.username AS username,
        sum(tr.value) AS total_score
    FROM "transaction" tr
        JOIN users usr
            ON tr.user_id = usr.id
                AND tr.type_id =2
    GROUP BY usr.username
    ) user_total_score
WHERE total_score > 500
ORDER BY username ASC;



/*
 * SQL. Практика 8. Задача 5
 * 
 * Требуется вывести следующую информацию:
 *     - логин (username)
 *     - количество отправленных на проверку решений (submission_count)
 * 
 * Выведите только тех пользователей, которые зарегистрировались в 2021 году и 
 * у которых количество отправленных на проверку решений превышает 200.
 * Результат отсортируйте по возрастанию username.
 */
SELECT * FROM users;
SELECT * FROM codesubmit;

SELECT
    username,
    submission_count
FROM (
    SELECT
        id,
        username
    FROM users
    WHERE extract(YEAR FROM date_joined ) = 2021
) usr
JOIN (
    SELECT 
        user_id,
        count(*) AS submission_count
    FROM codesubmit
    GROUP BY user_id
) cs
    ON usr.id = cs.user_id
WHERE submission_count > 200
ORDER BY username ASC;


/*
 * SQL. Практика 8. Задача 6
 * 
 * Вывести уникальное количество пользователей, которые отправляли код и на выполнение и на проверку.
 */
SELECT
    count(DISTINCT coderun.user_id) AS cnt_users
FROM coderun
    LEFT JOIN codesubmit
        ON coderun.user_id = codesubmit.user_id
WHERE
    coderun.user_id IS NOT NULL
    AND codesubmit.user_id IS NOT NULL;



/*
 * SQL. Практика 8. Задача 7
 * 
 * Вывести уникальное количество пользователей, которые отправляли код на выполнение, но не отправляли код на проверку.
 */
SELECT * FROM users;
SELECT * FROM coderun;
SELECT * FROM codesubmit;

SELECT
    count(DISTINCT coderun.user_id) AS cnt_users
FROM coderun
    LEFT JOIN codesubmit
        ON coderun.user_id = codesubmit.user_id
WHERE
    coderun.user_id IS NOT NULL
    AND codesubmit.user_id IS NULL;


/*
 * SQL. Практика 8. Задача 8
 * 
 * Вывести следующую информацию:
 *     
 *     - количество активных пользователей (cnt_active_users)
 *     - количество неактивных пользователей (cnt_not_active_users)
 */
SELECT
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) AS cnt_active_users,
    SUM(CASE WHEN is_active = 0 THEN 1 ELSE 0 END) AS cnt_not_active_users
FROM users;


/*
 * SQL. Практика 8. Задача 9
 * 
 * Требуется вывести количество активных и неактивных пользователей по всем наименованиям компаний.
 * Если в компании нет активных или неактивных пользователей, то выведите 0.
 * Результат отсортируйте по возрастанию company_name.
 */
SELECT * FROM users;
SELECT * FROM company;

-- Посмотрим на компании
SELECT 
    DISTINCT name
FROM company
ORDER BY name ASC;

-- Посмотрим на активных и неактивных пользователей
SELECT
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) AS cnt_active_users,
    SUM(CASE WHEN is_active = 0 THEN 1 ELSE 0 END) AS cnt_not_active_users
FROM users;

SELECT 
    name AS company_name,
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) AS cnt_active_users,
    SUM(CASE WHEN is_active = 0 THEN 1 ELSE 0 END) AS cnt_not_active_users
FROM (
    SELECT *
    FROM company
    LEFT JOIN users
        ON company.id = users.company_id
) users_companies
GROUP BY company_name
ORDER BY company_name ASC;


/*
 * SQL. Практика 8. Задача 10
 * 
 * Требуется вывести все электронные почты в виде списка, разделяя их точкой с запятой и 
 * пробелом (‘; ’) в отсортированном по возрастанию email
 */

SELECT string_agg(email, '; ') AS list_emails
FROM (
    SELECT email
    FROM users
    ORDER BY email ASC
) user_email;

-- Или

SELECT
    string_agg(email, '; ' ORDER BY email) AS list_emails
FROM users;



/*
 * SQL. Практика 8. Задача 11
 * 
 * Для каждой компании сформируйте список фамилий её пользователей.
 * 
 * Фамилии внутри списка:
 *     - разделите строкой ', '
 *     - расположите в порядке возрастания поля email.
 * 
 * Пользователей, у которых фамилия не указана, учитывать не нужно. 
 * В результате должны остаться только компании, у которых есть хотя бы один 
 * пользователь с указанной фамилией.
 */

SELECT * FROM (
    SELECT
        company.name AS company_name,
        string_agg(users.last_name, ', ' ORDER BY users.email) AS list_last_names
    FROM users
    LEFT JOIN company
        ON users.company_id = company.id
    GROUP BY company.name
) user_company
WHERE company_name IS NOT NULL
    AND list_last_names IS NOT NULL;

-- Или

SELECT
   company.name AS company_name,
   STRING_AGG(users.last_name, ', ' ORDER BY users.email) AS list_last_names
FROM users
JOIN company
    ON company.id = users.company_id
WHERE users.last_name IS NOT NULL
GROUP BY company.name
ORDER BY company_name;



/*
 * SQL. Практика 8. Задача 12
 * 
 * Требуется вывести следующую информацию по всем пользователям:
 *     - идентификатор
 *     - логин
 *     - наименование задачи, которую пользователь наиболее часто отправлял на проверку
 * 
 * Решите задачу с помощью функции MODE()
 * Если у пользователя несколько задач с одинаковой максимальной частотой отправки, 
 * то выберите задачу по наименованию задачи в алфавитном порядке.
 * Если пользователь ничего не отправлял, то выведите Пользователь ничего не отправлял.
 * 
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT * FROM users;
SELECT * FROM codesubmit;
SELECT * FROM problem;

SELECT
    users.id,
    users.username,
    CASE 
        WHEN mode() WITHIN GROUP (ORDER BY problem.name ASC) IS NOT NULL THEN mode() WITHIN GROUP (ORDER BY problem.name ASC)
        ELSE 'Пользователь ничего не отправлял'
    END
FROM users
LEFT JOIN codesubmit
    ON codesubmit.user_id = users.id
LEFT JOIN problem
    ON codesubmit.problem_id = problem.id
GROUP BY users.id, users.username
ORDER BY users.id;



/*
 * SQL. Практика 8. Задача 13
 * 
 * Из таблицы users выведите в одной строке массив значений поля username.
 * 
 * Элементы массива расположите:
 *     - по убыванию поля date_joined
 *     - при одинаковом значении date_joined — по возрастанию поля username
 */
SELECT
    array_agg(username ORDER BY date_joined DESC, username ASC)
FROM users;



/*
 * SQL. Практика 8. Задача 14
 * 
 * Вывести следующую информацию о пользователях, которые отправляли код на проверку:
 *     - идентификатор пользователя (id)
 *     - логин пользователя (username)
 *     - массив уникальных идентификаторов задач, которые пользователи отправляли 
 *       на проверку в отсортированном виде по возрастанию поля problem_id (unique_problem_ids_array)
 * 
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT * FROM users;
SELECT * FROM codesubmit;

SELECT
    users.id,
    users.username,
    --
    array_agg(DISTINCT codesubmit.problem_id ORDER BY codesubmit.problem_id ASC) AS unique_problem_ids_array
FROM users
    JOIN codesubmit
        ON users.id = codesubmit.user_id
GROUP BY users.id, users.username
ORDER BY users.id ASC;



/*
 * SQL. Практика 8. Задача 15
 * 
 * Рассчитайте какую оценку получили 95% активных пользователей, 
 * которые зарегистрировались после 1 января 2022 года и имеют оценку строго выше 100.
 * Примечание. Рассчитайте интерполированное значение, используя функцию PERCENTILE_CONT для 
 * непрерывных метрик (аналог функции PERCENTILE_DISC)
 */
SELECT * FROM users;

SELECT
    PERCENTILE_CONT(0.95) WITHIN GROUP (
        ORDER BY score ASC
    ) AS p95
FROM users
WHERE
    score > 100
    AND date_joined > make_date(2022, 01, 01);



/* ************************************************************
 * Подзапросы и CTE
 ************************************************************ */

-- Пример работы с подзапросами
SELECT 
    problem_id,
    avg(cnt)
FROM (
    SELECT
        user_id,
        problem_id,
        count(*) AS cnt
    FROM (
        SELECT 
            user_id,
            problem_id
        FROM coderun
        UNION ALL
        SELECT
            user_id,
            problem_id
        FROM codesubmit
    ) all_trials
    GROUP BY 
        user_id,
        problem_id
    ORDER BY 
        user_id ASC,
        problem_id ASC
) trials_by_users_and_problems
GROUP BY problem_id
ORDER BY problem_id ASC;

-- То же самое, только с использованием CTE
WITH 
    all_trials AS (
        SELECT 
            user_id,
            problem_id
        FROM coderun
        UNION ALL
        SELECT
            user_id,
            problem_id
        FROM codesubmit
    ),
    trials_by_users_and_problems AS (
        SELECT
            user_id,
            problem_id,
            count(*) AS cnt
        FROM all_trials
        GROUP BY 
            user_id,
            problem_id
        ORDER BY 
            user_id ASC,
            problem_id ASC
    )
SELECT 
    problem_id,
    avg(cnt)
FROM trials_by_users_and_problems
GROUP BY problem_id
ORDER BY problem_id ASC;


/*
 * SQL. Практика 9. Задача 1
 * 
 * Вывести пользователей с максимальным количеством очков опыта на платформе.
 */

SELECT 
    username,
    last_name,
    first_name,
    date_joined
FROM users
WHERE score = (SELECT max(score) FROM users);



/*
 * SQL. Практика 9. Задача 2
 * 
 * Вывести задачи, которые имеют рейтинг выше среднего.
 */
-- Посмотрим на значение рейтинга
SELECT avg(rating)
FROM problem;

SELECT 
    name,
    complexity,
    rating
FROM problem
WHERE rating > (SELECT avg(rating) FROM problem)
ORDER BY name ASC;



/*
 * SQL. Практика 9. Задача 3
 * 
 * вывести уникальные идентификаторы задач, для которых 
 * код был отправлен на проверку на языках SQL и Python.
 */
SELECT * FROM codesubmit;
SELECT * FROM "language";

SELECT
    DISTINCT problem_id
FROM codesubmit
WHERE
    language_id IN (SELECT id FROM "language" WHERE name LIKE 'Python' OR name LIKE 'SQL')
ORDER BY problem_id ASC;


/* 
 * SQL. Практика 9. Задача 4
 * 
 * Вывести идентификаторы пользователей, которые имеют более 5 правильных решений.
 * 
 * Правильное решение имеет значение is_false = 0.
 * Отправленный на проверку код находится в таблице codesubmit.
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT * FROM users;
SELECT * FROM codesubmit;

SELECT id FROM (
    SELECT 
        user_id AS id,
        count(is_false)
    FROM codesubmit
    WHERE is_false = 0
    GROUP BY user_id
    HAVING count(is_false) > 5
    ORDER BY id ASC
) users;


/*
 * SQL. Практика 9. Задача 5
 * 
 * вывести названия задач, у которых рейтинг не 
 * превышает 5 единиц от минимального рейтинга среди всех задач.
 * 
 * Результат отсортируйте по возрастанию поля name
 */
SELECT * FROM problem;
SELECT
    min(rating),
    min(rating)+5
FROM problem;

WITH
    rating_intervals AS (
        SELECT
            min(rating) AS lower_limit,
            min(rating)+5 AS upper_limit
        FROM problem
    )
SELECT
    name
    --rating
FROM problem, rating_intervals
WHERE rating <= rating_intervals.upper_limit
ORDER BY name ASC;


/*
 * SQL. Практика 9. Задача 6
 * Вывести идентификаторы пользователей, которые до 20 мая 2022 года включительно 
 * не отправляли на проверку код более 30 дней.
 * Результат отсортируйте по возрастанию поля user_id
 */
SELECT * FROM codesubmit;

WITH last_submissions AS (
    SELECT
        user_id,
        max(created_at) AS last_submission_date
    FROM codesubmit
    WHERE created_at <= make_date(2022, 05, 20)
    GROUP BY user_id
)
SELECT
    user_id
FROM last_submissions
WHERE
    last_submission_date < make_date(2022, 05, 20) - INTERVAL '30 days'
ORDER BY user_id ASC;


/*
 * SQL. Практика 9. Задача 7
 * 
 * Вывести идентификаторы пользователей, которые хотя бы один раз отправляли код на выполнение.
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT * FROM users;
SELECT * FROM coderun;

SELECT user_id AS id
FROM coderun
GROUP BY user_id
ORDER BY user_id ASC;



/*
 * SQL. Практика 9. Задача 8
 * 
 * Вывести идентификаторы пользователей, которые никогда не отправляли код на выполнение.
 * Результат отсортируйте по возрастанию поля id.
 */
SELECT * FROM users;
SELECT * FROM coderun;

SELECT
    users.id AS id
FROM users
LEFT JOIN coderun
    ON coderun.user_id = users.id
WHERE coderun.user_id IS NULL
ORDER BY users.id ASC;


/*
 * SQL. Практика 9. Задача 9
 * 
 * Вывести идентификаторы пользователей с company_id = 1 и имеющих количество очков опыта 
 * на платформе больше, чем хотя бы у одного из пользователей с company_id = 10.
 */
WITH
    score_level AS (
        -- Считаем минимальное значение рейтинга
        SELECT min(score) AS value
        FROM users
        WHERE company_id = 10
    )
SELECT 
    users.id
FROM users, score_level
WHERE
    users.company_id = 1 AND
        users.score > score_level.value
ORDER BY users.id ASC;
    


/*
 * SQL. Практика 9. Задача 10
 * 
 * Вывести идентификаторы пользователей с company_id = 7 и 
 * имеющих количество очков опыта на платформе больше каждого 
 * из пользователей с company_id = 6.
 */
WITH 
    score_level AS (
        SELECT max(score) AS value
        FROM users
        WHERE company_id = 6
    )
SELECT 
    users.id
FROM users, score_level
WHERE
    users.company_id = 7 AND
        users.score > score_level.value
ORDER BY users.id ASC;



/* ************************************************************
 * Оконные функции
 ************************************************************ */

SELECT
    *,
    row_number() OVER(
        PARTITION BY user_id
        ORDER BY type_id
    ) AS rn,
    rank() OVER(
        PARTITION BY user_id
        ORDER BY type_id
    ) AS rnk,
    dense_rank() OVER(
        PARTITION BY user_id
        ORDER BY type_id
    ) AS drnk
FROM "transaction"
WHERE user_id > 100
ORDER BY
    user_id, type_id;


SELECT
    *,
    lead(value) OVER(
        PARTITION BY user_id
        ORDER BY created_at
    ) AS next_val,
    lag(value) OVER(
        PARTITION BY user_id
        ORDER BY created_at
    ) AS prev_val,
    lag(value, 2, 0::smallint) OVER(
        -- Второй аргумент указывет на столько ячеек будет сдвиг
        -- Третий аргумент - значение по умолчанию вместо NULL
        PARTITION BY user_id
        ORDER BY created_at
    ) AS prev_val_2
FROM "transaction"
WHERE user_id > 100
ORDER BY
    user_id, created_at;

SELECT
    *,
    first_value(created_at) OVER(
        PARTITION BY user_id
        ORDER BY created_at
    ) AS first_dt,
    last_value(created_at) OVER(
        PARTITION BY user_id
        ORDER BY created_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS last_dt_current,
    last_value(created_at) OVER(
        PARTITION BY user_id
        ORDER BY created_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_dt_unbounded,
    created_at - first_value(created_at) OVER(
        PARTITION BY user_id
        ORDER BY created_at
    ) AS time_gap
FROM "transaction"
WHERE user_id > 100
ORDER BY
    user_id, created_at;


-- Сумма накопительным итогом
SELECT
    *,
    sum(value) OVER(
        PARTITION BY user_id
        ORDER BY created_at
    ) AS c_sum,
    sum(value) OVER(
        PARTITION BY user_id
        ORDER BY created_at
        -- Меняем повевединие окна и ставим все окно, вместо 
        -- интервала от начала до текущей строки
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS sum_total,
    sum(
        CASE WHEN type_id = 3 THEN -value ELSE value END
    ) OVER (
        PARTITION BY user_id
        ORDER BY created_at
    ) AS c_sum_vals,
    -- Скользящее среднее
    avg(value) OVER(
        PARTITION BY user_id
        ORDER BY created_at
    ) AS avg
FROM "transaction"
WHERE user_id > 100
ORDER BY
    user_id, created_at;


/*
 * SQL. Практика 10. Задача 1
 * 
 * вывести следующую информацию о задачах:
 * 
 *     - наименование задачи
 *     - рейтинг задачи
 *     - ранг задачи, где 1 ранг имеют задачи с наибольшим рейтингом (rank_rating)
 * 
 * Ранг должен рассчитываться с промежутками в значениях ранжирования.
 * Исключите записи, у которых рейтинг равен NULL.
 * Результат отсортируйте по возрастанию полей rank_rating и name.
 */
SELECT * FROM problem;

SELECT
    name,
    rating,
    rank() OVER(
        ORDER BY rating DESC
    ) AS rank_rating
FROM problem
WHERE rating IS NOT NULL
ORDER BY rank_rating, name;



/*
 * SQL. Практика 10. Задача 2
 * 
 * Вывести следующую информацию о пользователях:
 * 
 *     - идентификатор
 *     - логин
 *     - ранг пользователя (dns_rank_score)
 * 
 * 1 ранг имеют пользователи с наибольшим количеством очков опыта на платформе.
 * Результат отсортируйте по возрастанию полей dns_rank_score и id.
 */
SELECT * FROM users;

SELECT
    id,
    username,
    dense_rank() OVER (
        ORDER BY score DESC
    ) AS dns_rank_score
FROM users
WHERE score > 100
ORDER BY dns_rank_score, id;


/*
 * SQL. Практика 10. Задача 3
 * 
 * С помощью функции NTILE необходимо распределить задачи на 5 групп по их 
 * рейтингу и вывести следующую информацию:
 * 
 *     - группа, к которой относится задача (group_problem)
 *     - наименование задачи
 *     - рейтинг задачи
 * 
 * Группы: первой группе соответствуют задачи с наибольшим рейтингом
 * Оставьте только те задачи, у которых рейтинг не равен NULL
 * Результат отсортируйте по возрастанию поля group_problem, по убыванию поля 
 * rating и по возрастанию поля name.
 */
SELECT
    NTILE(5) OVER(
        ORDER BY rating DESC
    ) AS group_problem,
    name,
    rating
FROM problem
WHERE rating IS NOT NULL
ORDER BY
    group_problem ASC,
    rating DESC,
    name ASC;


/*
 * SQL. Практика 10. Задача 4
 * 
 * Необходимо вывести следующую информацию:
 * 
 *     - идентификатор пользователя (user_id)
 *     - дата и время входа на платформу (entry_at)
 *     - номер входа на платформу для каждого пользователя, где 
 *       1-й номер это последний вход на платформу (rn_entry_at)
 * 
 * Результат отсортируйте по возрастанию полей user_id и rn_entry_at
 */
SELECT * FROM userentry;

SELECT
	user_id,
	entry_at,
	row_number() OVER(
		PARTITION BY user_id
		ORDER BY entry_at DESC
	) AS rn_entry_at
FROM userentry
ORDER BY
	user_id ASC,
	rn_entry_at ASC;


/*
 * SQL. Практика 10. Задача 5
 * 
 * Напишите запрос, который выведет последнего зарегистрированного пользователя для компании.
 * 
 * В результате должны быть поля: company_name, username
 * Оставьте только те компании у которых были зарегистрированные пользователи
 *  
 * Результат отсортируйте по возрастанию поля company_name.
 * 
 */
SELECT * FROM users;
SELECT * FROM company;

SELECT
	company_name,
	username
FROM (
	SELECT
		users.id,
		users.date_joined,
		users.username,
		users.company_id,
		--
		company.id,
		company.name AS company_name,
		--
		 last_value(date_joined) OVER(
		 	PARTITION BY company.id
		 	ORDER BY date_joined ASC
		 	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
		) AS last_user
	FROM users
	LEFT JOIN company
		ON users.company_id = company.id
	WHERE users.company_id IS NOT NULL
	ORDER BY company.name ASC
) users_companies
WHERE date_joined = last_user;


/*
 * SQL. Практика 10. Задача 6
 * 
 * Напишите запрос, который выведет количество отправок кода на проверку для месяца, 
 * имеющего 7-й ранг по количеству отправок кода на проверку, отсортированных по убыванию.
 * 
 */
SELECT * FROM codesubmit;

SELECT
	*,
	dense_rank() OVER (
		ORDER BY created_at
	) AS rank
FROM codesubmit;


SELECT
	attempts_ranked.attempts AS submission_count
FROM (
	-- Ранг каждого месяца
	SELECT
		*,
		dense_rank() OVER(
			ORDER BY attempts DESC
		) AS submission_rank
	FROM (
		-- Количество отправок кода по месяцам
		SELECT
			date_trunc('month', created_at) AS month,
			count(created_at) AS attempts
		FROM codesubmit
		GROUP BY date_trunc('month', created_at)
		ORDER BY attempts DESC
	) attempts_by_months
) attempts_ranked
WHERE attempts_ranked.submission_rank = 7;


/*
 * SQL. Практика 10. Задача 7
 * 
 * Напишите запрос, который выведет для языков программирования название 
 * первой и последней задачи, отправленных проверку.
 * 
 * Оставьте только те языки программирования, у которых были отправленные 
 * на проверку задачи. В результате оставить поля: 
 * 
 * - language_name
 * - first_submission
 * - last_submission
 * 
 * Результат отсортируйте по возрастанию поля language_name.
 */
SELECT * FROM codesubmit;
SELECT * FROM problem;
SELECT * FROM "language";

SELECT
	lang.name AS language_name,
	first_problems.name AS first_submission,
	last_problems.name AS last_submission
FROM (
    -- Первые задачи
    SELECT
        problem_id,
        language_id,
        problem.name
    FROM (
        SELECT
            id,
            created_at,
            problem_id,
            language_id,
            first_value(created_at) OVER (
                PARTITION BY language_id
                ORDER BY created_at
            ) AS first_submission_date
        FROM codesubmit
    ) AS tasks_submissions
    LEFT JOIN problem
        ON tasks_submissions.problem_id = problem.id
    WHERE created_at = first_submission_date
) AS first_problems
LEFT JOIN (
    -- Последние задачи
    SELECT
        problem_id,
        language_id,
        problem.name
    FROM (
        SELECT
            id,
            created_at,
            problem_id,
            language_id,
            last_value(created_at) OVER (
                PARTITION BY language_id
                ORDER BY created_at
                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) AS last_submission_date
        FROM codesubmit
    ) AS tasks_submissions
    LEFT JOIN problem
        ON tasks_submissions.problem_id = problem.id
    WHERE created_at = last_submission_date
) AS last_problems
    ON first_problems.language_id = last_problems.language_id
LEFT JOIN "language" lang
	ON first_problems.language_id = lang.id
ORDER BY language_name ASC;

-- Эталонное решение

WITH language_submissions AS (
  SELECT
      l."name" AS language_name,
      FIRST_VALUE(p."name") OVER (PARTITION BY l."name" ORDER BY c.created_at) AS first_submission,
      LAST_VALUE(p."name") OVER (PARTITION BY l."name" ORDER BY c.created_at ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_submission
  FROM "language" l
  JOIN codesubmit c
      ON l.id = c.language_id
  JOIN problem p
      ON c.problem_id = p.id
)
SELECT
  language_name,
  first_submission,
  last_submission
FROM language_submissions
GROUP BY language_name, first_submission, last_submission
ORDER BY language_name;


/*
 * SQL. Практика 10. Задача 8
 * 
 * Напишите запрос, который из таблицы codesubmit выводит следующую информацию:
 * 
 *     - отформатированная в виде текста дата регистрации в формате YYYY-MM (yyyy_mm)
 *     - количество отправленных на проверку задач за каждый месяц (tasks_solved)
 *     - количество отправленных на проверку задач за 2 месяца назад (tasks_solved_two_months_ago)
 *     - количество отправленных на проверку задач за 2 месяца вперед (tasks_solved_two_months_ahead)
 * 
 * Результат отсортируйте по возрастанию поля yyyy_mm
 */
SELECT * FROM codesubmit;

SELECT
	*,
	to_char(created_at, 'YYYY-MM') AS yyyy_mm
FROM codesubmit;




