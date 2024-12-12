package ufrrj.aps.onstage.model;

import java.time.LocalDateTime;
import java.util.List;

public class Checkout {
    
    private int id;
    private int idCliente;
    private double valorTotal;
    private String tipoPagamento;
    private LocalDateTime dataPagamento;
    private List<Integer> idIngressos;

    public Checkout() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public String getTipoPagamento() {
        return tipoPagamento;
    }

    public void setTipoPagamento(String tipoPagamento) {
        this.tipoPagamento = tipoPagamento;
    }

    public LocalDateTime getDataPagamento() {
        return dataPagamento;
    }

    public void setDataPagamento(LocalDateTime dataPagamento) {
        this.dataPagamento = dataPagamento;
    }

    public List<Integer> getIdIngressos() {
        return idIngressos;
    }

    public void setIdIngressos(List<Integer> idIngressos) {
        this.idIngressos = idIngressos;
    }



}