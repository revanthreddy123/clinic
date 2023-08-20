/*==================================================*
core.js
 http://www.creativ-technologies.com/

 *==================================================*/

//==================================================
// slide object
//==================================================
function slide(src,link,target,text,attr) {
  
  this.src = src;

  this.link = link;

  this.text = text;

  this.target = target;

  this.attr = attr;

  if (document.images) {
    this.image = new Image();
  }

  this.loaded = false;

  //--------------------------------------------------
  this.load = function() {

    if (!document.images) { return; }

    if (!this.loaded) {
      this.image.src = this.src;
      this.loaded = true;
    }
  }

  //--------------------------------------------------
  this.hotlink = function() {

    var mywindow;

    if (!this.link) return;

    if (this.target) {

      if (this.attr) {
        mywindow = window.open(this.link, this.target, this.attr);
  
      } else {
        mywindow = window.open(this.link, this.target);
      }

      if (mywindow && mywindow.focus) mywindow.focus();

    } else {
      location.href = this.link;
    }
  }
}

//==================================================
// slideshow object
//==================================================
function slideshow( slideshowname ) {

  this.name = slideshowname;

  this.repeat = true;

  this.prefetch = -1;

  this.image;

  this.textid;

  this.textarea;

  this.timeout = 6000;

  this.slides = new Array();
  this.current = 0;
  this.timeoutid = 0;

  //--------------------------------------------------
  // Public methods
  //--------------------------------------------------
  this.add_slide = function(slide) {
  
    var i = this.slides.length;
  
    if (this.prefetch == -1) {
      slide.load();
    }

    this.slides[i] = slide;
  }

  //--------------------------------------------------
  this.play = function(timeout) {
    this.pause();
  
    if (timeout) {
      this.timeout = timeout;
    }
  
    if (typeof this.slides[ this.current ].timeout != 'undefined') {
      timeout = this.slides[ this.current ].timeout;
    } else {
      timeout = this.timeout;
    }

    this.timeoutid = setTimeout( this.name + ".loop()", timeout);
  }

  //--------------------------------------------------
  this.pause = function() {
  
    if (this.timeoutid != 0) {

      clearTimeout(this.timeoutid);
      this.timeoutid = 0;

    }
  }

  //--------------------------------------------------
  this.update = function() {

    if (! this.valid_image()) { return; }
  
    if (typeof this.pre_update_hook == 'function') {
      this.pre_update_hook();
    }

    var slide = this.slides[ this.current ];

    var dofilter = false;
    if (this.image &&
        typeof this.image.filters != 'undefined' &&
        typeof this.image.filters[0] != 'undefined') {

      dofilter = true;

    }

    slide.load();
  
    if (dofilter) {

      if (slide.filter &&
          this.image.style &&
          this.image.style.filter) {

        this.image.style.filter = slide.filter;

      }
      this.image.filters[0].Apply();
    }

    this.image.src = slide.image.src;

    if (dofilter) {
      this.image.filters[0].Play();
    }

    this.display_text();

    if (typeof this.post_update_hook == 'function') {
      this.post_update_hook();
    }

    if (this.prefetch > 0) {

      var next, prev, count;

      next = this.current;
      prev = this.current;
      count = 0;
      do {

        if (++next >= this.slides.length) next = 0;
        if (--prev < 0) prev = this.slides.length - 1;

        this.slides[next].load();
        this.slides[prev].load();


      } while (++count < this.prefetch);
    }
  }

  //--------------------------------------------------
  this.goto_slide = function(n) {
  
    if (n == -1) {
      n = this.slides.length - 1;
    }
  
    if (n < this.slides.length && n >= 0) {
      this.current = n;
    }
  
    this.update();
  }


  //--------------------------------------------------
  this.goto_random_slide = function(include_current) {

    var i;

    if (this.slides.length > 1) {

      do {
        i = Math.floor(Math.random()*this.slides.length);
      } while (i == this.current);
 
      this.goto_slide(i);
    }
  }


  //--------------------------------------------------
  this.next = function() {
    if (this.current < this.slides.length - 1) {
      this.current++;
    } else if (this.repeat) {
      this.current = 0;
    }

    this.update();
  }


  //--------------------------------------------------
  this.previous = function() {
    if (this.current > 0) {
      this.current--;
    } else if (this.repeat) {
      this.current = this.slides.length - 1;
    }
  
    this.update();
  }


  //--------------------------------------------------
  this.shuffle = function() {

    var i, i2, slides_copy, slides_randomized;

    slides_copy = new Array();
    for (i = 0; i < this.slides.length; i++) {
      slides_copy[i] = this.slides[i];
    }

    slides_randomized = new Array();


    do {

      i = Math.floor(Math.random()*slides_copy.length);

      slides_randomized[ slides_randomized.length ] =
        slides_copy[i];

      for (i2 = i + 1; i2 < slides_copy.length; i2++) {
        slides_copy[i2 - 1] = slides_copy[i2];
      }
      slides_copy.length--;


    } while (slides_copy.length);

    this.slides = slides_randomized;
  }


  //--------------------------------------------------
  this.get_text = function() {
  
    return(this.slides[ this.current ].text);
  }


  //--------------------------------------------------
  this.get_all_text = function(before_slide, after_slide) {
  
    all_text = "";
  
    for (i=0; i < this.slides.length; i++) {
  
      slide = this.slides[i];
    
      if (slide.text) {
        all_text += before_slide + slide.text + after_slide;
      }
  
    }
  
    return(all_text);
  }


  //--------------------------------------------------
  this.display_text = function(text) {
    if (!text) {
      text = this.slides[ this.current ].text;
    }
  
    if (this.textarea && typeof this.textarea.value != 'undefined') {
      this.textarea.value = text;
    }

    if (this.textid) {

      r = this.getElementById(this.textid);
      if (!r) { return false; }
      if (typeof r.innerHTML == 'undefined') { return false; }

      r.innerHTML = text;
    }
  }


  //--------------------------------------------------
  this.hotlink = function() {
  
    this.slides[ this.current ].hotlink();
  }


  //--------------------------------------------------
  this.save_position = function(cookiename) {
  
    if (!cookiename) {
      cookiename = this.name + '_slideshow';
    }
  
    document.cookie = cookiename + '=' + this.current;
  }


  //--------------------------------------------------
  this.restore_position = function(cookiename) {
  
    if (!cookiename) {
      cookiename = this.name + '_slideshow';
    }
  
    var search = cookiename + "=";
  
    if (document.cookie.length > 0) {
      offset = document.cookie.indexOf(search);
      // if cookie exists
      if (offset != -1) { 
        offset += search.length;
        // set index of beginning of value
        end = document.cookie.indexOf(";", offset);
        // set index of end of cookie value
        if (end == -1) end = document.cookie.length;
        this.current = parseInt(unescape(document.cookie.substring(offset, end)));
        }
     }
  }


  //--------------------------------------------------
  this.noscript = function() {
  
    $html = "\n";
  
    for (i=0; i < this.slides.length; i++) {
  
      slide = this.slides[i];
  
      $html += '<P>';
  
      if (slide.link) {
        $html += '<a href="' + slide.link + '">';
      }
  
      $html += '<img src="' + slide.src + '" ALT="slideshow image">';
  
      if (slide.link) {
        $html += "<\/a>";
      }
  
      if (slide.text) {
        $html += "<BR>\n" + slide.text;
      }
  
      $html += "<\/P>" + "\n\n";
    }
  
    $html = $html.replace(/\&/g, "&amp;" );
    $html = $html.replace(/</g, "&lt;" );
    $html = $html.replace(/>/g, "&gt;" );
  
    return('<pre>' + $html + '</pre>');
  }


  //==================================================
  // Private methods
  //==================================================

  //--------------------------------------------------
  this.loop = function() {
    if (this.current < this.slides.length - 1) {
      next_slide = this.slides[this.current + 1];
      if (next_slide.image.complete == null || next_slide.image.complete) {
        this.next();
      }
    } else { 
      this.next();
    }
    
    this.play( );
  }


  //--------------------------------------------------
  this.valid_image = function() {
  
    if (!this.image)
    {
      return false;
    }
    else {
      return true;
    }
  }

  //--------------------------------------------------
  this.getElementById = function(element_id) {

    if (document.getElementById) {
      return document.getElementById(element_id);
    }
    else if (document.all) {
      return document.all[element_id];
    }
    else if (document.layers) {
      return document.layers[element_id];
    } else {
      return undefined;
    }
  }
  
  //--------------------------------------------------
  this.set_image = function(imageobject) {

    if (!document.images)
      return;
    this.image = imageobject;
  }

  //--------------------------------------------------
  this.set_textarea = function(textareaobject) {

    this.textarea = textareaobject;
    this.display_text();
  }

  //--------------------------------------------------
  this.set_textid = function(textidstr) {

    this.textid = textidstr;
    this.display_text();
  }
}
