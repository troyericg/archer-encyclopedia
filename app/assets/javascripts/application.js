// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


// On Scroll: Unhook top navigation 

$(window).scroll(function() {
	var $win = $(this);
	var $nav = $('div#nav-main');
    
	if (!$nav.hasClass("fixed") && ($win.scrollTop() + 10 > $nav.offset().top)) {
		$nav.addClass("fixed").data("top", $nav.offset().top);
	} else if ($nav.hasClass("fixed") && ($win.scrollTop() < $nav.data("top"))) {
		$nav.removeClass("fixed");
}});