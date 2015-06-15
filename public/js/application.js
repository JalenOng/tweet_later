$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  // debugger;
  $("form").submit(function(e){
    var text = $("form").serialize();
    $("form").hide();
    $("div.container").append("<p><img src='/js/ajax-loader.gif'/>Tweeting to Pinpin's little bird...</p>");
    e.preventDefault();
    $.ajax({
      type: "post",
      url: "/tweet",
      data: text
    })
    .done(function(response){
      checkStatus(response)
    });
  });

   // setTimeout(3000);

   function checkStatus(job_id){

    $.ajax({
       type: "get",
       url: "/status/" + job_id
     })
     .done(function(response){

       if(response === "true"){
        $("p").remove();
         $("div.container").append("<p>Tweeted to Pinpin's little bird!</p>")
       }else{
         setTimeout(checkStatus(response), 3000)
       }
     })
   }

});

