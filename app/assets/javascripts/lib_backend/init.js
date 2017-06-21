// initialize your global object will all your model names
var C80_YAX = {

};

jQuery(document).ready(function ($) {
    // get the page action
    var action, model, b = $("body");
    if (b.hasClass("edit")) {
        action = "edit";
    } else if (b.hasClass("view")) {
        action = "view";
    } else if (b.hasClass("index")) {
        action = "index"
    } else if (b.hasClass("new")) {
        action = "new"
    }

    // run the code specific to a model and an action
    for (var m in C80_YAX) {
        if (b.hasClass("admin_" + m)) {
            if (C80_YAX[m][action] && typeof C80_YAX[m][action] == "function") {
                C80_YAX[m][action]();
                break;
            }
        }
    }
});