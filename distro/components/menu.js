// JavaScript source code

var url = window.location.href;

var baseUrl = "";
if (url.indexOf('windows') > 0 ||
	url.indexOf('unix') > 0) {
	baseUrl = "../"; 
}


var baseUriParent = "../" + baseUrl;

var html = []; 
 html.push('<div class="navbar navbar-inverse navbar-fixed-top">');
		html.push('<div class="navbar-inner">');
		html.push('<div class="container">');
			html.push('<a class="brand" href="#">RCFProto</a>');
			html.push('<div class="nav-collapse collapse">');
				html.push('<ul class="nav">');
					html.push('<li data-bind="attr:{class: $data == \'index\' ? \'active\': \'\' }"><a href="' + baseUrl + 'index.html">Home</a></li>');
					html.push('<li data-bind="attr:{class: $data == \'get_start_csharp_java_python \'? \'active dropdown\': \' dropdown\' }">');
						
						//Drop Down Menu of Supported Platform. 
			
						html.push('<a class="dropdown-toggle" data-toggle="dropdown" role="button" href="#">Getting Started</a>');
						html.push('<ul class="dropdown-menu" style="margin-left:80px" role="menu">');
						//Windows
						html.push('<li role="presentation"><a role="menuitem" href="#" tabindex="-1" href="#"><b>Windows</b></a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl +'windows/csharp.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i>  C# </a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl + 'windows/cpp.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i> C++ </a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl + 'windows/java.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i> Java </a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl + 'windows/python.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i> Python </a></li>');

						html.push('<li role="presentation" class="divider"></li>');
						//Unix
						html.push('<li role="presentation"><a role="menuitem" href="#" tabindex="-1" href="#"><b>Unix </b></a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl + 'unix/cpp.html" tabindex="-1" href="#"><i class="icon-angle-right"></i> C++ </a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl + 'unix/java.html" tabindex="-1" href="#"><i class="icon-angle-right"></i> Java </a></li>');
						html.push('<li role="presentation"><a role="menuitem" href="' + baseUrl + 'unix/python.html" tabindex="-1" href="#"><i class="icon-angle-right"></i> Python </a></li>');
							
							

						html.push('</ul>');

						html.push('</li>');

//star//
					html.push('<li data-bind="attr:{class: $data == \'get_start_csharp_java_python \'? \'active dropdown\': \' dropdown\' }">');

					//Drop Down Menu of Supported Platform. 

					html.push('<a class="dropdown-toggle" data-toggle="dropdown" role="button" href="#">Documentation</a>');
					html.push('<ul class="dropdown-menu" style="margin-left:200px" role="menu">');					
					html.push('<li role="presentation"><a role="menuitem" href="' + baseUriParent + 'doc/index.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i>  RCFProto User Guide </a></li>');

					html.push('<li role="presentation"><a role="menuitem" href="' + baseUriParent + 'csharp/doc/html/index.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i>  C# Reference Documentation </a></li>');
					html.push('<li role="presentation"><a role="menuitem" href="' + baseUriParent + 'cpp/doc/html/index.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i> C++ Reference Documentation </a></li>');
					html.push('<li role="presentation"><a role="menuitem" href="' + baseUriParent + 'java/doc/html/index.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i> Java Reference Documentation </a></li>');
					html.push('<li role="presentation"><a role="menuitem" href="' + baseUriParent + 'python/doc/html/index.html" tabindex="-1" href="#"> <i class="icon-angle-right"></i> Python Reference Documentation </a></li>');

					



					html.push('</ul>');

					html.push('</li>');

//finish//
					
					html.push('<li><a href="http://www.deltavsoft.com/forums/">Forum</a></li>');
					html.push('<li><a href="http://www.deltavsoft.com/IssueTracker/">Issue Tracker</a></li>');
				html.push('</ul>');
			html.push('</div>');
		//<!--/.nav-collapse -->
		html.push('</div>');
	html.push('</div>');
html.push('</div>');

try{
	document.getElementById('top_navigation').innerHTML = html.join('');; 
}
catch (e) {
}
