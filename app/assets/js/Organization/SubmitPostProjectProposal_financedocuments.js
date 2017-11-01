  $("select").select2();
  (function() {

  	[].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
  		new CBPFWTabs(el);
  	});

  })();