package aps.onstage.controller;

import aps.onstage.entity.Ingresso;
import aps.onstage.service.IngressoService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import java.util.List;

@Path("/ingressos")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class IngressoController {
    @Inject
    private IngressoService ingressoService;

    @GET
    public List<Ingresso> listarIngressos() {
        return ingressoService.listarIngressos();
    }

    @GET
    @Path("/{id}")
    public Ingresso buscarPorId(@PathParam("id") Long id) {
        return ingressoService.buscarPorId(id);
    }

    @POST
    public void salvar(Ingresso ingresso) {
        ingressoService.salvar(ingresso);
    }

    @PUT
    public void atualizar(Ingresso ingresso) {
        ingressoService.atualizar(ingresso);
    }

    @DELETE
    @Path("/{id}")
    public void deletar(@PathParam("id") Long id) {
        ingressoService.deletar(id);
    }
}

