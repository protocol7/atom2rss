# HTML5 demos
This is a collection of some simple demos of new features in HTML5. It was first used during my talk at CADEC 2010.

The web socket server currently requires Jetty 7 trunk. To compile it, perform the following steps:
    svn co http://dev.eclipse.org/svnroot/rt/org.eclipse.jetty/jetty/trunk jetty
    cd jetty
    mvn install

After that, you should be able to build the websocket server by running:
    mvn compile

Start the server by running the JettyRunner class included in the sample.

The code is licensed under ASL 2.0, except for geo.html which is [CC-SA](http://creativecommons.org/licenses/by-sa/2.0/). geo.html is based on the similar demo from [html5demos.com](http://html5demos.com)