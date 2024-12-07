package aps.onstage.dao;

import aps.onstage.entity.Ingresso;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class IngressoDAO {
    @PersistenceContext
    private EntityManager em;

    public List<Ingresso> listarIngressos() {
        return em.createQuery("SELECT i FROM Ingresso i", Ingresso.class).getResultList();
    }

    public Ingresso buscarPorId(Long id) {
        return em.find(Ingresso.class, id);
    }

    public void salvar(Ingresso ingresso) {
        em.persist(ingresso);
    }

    public void atualizar(Ingresso ingresso) {
        em.merge(ingresso);
    }

    public void deletar(Long id) {
        Ingresso ingresso = em.find(Ingresso.class, id);
        if (ingresso != null) {
            em.remove(ingresso);
        }
    }
}
