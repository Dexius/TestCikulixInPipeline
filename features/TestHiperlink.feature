#language: ru

Функционал: Тестирование клика оп гиперссылке и параметра запуска

Контекст: 
	Дано Я подключаю TestClient "Сеанс Администратор" логин "Администратор" пароль ""
    И Я закрыл все окна клиентского приложения

Сценарий: Описание сценария
    Когда Я запускаю шаг cikuliX "КликПоГиперссылка.sikuli"
    И в логе сообщений TestClient есть строка 'Test'