var text_template="<input type='text' name='book[keyword][NUM]'></br>"
var num=0;

function click_handler(){
    var textbox = $(text_template.replace("NUM", num));
    var html = $('#new_book').html();
    console.log(html);
    $('#new_book').append(textbox);
    num=num+1;
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