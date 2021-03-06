# Описание

Добавляем возможность создавать т.н. "Выдачи товаров" - `Suites`.

* Suite:
    * + title:string, null: false
    * has_many srows:
        * ord:integer, null: false, default: 10
        * belongs_to :suite
        * belongs_to :item
    * + where:string, default: 'before' # before, after
    * + url:string 
        

# Цитата из ТЗ

Функционал формирования выдач позволяет создавать специальные 
выдачи продуктов и выводить блок из каталога (блок выдачи) 
на любые страницы сайта кроме страниц: 
- контакты,
- дилеры,
- техническая информация,
- диллеры
- страницы диллеров.

Каждая выдача имеет следующие характеристики
- Название (например «Скидки до 50% на снегозадержатели» или «Линия жизни»)
- Набор товаров принадлежащих данной акции (набор) 
Для каждой страницы, на которой будет располагаться тот или иной блок 
выдачи, из панели управления сайтом можно выбрать место для расположения 
блока: перед основным содержанием страницы или после основного содержания.
Если на странице предполагается расположение нескольких различных блоков 
выдачи, то расположение каждого из них опять же задаются по принципу 
«после или перед основным содержанием страницы», а сам порядок блоков 
выдачи регулируется через установку порядкового номера каждому блоку. 
При этом существует отдельная нумерация (по порядковому номеру) для 
блоков расположенных перед основным содержанием страницы и после него.
Определение продуктов, которые войдут в ту или иную выдачу, производится 
вручную – из панели управления сайтом. При создании/редактировании той 
или иной выдачи выдачи, можно включать в состав выдачи любые продукты 
из базы каталога сайта, а также включать продукты в выдачу группами 
(категориями и подкатегориями)

Подобная организация функционала позволяет управлять блоками с 
продуктами на главной странице, а также позволяют вставлять необходимые 
выдачи на нужные страницы сайта, например на страницу конкретной акции 
без обращения к инструментарию программиста.
 
Также любая сформированная выдача может быть размещена во всплывающем 
окне каталога. При этом можно выбрать категорию, под стобцом которой 
будет размещена данная выдача (ссылка).
Каждая выдача имеет заранее предопределенное свойство "id". 
