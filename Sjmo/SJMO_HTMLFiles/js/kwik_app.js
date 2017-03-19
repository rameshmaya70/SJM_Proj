//Android/IOS bridge call.
var BASE_URL  = ''
function executeAndroid(controllerPath, argJson){
	if(typeof Android != 'undefined' && Android!=null){
		try{
                   
		return Android.execute(controllerPath, argJson);
		}catch(e){
			alert('Error-'+e);
		}
	}
	else {
            
            return Android.execute(controllerPath, argJson);
		
	}
}
function executeiOS(controllerPath, argJson){
	if(typeof ios != 'undefined' && ios!=null){
		try{
			return ios.execute(controllerPath, argJson);
		}catch(e){
			alert('Error-'+e);
		}
	}
	else {
		alert('ios not bound');
	}
}

//called from html page with url similar to android:/auth/login, json arguments and call back function to populate resonse on page. The render function is called back once the execution is complete.
function execute(controllerPath, argJson,callbackFn){	

	var responseStr = null;
	
		executeAndroid(controllerPath, argJson);
                 	
	
}

function render(responseStr){

	var jsonObject = jQuery.parseJSON(responseStr);
	
	var view = jsonObject.view;
	
	if(view.indexOf('.html')==-1){
		view = view+".html";
	}
	
	$.ajax(BASE_URL+view, {
		type: "GET",
        contentType: "text/html; charset=utf-8",
		dataType: "html",
    	success: function(html) {
			compileRender(view,html,jsonObject);
    	},
    	error: function(jqXHR, textStatus, errorThrown) {
      		alert('error'+errorThrown);
    	}
  });
}

function compileRender(view, html,jsonObject){

    var compiled = dust.compile(html, view);
    
	dust.loadSource(compiled);
	
	dust.render(view, jsonObject, function(err, out) {
		//console.log(out);
		$("#appBody").html(out);
		$("#page").show();
	});	
}

function loadPage(url){
       alert("Before");
	if(url.indexOf('/')==-1){
            alert("inside if");
		render('{"view":"'+url+'"}');
	}else{
            
		execute(url,"{}",null);
	}
}