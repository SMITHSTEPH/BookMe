var text_template="</br><input type='text' name='book[keyword[NUM]]' id='book[keyword][NUM]' class='keywords'>"
var num=1;

function click_handler(){
    var num = $('.keywords').length
    var textbox = $(text_template.split("NUM").join(num));
    console.log(textbox);
   // textbox = $(textbox.replace("NUM", num));
    var html = $('#new_book').html();
    console.log(html);
    //$('#new_book:last').append(textbox).before('#add_book');
    $(textbox).insertBefore('#add_book');
    
    //alert("Hello World")
    console.log("went in click");
}

  
    


/*$(function() {
    var template = "<textarea name='quiz[content][INDEX]'></textarea>",
        index = $('textarea').length,
        compiled_template;
    
    $('#js-add-question-row').click(function() {
        compiled_textarea = $(template.replace("INDEX", index));
        $('#someform').append(compiled_textarea);
        index = index + 1;
    });
});*/