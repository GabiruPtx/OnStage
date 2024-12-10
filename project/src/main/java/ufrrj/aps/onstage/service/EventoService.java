package aps.onstage.service;

import aps.onstage.dao.EventoDAO;
import aps.onstage.entity.Evento;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;

@ApplicationScoped
public class EventoService {
    @Inject
    private EventoDAO eventoDAO;

    public List<Evento> listarEventos() {
        return eventoDAO.listarEventos();
    }

    public Evento buscarPorId(Long id) {
        return eventoDAO.buscarPorId(id);
    }

    public void salvar(Evento evento) {
        eventoDAO.salvar(evento);
    }

    public void atualizar(Evento evento) {
        eventoDAO.atualizar(evento);
    }

    public void deletar(Long id) {
        eventoDAO.deletar(id);
    }
}
