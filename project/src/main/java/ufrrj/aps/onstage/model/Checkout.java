package aps.onstage.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "checkout")
public class Checkout {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "cliente_id", referencedColumnName = "id")
    private Cliente cliente; // Cliente associado ao checkout

    @OneToMany(mappedBy = "checkout", cascade = CascadeType.ALL)
    private List<Ingresso> ingressos; // Lista de ingressos comprados no checkout

    @Column(name = "data_compra")
    private String dataCompra; // Data da compra

    @Column(name = "total_pago")
    private double totalPago; // Total pago pelo cliente

    // Getters e Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public List<Ingresso> getIngressos() {
        return ingressos;
    }

    public void setIngressos(List<Ingresso> ingressos) {
        this.ingressos = ingressos;
    }

    public String getDataCompra() {
        return dataCompra;
    }

    public void setDataCompra(String dataCompra) {
        this.dataCompra = dataCompra;
    }

    public double getTotalPago() {
        return totalPago;
    }

    public void setTotalPago(double totalPago) {
        this.totalPago = totalPago;
    }
}
