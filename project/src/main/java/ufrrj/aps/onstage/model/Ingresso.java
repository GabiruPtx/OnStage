package aps.onstage.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Ingresso")
public class Ingresso {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;
    private String status;
    private String tipo;
    private int quantidade;
    private double preco;

    @Column(name = "data_compra")
    private String dataCompra;

    public Ingresso(String tipo, Double preco) {
        this.tipo = tipo;
        this.preco = preco;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Double getPreco() {
        return preco;
    }

    public void setPreco(Double preco) {
        this.preco = preco;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public String getDataCompra() {
        return dataCompra;
    }

    public void emitirIngresso() {
        // Lógica para emitir o ingresso
    }

    public void atualizarStatusIngresso() {
        // Lógica para atualizar o status do ingresso
    }

    public static Ingresso buscarPorCodigo(String codigo) {
        // Lógica para buscar um ingresso por código no banco de dados
        return ingresso;
    }

}
