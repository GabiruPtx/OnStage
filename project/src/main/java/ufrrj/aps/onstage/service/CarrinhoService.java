// Serviço de Compra
public class CompraService {
    private CompraDAO compraDAO;
    private PagamentoService pagamentoService;

    public CompraService(CompraDAO compraDAO, PagamentoService pagamentoService) {
        this.compraDAO = compraDAO;
        this.pagamentoService = pagamentoService;
    }

    public void realizarCompra(Cliente cliente, List<Ingresso> ingressos) {
        Compra compra = new Compra();
        compra.setData(LocalDate.now());
        compra.setValorTotal(calcularTotalCompra(ingressos));
        compra.setMetodoPagamento("Cartão de Crédito"); // Hardcoded por exemplo
        compra.setIdPagamento(pagamentoService.efetuarPagamento(compra.getValorTotal()));
        compraDAO.salvarCompra(compra);
    }

    private double calcularTotalCompra(List<Ingresso> ingressos) {
        double total = 0.0;
        for (Ingresso ingresso : ingressos) {
            total += ingresso.getPreco() * ingresso.getQuantidade();
        }
        return total;
    }
}

// Serviço de Pagamento
