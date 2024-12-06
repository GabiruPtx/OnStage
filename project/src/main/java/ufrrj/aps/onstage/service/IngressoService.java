package aps.onstage.service;

import aps.onstage.dao.IngressoDAO;
import aps.onstage.entity.Ingresso;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;

@ApplicationScoped
public class IngressoService {
    @Inject
    private IngressoDAO ingressoDAO;

    public List<Ingresso> listarIngressos() {
        return ingressoDAO.listarIngressos();
    }

    public Ingresso buscarPorId(Long id) {
        return ingressoDAO.buscarPorId(id);
    }

    public void salvar(Ingresso ingresso) {
        ingressoDAO.salvar(ingresso);
    }

    public void atualizar(Ingresso ingresso) {
        ingressoDAO.atualizar(ingresso);
    }

    public void deletar(Long id) {
        ingressoDAO.deletar(id);
    }
}
