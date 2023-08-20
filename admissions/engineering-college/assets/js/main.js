
	$('.carousel').carousel({
	  interval: 4000
	})
	
	//$('#someTab').tab('show')

	$(document).ready(function() {
	  $('.owl-carousel').owlCarousel({
		loop: true,
		margin: 10,
		responsiveClass: true,
		responsive: {
		  0: {
			items: 1
			
		  },
		  600: {
			items: 3
		   
		  },
		  1000: {
			items: 3,
			loop: false,
			margin: 20
		  }
		}
	  })
	})
	
	
	// banner section
	
	$('.banner-section .owl-carousel').owlCarousel({
        items: 1,
        autoplay: true,
        loop: true,
        dots: false,
        margin: 0,
        nav: false,
        autoplayTimeout: 5000,
        autoplayHoverPause: false
    });
	
	$('#gallery .owl-carousel').owlCarousel({
		items:4,
		loop:true,
		margin:0,
		dots: false,
		autoplay:true,
    autoplayTimeout:1000,
    autoplayHoverPause:false,
		responsive: {
		  0: {
			items: 2
			
		  },
		  600: {
			items: 2
		   
		  },
		  1000: {
			items: 4,
			loop: true,
			margin: 10
		  }
		}
		
    });
	
	$('#placement-gallery .owl-carousel').owlCarousel({
		items:4,
		loop:true,
		margin:0,
		dots: false,
		autoplay:true,
    autoplayTimeout:3000,
    autoplayHoverPause:false,
		responsive: {
		  0: {
			items: 2
			
		  },
		  600: {
			items: 2
		   
		  },
		  1000: {
			items: 4,
			loop: true,
			margin: 10
		  }
		}
		
    });
	
	

$(function() {
  // This will select everything with the class smoothScroll
  // This should prevent problems with carousel, scrollspy, etc...
  $('.smoothScroll').click(function() {
    if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top - 96
        }, 1000); // The number here represents the speed of the scroll in milliseconds
        return false;
      }
    }
  });
  

});



// Change the speed to whatever you want
// Personally i think 1000 is too much
// Try 800 or below, it seems not too much but it will make a difference


//To change color on scroll
 $("body").scrollspy({
        target: ".navbar",
        offset: 98,
    });

	/* $(window).on('scroll',function() {
            if ($(this).scrollTop() > 500){  
                $('.fixed-enquire, .fixed-tap').css("display","block");
            }
            else{
				$('.fixed-enquire, .fixed-tap').css("display","none");
                
            }
		});	*/


/*
$(document).ready(function () {
    $(document).on("scroll", onScroll);
    
    //smoothscroll
    $('a[href^="#"]').on('click', function (e) {
        e.preventDefault();
        $(document).off("scroll");
        
        $('a').each(function () {
            $(this).removeClass('active');
        })
        $(this).addClass('active'); 
      
        var target = this.hash,
            menu = target;
        $target = $(target);
        $('html, body').animate({
            'scrollTop': $target.offset().top+136
        }, 1000, function () {
            window.location.hash = target;
            $(document).on("scroll", onScroll);
        });
    });
});

function onScroll(event){
    var scrollPos = $(document).scrollTop();
    $('.navbar a').each(function () {
        var currLink = $(this);
        var refElement = $(currLink.attr("href"));
        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
            $('.navbar ul li a').removeClass("active");
            currLink.addClass("active");
        }
        else{
            currLink.removeClass("active");
        }
    });
}
*/
