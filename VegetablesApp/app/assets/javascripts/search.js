document.addEventListener("turbolinks:load", function(){
input = document.querySelector("[data-behavior='autocomplete']")
var options ={
    getValue: "name",
    url: function(phrase){
        return "/search.json?search="+phrase;
    },
    categories: [
        {
            listLocation: "products",
            header: "<strong>Products</strong>"
        }
    ],
    list: {
        onChooseEvent: function() {
            var url = $input.getSelectedItemData().url()
            console.log(url)
            Turbolinks.visit(url)
        }
    }
}
        $(input).easyAutocomplete(options)
}
);