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

SELECT 
    DISTINCT name
FROM company
ORDER BY name ASC;

SELECT
    name AS company_name,
    SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) AS cnt_active_users,
    SUM(CASE WHEN is_active = 0 THEN 1 ELSE 0 END) AS cnt_not_active_users
FROM (
    SELECT
        users.id,
        users.is_active,
        company.name
    FROM users
    LEFT JOIN company
        ON users.company_id = company.id
) user_company
WHERE name IS NOT NULL 
GROUP BY company_name
ORDER BY name;