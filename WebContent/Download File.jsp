<!DOCTYPE html>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.FileNameMap"%>
<%@page import="javax.activation.MimetypesFileTypeMap"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.*" %>

<html>
<head><title>Sample JSP Page</title></head>
<body>
<h1>Sample JSP Page</h1>
<h2>Time on server: <%= new Date() %></h2>
<p>
This is a simple JSP page. When first learning, make a new Dynamic Web app in Eclipse,
copy this file to the WebContent folder, deploy the app, start the server, and access 
the page with http://localhost/<i>appName</i>/hello.jsp.

<% 

ServletOutputStream output = response.getOutputStream();

try {
	
	String filePath = request.getParameter("filePath").toString();

	File file = new File(filePath);
	FileInputStream fileIn = new FileInputStream(file);
		
	//Carrega mimetype
	FileNameMap fileNameMap = URLConnection.getFileNameMap();
	String type = fileNameMap.getContentTypeFor(filePath);
	
	response.setContentType(type);	
	response.setHeader("Content-Disposition","inline;filename=" + file.getName());	
	
	byte[] outputByte = new byte[4096];
	//copy binary contect to output stream
	while(fileIn.read(outputByte, 0, 4096) != -1) {
		output.write(outputByte, 0, 4096);
	}
	
	response.setContentLength(outputByte.length * 4096);
	
	fileIn.close();
	

} catch (Exception e) {
	output.println("Não foi possível carregar o arquivo<br><br><b>Erro:<b><br>" + e.toString());
	
}

output.flush();
output.close(); 

%>

</p>
</body></html>