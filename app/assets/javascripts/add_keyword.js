var text_template="</br><div class='component' id='keyword_div_NUM'><div class='form-group'><div class='col-md-4'>"
+"<input type='text' name='book[keyword[NUM]]' id='book[keyword][NUM]' class='keywords form-control'>"
+"</div></div></div>"+"</br></br>"


function click_handler(){
    var num = $('.keywords').length
    var textbox = $(text_template.split("NUM").join(num));
    var afterNum=num-1
    console.log(textbox);
   // textbox = $(textbox.replace("NUM", num));
   // var html = $('#new_book').html();
    //console.log(html);
    var id='#keyword_div_NUM'.split("NUM").join(afterNum);
    console.log(id);
    //$('#new_book:last').append(textbox).before('#add_book');
    $(textbox).insertAfter($(id));
    
    //alert("Hello World")
    console.log("went in click");
}