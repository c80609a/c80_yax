var CookiesService = function() {

    var Support = function() {
        this.find_all_by_id = function(array, id) {
            var res = [];
            for (var i = 0; i < array.length; i++) {
                if (array[i]['id'] === id) {
                    res.push(i);
                }
            }
            return res;
        }
    };

    var __ = new Support();

    var _create_cookie = function(name, value, days) {
        var expires = '';

        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toGMTString();
        }

        document.cookie = encodeURIComponent(name) + '=' + JSON.stringify(value) + expires + "; path=/";

    };

    var _read_cookie = function(name) {
        // console.log('<CookiesService._read_cookie> name = ' + name);
        var nameEQ = encodeURIComponent(name) + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0) {
                var s = JSON.parse(c.substring(nameEQ.length, c.length));
                // console.log('<CookiesService._read_cookie> subs: ' + s);
                return s;
            }
        }
        return null;
    };

    this.cart_push = function(row_as_hash) {
        var cart = _read_cookie('cart3');
        if (cart === null) cart = [];
        
        // если в корзине уже лежат товары этого id - найдём их все
        var ids = __.find_all_by_id(cart, row_as_hash['id']);
        
        if (ids.length !== 0) {
            // пробежимся по этим товарам
            var existent_row;
            for (var i = 0; i < ids.length; i++) {
                existent_row = cart[ids[i]];
                // если цвет совпал - это товар того же цвета - мержим его
                console.log(existent_row['color']+'----'+row_as_hash['color']);
                if (existent_row['color'] === row_as_hash['color']) {
                    var old_price = existent_row['price'];
                    var old_quantity = existent_row['q'];
                    var new_row = existent_row;
                    new_row['price'] = Number(old_price) + Number(row_as_hash['price']);
                    new_row['q'] = Number(old_quantity) + Number(row_as_hash['q']);
                    cart[ids[i]] = new_row;
                    break;
                }
                // если товар того же айди разного цвета - это разные товары, добавляем новый
                else {
                    cart.push(row_as_hash);
                }
            }
        } else {
            cart.push(row_as_hash);
        }
        
        _create_cookie('cart3', cart, 256);
        console.log('<CookiesService.cart_push>');
    };

    this.cart_get = function() {
        var cart = _read_cookie('cart3');
        return cart;
    }

    this.cart_clean = function() {
        console.log('<cart_clean>');
        var cart = _read_cookie('cart3');
        if (cart === null) return;
        cart = [];
        _create_cookie('cart3', cart, 256);
    };

    this.cart_update_row = function(row_id, color, obj_with_new_values) {
        console.log('<cart_update_row>');
        var cart = _read_cookie('cart3');
        for (var i = 0, row; i < cart.length; i++) {
            row = cart[i];
            if (row['id'] != row_id) continue;
            if (row['color'] != color) continue;
            for (var key in obj_with_new_values) {
                row[key] = obj_with_new_values[key];
            }
            cart[i] = row; // нужно ли так делать?
        }
        _create_cookie('cart3', cart, 256);
    }

};