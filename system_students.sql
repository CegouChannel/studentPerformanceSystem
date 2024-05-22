-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 22 2024 г., 15:33
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `system_students`
--

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `id_plan_training` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `name`, `id_plan_training`) VALUES
(2, 'ГН 1123', 1),
(3, 'ГП 1', 2),
(18, '123', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `journal`
--

CREATE TABLE `journal` (
  `id` int(11) NOT NULL,
  `id_student` int(11) NOT NULL,
  `id_lesson` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `estimate` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `journal`
--

INSERT INTO `journal` (`id`, `id_student`, `id_lesson`, `status`, `estimate`) VALUES
(30, 56, 1, 'болел', 0),
(31, 57, 1, 'не был', 0),
(32, 57, 1, 'болел', 3),
(38, 49, 1, 'болел', 0),
(39, 49, 2, 'болел', 5),
(40, 56, 2, 'болел', 4),
(41, 57, 2, 'не был', 5),
(46, 55, 3, 'болел', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `lessons`
--

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `id_plan` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `lessons`
--

INSERT INTO `lessons` (`id`, `id_plan`, `name`) VALUES
(1, 1, 'Основы скрипичной техники'),
(2, 1, 'Нотная грамота'),
(3, 2, 'Обучение вибрато'),
(4, 2, 'Техника левой руки'),
(5, 3, 'Мастерство исполнительского мастерства'),
(6, 3, 'Изучение крупных произведений');

-- --------------------------------------------------------

--
-- Структура таблицы `plans_training`
--

CREATE TABLE `plans_training` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `plans_training`
--

INSERT INTO `plans_training` (`id`, `name`) VALUES
(1, 'Новичок'),
(2, 'Профессионал'),
(3, 'Мастер');

-- --------------------------------------------------------

--
-- Структура таблицы `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `fio` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `group` int(11) NOT NULL,
  `phone` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `students`
--

INSERT INTO `students` (`id`, `fio`, `address`, `group`, `phone`) VALUES
(49, 'Лаухина Мария Алексеевна', 'УР, Завьяловский р-н, с. Ягул, ул. Халтурина, д. 12', 2, '89828224419'),
(55, 'Колотов Роман Владимирович', 'УР, Завьяловский р-н, с. Ягул, ул. Домашняя, д. Дома', 3, '89508205379'),
(56, 'Вахрушев Данил Константинович', 'УР, Завьяловский р-н, ул. 8 Марта, д. 3', 2, '89828224419'),
(57, 'Вахрушев Данил Константинович', 'УР, Завьяловский р-н, ул. 8 Марта, д. 3', 2, '89828224419'),
(62, 'Херингтон Билли Никитович', 'г. Сакшон, ул. Гачимуческая, д. 47б', 3, '8911212121212');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_plan_training` (`id_plan_training`);

--
-- Индексы таблицы `journal`
--
ALTER TABLE `journal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_lesson` (`id_lesson`),
  ADD KEY `journal_ibfk_2` (`id_student`);

--
-- Индексы таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_plan` (`id_plan`);

--
-- Индексы таблицы `plans_training`
--
ALTER TABLE `plans_training`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group` (`group`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `journal`
--
ALTER TABLE `journal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT для таблицы `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `plans_training`
--
ALTER TABLE `plans_training`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`id_plan_training`) REFERENCES `plans_training` (`id`);

--
-- Ограничения внешнего ключа таблицы `journal`
--
ALTER TABLE `journal`
  ADD CONSTRAINT `journal_ibfk_1` FOREIGN KEY (`id_lesson`) REFERENCES `lessons` (`id`),
  ADD CONSTRAINT `journal_ibfk_2` FOREIGN KEY (`id_student`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plans_training` (`id`);

--
-- Ограничения внешнего ключа таблицы `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`group`) REFERENCES `groups` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
