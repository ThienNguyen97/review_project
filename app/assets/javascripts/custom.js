$(function() {
  return $('#search_place_name').autocomplete({
    source: $('#search_place_name').data('autocomplete-source')
  });
});

$(function() {
  return $('#address').autocomplete({
    source: $('#address').data('autocomplete-source')
  });
});

$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });
});

$(function() {
  return $('#city_name').autocomplete({
    source: $('#city_name').data('autocomplete-source'),
    change: function(event,ui){
      if (ui.item === null) {
          $(this).val("");
          $('#err_city_name').addClass("err-msg");
          $('#err_city_name').html(I18n.t("js_msg.city_not_found"));
      }else{
        $('#err_city_name').empty();
      }
    }
  });
});

$(function() {
  var firstProp = [];
  $('#city_name').on("change",function(){
    $.ajax({
        dataType: "json",
        type: 'GET',
        url: '/places',
        success: function( data ) {

          for (var i = 0;i<data.length;i++ ){
            if(data[i]["city_name"] == $('#city_name').val()){
              firstProp.push(data[i])
            }
          }
          return $('#post_place_name').autocomplete({
            source: firstProp,
            select: function(event,ui){
              $("#place_id").val(ui.item["id"]);
            },
            change: function(event,ui){
              if (ui.item === null) {
                  $(this).val("");
                  $('#place_id').val("");
                  $('#err_place_name').addClass("err-msg");
                  $('#err_place_name').html(I18n.t("js_msg.travel_place_not_found"));
              }else{
                $('#err_place_name').empty();
              }
            }
          });
        }
    });
  });
});

$.ui.autocomplete.prototype._renderItem = function (ul, item) {
        var newText = String(item.value).replace(
                new RegExp(this.term, "gi"),
                "<span class='ui-state-highlight'>$&</span>");

        return $("<li></li>")
            .data("item.autocomplete", item)
            .append("<div>" + newText + "</div>")
            .appendTo(ul);
};

/*Preview Image*/
$(function(){
  $(".upload-image").on("change", function(){
    var preview = document.querySelector('#preview');
    var files   = document.querySelector('input[type=file]').files;

    function readAndPreview(file) {

      if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
        var reader = new FileReader();

        reader.addEventListener("load", function () {
          var image = new Image();
          // image.height = 100;
          // image.width = 100;
          image.title = file.name;
          image.src = this.result;
          preview.appendChild( image );
        }, false);

        reader.readAsDataURL(file);
      }

    }
    if (files) {
      [].forEach.call(files, readAndPreview);
    }
  })
})
