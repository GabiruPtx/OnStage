public class CheckoutServlet extends HttpServlet {
   // private PagamentoService pagamentoService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long idCompra = Long.parseLong(request.getParameter("idCompra"));
        String metodoPagamento = request.getParameter("metodoPagamento");

        // Chamar o serviço de pagamento para efetuar o pagamento
       // long idPagamento = pagamentoService.efetuarPagamento(idCompra, metodoPagamento);

        response.sendRedirect("/confirmar-pagamento?idPagamento=" + idPagamento);
    }
}