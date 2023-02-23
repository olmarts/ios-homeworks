# РЕШЕНИЕ ДЗ "2.6 Жесты и анимация"

## Основное задание
1. На экране ProfileViewController добавьте обработку однократного нажатия на аватар пользователя.
2. При срабатывании нажатия должна запускаться анимация:
- Аватар пользователя перемещается в центр экрана и растягивается по ширине экрана, высота должна быть пропорциональной;
- Под аватаром пользователя показывается полупрозначная view, которая перекрывает остальные элементы на экране. Должна изменяться только прозрачность view;
- В правом верхнем углу появляется кнопка с иконкой крестика. Кнопка должна оставаться на одном месте, должна изменяться только прозрачность кнопки. Анимации аватара и view должны запускаться одновременно и длиться 0.5 секунды. Анимация кнопки должна запускаться после завершения анимации аватара и view и должна длиться 0.3 секунды
3. При нажатии на кнопку с иконкой крестика запускается обратная анимация:
- Скрывается кнопка с иконкой крестика
- Аватар возвращается в начальное положение, полупрозрачная view скрывается.

## Дополнительное задание (со звездочкой)
Добавьте анимацию для изменения cornerRadius у аватара пользователя. 
В начальном положении cornerRadius должен быть равен половине высоты imageView, в увеличенном состоянии - равен нулю.