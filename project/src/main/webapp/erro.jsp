<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Erro</title>
</head>
<body>
    <h1>Erro</h1>
    <p>${erro != null ? erro : "Ocorreu um erro desconhecido"}</p>
    <a href="index.jsp">Voltar para a página inicial</a>
</body>
</html>