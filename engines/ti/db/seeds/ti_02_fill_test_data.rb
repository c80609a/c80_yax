# rake db:seed:ti_02_fill_test_data

Ti::Category.delete_all
Ti::Category.create!([
                         { ord: 10, id: 1, title: 'Монтажные инструкции' }
                     ])

Ti::Category.create!([
                         { ord: 100, title: 'Водосточные системы', parent_category_id: 1},
                         { ord: 110, title: 'Снегозадержатели', parent_category_id: 1},
                         { ord: 120, title: 'Лестницы', parent_category_id: 1},
                         { ord: 130, title: 'Кровельные мостики и ограждения', parent_category_id: 1},
                         { ord: 140, title: 'Продукция из меди', parent_category_id: 1}
                     ])

Ti::Doc.delete_all
Ti::Doc.create!([
                    { title: 'Монтаж круглой водосточной системы P87', category_ids: [100] },
                    { title: 'Монтаж круглого водосточного желоба P13', category_ids: [100] },
                    { title: 'Монтаж прямоугольной водосточной системы K12', category_ids: [100] },
                    { title: 'Установка водосточной трубы P10 и K9x9', category_ids: [100] },
                    { title: 'Установка внутреннего кронштейна прямоугольной водосточной системы', category_ids: [100] }
                ])