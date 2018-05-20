	(function($){
	
			$.fn.extend({ 
				//plugin name - animatemenu
				hukSlide: function(options) {
					var defaults = {
					   mode: "fade",
					   autoStart: false,
					   direction: "left",
					   cid: "> a",
					   controlBox: false,
					   navi: false,
					   naviLink: true,
					   txtObj: false,
					   rollingNavi: false,
					   speed: 4000
					};
						 
					var options = $.extend(defaults, options);
					 
					return this.each(function() {
						var opt = options,
							parent = $(this),
							obj = $(".animateBox", this),
							imgWidth = obj.width(),
							chid = $(opt.cid, obj),
							items = $(chid, obj),
							rollNavi = opt.navi,
							subText = opt.txtObj,
							isClick = false,
							chidSize = chid.size(),
							currentNum = 0;
						if(opt.mode == "slide"){
							$(chid).addClass("s_item");
							$(chid).not($(chid).eq(currentNum)).css("left",imgWidth);
						}else if(opt.mode == "fade"){
							$(chid).addClass("f_item");
						};
						if(opt.naviLink){
							$(rollNavi).each(function(){
								$(this).wrapInner("<a href='#'></a>");
							});
							$(rollNavi).on("click","a",function(){
								clearInterval(timer);
								jQuery(".plug_stop",parent).text("시작").addClass("plug_play").removeClass("plug_stop");	
								var idx = $("a",rollNavi).index(this);
								goPage(idx);
							});
						};

						if(opt.autoStart){
							var timer = setInterval(function(){ // 처음 시작 시 자동 롤링
								if(opt.direction == "left"){
									nextPlay();
								}else if(opt.direction == "right"){
									prevPlay();
								};	
							},opt.speed);					
						};

						jQuery(this).on("click",".plug_next",function(){
							clearInterval(timer);
							jQuery(".plug_stop",parent).text("시작").addClass("plug_play").removeClass("plug_stop");							
							nextPlay();
						}).on("click",".plug_prev",function(){
							clearInterval(timer);
							jQuery(".plug_stop",parent).text("시작").addClass("plug_play").removeClass("plug_stop");								
							prevPlay();
						}).on("click",".plug_stop",function(){
							clearInterval(timer);
							jQuery(this).text("시작").addClass("plug_play").removeClass("plug_stop");
						}).on("click",".plug_play",function(){					
							jQuery(this).text("정지").addClass("plug_stop").removeClass("plug_play");
							imgPlay();
						});

						items.on("mouseenter",function() {
							clearInterval(timer);				 
						}).mouseleave(function() {
							imgPlay();
						});


						function nextPlay(){
							if(opt.mode == "fade"){
								if(isClick == false){
									isClick = true;
									currentNum++;
									
									if(currentNum >  $(chid).size()-1) currentNum=0;
									$(rollNavi).removeClass("active");
									$(rollNavi).eq(currentNum).addClass("active");
									$(chid).eq(currentNum-1).css("z-index",50).animate({"opacity":0},300,function(){
										isClick = false;
									});
									$(chid).eq(currentNum).css("z-index",100).animate({"opacity":1},300);
									if(subText){
										$(subText).eq(currentNum-1).animate({"opacity":0},150);
										$(subText).eq(currentNum).delay(250).animate({"opacity":1},150);
									};
								};
							}else if(opt.mode == "slide"){
								$(chid).not($(chid).eq(currentNum)).css("left",imgWidth);
								if(isClick == false){
									isClick = true;
									currentNum++;							
									if(currentNum > $(chid).size()-1) currentNum=0;
									$(rollNavi).removeClass("active");
									$(rollNavi).eq(currentNum).addClass("active");
									$(chid).eq(currentNum-1).animate({"left":-imgWidth},300,function(){
										$(chid).css("left",imgWidth);
										isClick = false;
									});
									$(chid).eq(currentNum).animate({"left":0},300);
									if(subText){
										$(subText).eq(currentNum-1).animate({"opacity":0},150);
										$(subText).eq(currentNum).delay(250).animate({"opacity":1},150);
									};
								};
							};			
						};		
						
						function prevPlay(){
							if(opt.mode == "fade"){						
								if(isClick == false){
									isClick = true;
									$(chid).eq(currentNum).css("z-index",50).animate({"opacity":0},300);
									if(subText){
										$(subText).eq(currentNum).animate({"opacity":0},150);
									};
									currentNum--;
									if(currentNum < 0) currentNum = chidSize-1;
									$(rollNavi).removeClass("active");			
									$(rollNavi).eq(currentNum).addClass("active");
									$(chid).eq(currentNum).css("z-index",100).animate({"opacity":1},300,function(){
										isClick = false;
									});
									if(subText){
										$(subText).eq(currentNum).delay(250).animate({"opacity":1},150);
									};
								};
							}else if(opt.mode == "slide"){
								$(chid).not($(chid).eq(currentNum)).css("left",-imgWidth);
								if(isClick == false){
									isClick = true;
									$(chid).eq(currentNum).animate({"left":imgWidth},300);
									if(subText){
										$(subText).eq(currentNum).animate({"opacity":0},150);
									};
									currentNum--;
									if(currentNum < 0) currentNum = chidSize-1;
									$(rollNavi).removeClass("active");			
									$(rollNavi).eq(currentNum).addClass("active");
									$(chid).eq(currentNum).animate({"left":0},300,function(){
										$(chid).not($(chid).eq(currentNum)).css("left",-imgWidth);
										isClick = false;
									});
									if(subText){
										$(subText).eq(currentNum).delay(250).animate({"opacity":1},150);
									};
								};
							};			
						};

						function imgPlay(){
							timer = setInterval(function(){
								if(opt.direction == "left"){
									nextPlay();
								}else if(opt.direction == "right"){
									prevPlay();
								};	
							},opt.speed);
						};

						function goPage(num){
							if(opt.mode == "fade"){
								if(isClick == false){
									isClick = true;
									$(chid).eq(currentNum).css("z-index",50).animate({"opacity":0},300,function(){
										isClick = false;
									});
									if(subText){
										$(subText).eq(currentNum).animate({"opacity":0},150);
									};
									currentNum = num;
									$(rollNavi).removeClass("active");
									$(rollNavi).eq(currentNum).addClass("active");
									$(chid).eq(currentNum).css("z-index",100).animate({"opacity":1},300);
									if(subText){
										$(subText).eq(currentNum).delay(250).animate({"opacity":1},150);
									};
								};
							}else if(opt.mode == "slide"){
								$(chid).not($(chid).eq(currentNum)).css("left",imgWidth);
								if(isClick == false){
									isClick = true;							
									$(chid).eq(currentNum).animate({"left":-imgWidth},300,function(){
										$(chid).css("left",imgWidth);
										isClick = false;
									});
									if(subText){
										$(subText).eq(currentNum).animate({"opacity":0},150);
									};
									currentNum = num;
									$(rollNavi).removeClass("active");
									$(rollNavi).eq(currentNum).addClass("active");
									$(chid).eq(currentNum).animate({"left":0},300);							
									if(subText){
										$(subText).eq(currentNum).delay(250).animate({"opacity":1},150);
									};
								};
							};			
						};

					});			
				}
			});
		})(jQuery);

		$(document).ready(function() {
			jQuery(".jwSlider").hukSlide({
				controlBox : ".controlBox",
				navi : ".eventNavi li",
				txtObj : ".subTxt li",
				direction : "right",
				autoStart : true
			});
		}); 




		