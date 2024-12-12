package ufrrj.aps.onstage.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/protected/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
            
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String path = httpRequest.getRequestURI();

        // Adiciona atributos na request para controlar a exibição dos botões
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        request.setAttribute("isLoggedIn", isLoggedIn);

        if (isLoggedIn) {
            // Adiciona informações do usuário se estiver logado
            if (session != null) {
                request.setAttribute("nomeUsuario", session.getAttribute("nomeUsuario"));
                request.setAttribute("emailUsuario", session.getAttribute("emailUsuario"));
            }

            chain.doFilter(request, response);
        } else {
            httpResponse.setContentType("application/json");
            httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            httpResponse.getWriter().write("{\"error\": \"Não autorizado\", \"message\": \"Faça login para acessar este recurso\"}");
        }
    }

}
