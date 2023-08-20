
(function ( $ ) {
 	"use strict";

    $.fn.social = function( options ) {

    	var settings = $.extend({
            fbAppID : $('meta[property="fb:app_id"]').attr("content"),
            url 	: $('meta[property="og:url"]').attr("content"),
            title 	: $('meta[property="og:title"]').attr("content"),
            desc 	: $('meta[property="og:description"]').attr("content"),
            image 	: $('meta[property="og:image"]').attr("content"),

        }, options );


    	//-----------------------------------
    	// Set the properties
    	//-----------------------------------
    	
    	var items = [
			{'name':'Facebook', 'icon':'<i class="fa fa-facebook"></i>'},
			{'name':'Twitter', 'icon':'<i class="fa fa-twitter"></i>'},
			//{'name':'GooglePlus', 'icon':'<i class="fa fa-google-plus-square"></i>'},
			{'name':'LinkedIn', 'icon':'<i class="fa fa-linkedin-square"></i>'},
			{'name':'Pinterest', 'icon':'<i class="fa fa-pinterest"></i>'}
			//{'name':'Reddit', 'icon':'<i class="fa fa-reddit"></i>'}
    	];

    	if (settings.fbAppID != undefined && settings.fbAppID != "1846245082330221") {
    		FBAsyncLoad();
    	} else {
    		items.splice(0, 1);
    	}

    	// set the ul style
    	var style = {
			'display'   	: "inline",
			"width"     	: "auto",
			"float"     	: "left",
			"list-style"	: "none",
			"padding-right" : "8px"
		}

    	var ul = $('<div/>', { class: "nav nav-pills nav-share" }).appendTo(this);
		for (var i = 0; i < items.length; i++) {
			var li = $('<li/>', {}).appendTo(ul);
			$(li).css(style);
			var a = $('<a/>', {href:"#", title:"Share on " + items[i]['name'], html: items[i]['icon'], id:i}).appendTo(li);
			$(a).data( "row_parent", this );
			$(a).on('click', function(event) {
			    event.preventDefault(); // To prevent following the link (optional)
			    share( $(this).attr('id') );
			    // $(this).data( "row_parent" ).share( $(this).attr('id') );
			});
		};

    	//-----------------------------------
    	// Share
    	//-----------------------------------
    	
    	function share(index) {
    		
    		var name = items[index]['name'].toLowerCase();
			if (name == 'facebook') {
				FBPost(settings.title, settings.desc, settings.url, settings.image);
			} else if (name == "twitter") {
				var url = "https://twitter.com/intent/tweet?"
				url += "text=" + encodeURIComponent(settings.title);
				url += "&url=" + encodeURIComponent(settings.url);
				popup(url, "Share on Twitter", 684, 550);
			} else if (name == "googleplus") {
				var url = "https://plus.google.com/share?url=" + encodeURIComponent(settings.url);
				popup(url, "Share on Google+", 600, 600);
			} else if (name == "linkedin") {
				var url = "http://www.linkedin.com/shareArticle?mini=true";
				url += "&url=" + encodeURIComponent(settings.url);
				url += "&title=" +encodeURIComponent(settings.title);
				url += "&summary=" + encodeURIComponent(settings.desc);
				url += "&source=Talsona";
				popup(url, "Share on LinkedIn", 600, 440);
			} else if (name == "pinterest") {
				var url = "//www.pinterest.com/pin/create/button/?";
				url += "url=" + encodeURIComponent(settings.url);
				url += "&media=" + settings.image;
				url += "&description=" + settings.title + ". " + settings.description;
				popup(url, "Share on Pinterest", 640, 500);
			} else if (name == "reddit") {
				var url = "http://www.reddit.com/submit?url=" + encodeURIComponent(settings.url);
				url += "&title=" + settings.title
				popup(url, "Share on Reddit", 640, 500);
			}

    	}

    	function popup(url, title, w, h) {
			var _left = (screen.width/2) - (w/2);
			var _top = (screen.height/2) - (h/2);
			var spec = "width=" + w + ", height=" + h + ", top=" + _top +", left=" + _left + ", toolbar=no";
			var win = window.open(url, title, spec );
    	}

    	//-----------------------------------
    	// Facebook
    	//-----------------------------------
    	
    	function FBAsyncLoad() {
    		window.fbAsyncInit = function() {
				FB.init({
				    appId   : settings.fbAppID,
				    oauth   : true,
				    status  : true, // check login status
				    cookie  : true, // enable cookies to allow the server to access the session
				    xfbml   : true // parse XFBML
				});
			};

			// Load the SDK asynchronously
			(function(d){
				var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
				if (d.getElementById(id)) {return;}
				js = d.createElement('script'); js.id = id; js.async = true;
				js.src = "//connect.facebook.net/en_US/all.js";
				ref.parentNode.insertBefore(js, ref);
			}(document));

			(function(d, debug){var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];if   (d.getElementById(id)) {return;}js = d.createElement('script'); js.id = id; js.async = true;js.src = "//connect.facebook.net/en_US/all" + (debug ? "/debug" : "") + ".js";ref.parentNode.insertBefore(js, ref);}(document, /*debug*/ false));

    	}

    	function FBPost(title, desc, url, image) {
			var obj = {
				method: 'feed',
				link: url, 
				name: title,
				description: desc
			};
			if (image != undefined) obj['picture'] = image;
			function callback(response){}
			FB.ui(obj, callback);
    	}

    }

}( jQuery ));
