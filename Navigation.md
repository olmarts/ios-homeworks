# Домашнее задание
# 1.3 Навигация в iOS и жизненный цикл UIViewController
На занятии вы узнали про UIViewController и его жизненный цикл. Также мы поговорили о том, как устроена навигация в iOS приложениях.

В этом практическом задании вам нужно создать приложение, используя разичные типы навигации. Ниже подробно описаны требования и ограничения к заданию.

## Правила выполнения домашней работы:
- Все задачи обязательны к выполнению для получения зачета, кроме задач со звездочкой. 
- Присылать на проверку можно каждую задачу по отдельности или все задачи вместе. Во время проверки по частям ваша домашняя работа будет со статусом "На доработке".
- Любые вопросы по решению задач задавайте в чате учебной группы.
### Оформление результата:
- Ознакомьтесь с инструкцией по использованию Pull Request для сдачи дз https://github.com/netology-code/iosui-homeworks/blob/iosui-8/Pull%20requests'%20guideline.md
- Внимание! Для данного и последующих заданий нужно создать отдельный репозиторий. В этом репозитории должен быть только один проект. Для каждого ДЗ создается своя ветка.
- При сдаче работы прикрепите в личный кабинет ссылку на Pull Request с выполненной работой
- Важно: в этом и следующих заданиях вам необходимо реализовать навигацию и вёрстку приложения с помощью кода. Мы постепенно отказываемся от использования сторибордов - разработчики чаще используют вёрстку кодом.

## Задание
1. Создайте новый проект с названием Navigation, используя шаблон Single View App.
2. Удалите из проекта Main.storyboard, который создался по умолчанию. Не забудьте изменить конфигурацию в Info.plist.
3. В AppDelegate.swift добавьте UITabBarController. Добавьте в него два UINavigationController. Первый будет показывать ленту пользователя, а второй — профиль.
4. Измените Tab Bar Item у добавленных контроллеров, добавьте заголовок и картинку. Картинки можно добавить в Assets.xcassets или использовать SF Symbols.
5. Создайте FeedViewController и ProfileViewController и добавьте их как root view controller у навигационных контроллеров.
6. Добавьте PostViewController для показа выбранного поста. Поменяйте заголовок у контроллера и цвет главной view. Добавьте кнопку на FeedViewController и сделайте переход на экран поста. Контроллер должен показаться в стеке UINavigationController.
7. Создайте структуру Post со свойством title: String. Создайте объект типа Post в FeedViewController и передайте его в PostViewController. В классе PostViewController выставьте title полученного поста в качестве заголовка контроллера.
8. На PostViewController добавьте Bar Button Item в навигейшн бар. При нажатии на него должен открываться новый контроллер InfoViewController. Контроллер должен показаться модально.
9. На InfoViewController создайте кнопку. При нажатии на неё должен показаться UIAlertController с заданным title, message и двумя UIAlertAction. При нажатии на UIAlertAction в консоль должно выводиться сообщение.

## РЕШЕНИЕ
Смысл задания в том, чтобы разобраться как работает навигация различных типов.
1. Нижняя панель таб-навигации UITabBarController переключает экраны Feed и Profile;
2. Кнопка UIButton на Feed для пуш-перехода к экрану поста (пуш покажет верхний бар, откуда можно pop-вернуться в ленту);
3. Кнопка справа в верхнем баре UIBarButtonItem экрана поста чтобы модально показать экран "Info";
4. Кнопка UIButton на экране "Info" для подтверждения/отмены закрытия модального экрана информации и возврата к посту, через UIAlertController. 

### 1. Удаление из проекта Main.storyboard, который создался по умолчанию. 
Создаем новый проект с названием Navigation, используя шаблон iOS/App.
Открываем TARGETS (выделив самый первый пункт навигатора), и в нем открываем вкладку Info.
1) Удалить строку (4-я сверху) 'Main storyboard file base name': Main.
2) Удалить строку (внизу в разделе Application Scene Manifest/Scene Configuratiion/Application Session Role/Item 0) 'Storyboard Name': Main.
3) Проверить файл Info.plist - такая же строка как в п.2 со ссылкой на Main также должна исчезнуть.
4) Command+B.

### 2. Удаление из проекта ViewController.swift, который создался по умолчанию.
Удаляем этот файл из навигатора. Если не него не было ссылок, то нет проблем.

### 3. Создаем класс TabBarViewController (пока пустой, код позже).
Это плоский таб-навигатор внизу приложения.
final class TabBarViewController: UITabBarController
Он создается именно на этом этапе, поскольку на этот класс будет ссылка в AppDelegate на следующем шаге. 

### 4. Файлы SceneDelegate.swift и AppDelegate.swift.
Удаляем файл SceneDelegate.swift из навигатора, поскольку по требованию ДЗ мы работаем с главным окном приложения, которое должно быть создано в AppDelegate.
В левой панели поиска 'Find Navigator' ищем по слову Scene, чтобы знать где потенциальные источники проблем из-за этих битых ссылок.  
Проблема после удаления файла SceneDelegate.swift:
Если в симуляторе window?.backgroundColor станет черным (или прозрачным), то
в Info.plist надо просто удалить ВСЮ ветку 'Scene Configuration', это поможет (при условии если явно задан цвет в window?.backgroundColor).
После чего код в классе AppDelegate:
```
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // создаем свойство как в классе SceneDelegate:
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // создаем и настраиваем главное окно приложения:
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemGray5
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        // возвращаем обязательный результат:
        return true
    }
}
```

### 5. Создаем структуру которая представляет минимальную информацию о посте в ленте.
```
struct Post {
    var title: String
}
```

### 6. Создаем классы контроллеров (пока пустые, код позже).
- Лента пользователя:   final class FeedViewController: UIViewController 
- Профиль пользователя: final class ProfileViewController: UIViewController
- Показывает один пост: final class PostViewController: UIViewController
- Информация о посте:   final class InfoViewController: UIViewController 

### 7. Пишем код в классе TabBarViewController.
Класс обеспечивает таб-переходы к двум контроллерам: FeedViewController и ProfileViewController.
Соответственно этот класс должен:
1. Содержать 2 свойства класса:
```
private let feedVC = FeedViewController()
private let profileVC = ProfileViewController()
```
2. Иметь значение массива: 
```
self.viewControllers = [navigationFeedVC, navigationProfileVC] 
```
 Массив содержит 2 навигационных контроллера класса UINavigationController, которые обеспечивают таб-переходы на связанные с ними свойства-контроллеры self.feedVC и self.profileVC соответственно.  

### 8. Пишем код для контроллеров.
Схема навигации:
- Лента FeedViewController покажется сразу же, так как он первый в массиве TabBarViewController.viewControllers.
  При этом TabBarViewController задан рутовым в AppDelegate: window?.rootViewController = TabBarViewController().
- Рядом с FeedViewController находится ProfileViewController, переходы между ними обеспечивает TabBarViewController. То есть, эти два контроллера на одном уровне навигации.
- На ленте FeedViewController по центру кнопка "Show post" класса UIButton, чтобы пушем перейти к посту, то есть показать PostViewController.
- На PostViewController есть вверху справа бар-батн "Info" класса UIBarButtonItem чтобы модально показать InfoViewController.
- На InfoViewController по центру кнопка "Назад" класса UIButton, чтобы закрыть свое модальное окно, причем при закрытии покажется алерт-окно UIAlertController с 2-мя алерт-экшнами "Да"/"Отмена". При нажатии на них, в консоль выводятся соответствующие сообщения.

### 9. Command+R. Проверяем работу приложения, вся навигация должна работать.


