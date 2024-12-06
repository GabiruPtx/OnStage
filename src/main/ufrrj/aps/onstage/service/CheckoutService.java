public class PagamentoService {
    private PagamentoDAO pagamentoDAO;

    public PagamentoService(PagamentoDAO pagamentoDAO) {
        this.pagamentoDAO = pagamentoDAO;
    }

    public long efetuarPagamento(double valor) {
        Pagamento pagamento = new Pagamento();
        pagamento.setValor(valor);
        pagamento.setStatus("Aprovado"); // Hardcoded por exemplo
        long id = pagamentoDAO.salvarPagamento(pagamento);
        return id;
    }

    public void atualizarStatusPagamento(long id, String novoStatus) {
        Pagamento pagamento = pagamentoDAO.buscarPorId(id);
        pagamento.setStatus(novoStatus);
        pagamentoDAO.atualizarPagamento(pagamento);
    }
}