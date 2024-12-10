package aps.onstage.service;

import aps.onstage.dao.ClienteDAO;
import aps.onstage.entity.Cliente;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class ClienteService {
    @Inject
    private ClienteDAO clienteDAO = new ClienteDAO();

    public Cliente buscarPerfil(Long id) {
        return clienteDAO.buscarClientePorId(id);
    }

    public void salvar() {
        clienteDAO.salvarCliente(id);
    }

    public void atualizar() {
        clienteDAO.alterarCliente(id);
    }

    public void excluir() {
        clienteDAO.excluirCliente(id);
    }
}
