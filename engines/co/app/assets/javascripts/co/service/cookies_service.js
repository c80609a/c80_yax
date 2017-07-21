var CookiesService = function() {

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
        console.log('<CookiesService._read_cookie> name = ' + name);
        var nameEQ = encodeURIComponent(name) + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0) {
                var s = JSON.parse(c.substring(nameEQ.length, c.length));
                console.log('<CookiesService._read_cookie> subs: ' + s);
                return s;
            }
        }
        return null;
    };

    this.cart_push = function(row_as_hash) {
        var cart = _read_cookie('cart3');
        if (cart === null) cart = [];
        cart.push(row_as_hash);
        _create_cookie('cart3', cart, 256);
        console.log('<CookiesService.cart_push>');
    };

    this.cart_clean = function() {
        var cart = _read_cookie('cart3');
        if (cart === null) return;
        cart = [];
        _create_cookie('cart3', cart, 256);
    };



};