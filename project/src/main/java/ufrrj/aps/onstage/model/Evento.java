package ufrrj.aps.onstage.model;

import java.util.List;

public class evento {

    private int id;
    private String titulo;
    private String descricao;
    private String class_indicativa;
    private String duracao;
    private String tipo;
    private String estado;
    private String imagem_url;
    private List<genero> generos;
    private fichaTecnica ficha;

    public evento() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getClass_indicativa() {
        return class_indicativa;
    }

    public void setClass_indicativa(String class_indicativa) {
        this.class_indicativa = class_indicativa;
    }

    public String getDuracao() {
        return duracao;
    }

    public void setDuracao(String duracao) {
        this.duracao = duracao;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getImagem_url() {
        return imagem_url;
    }

    public void setImagem_url(String imagem_url) {
        this.imagem_url = imagem_url;
    }

    public List<genero> getGeneros() {
        return generos;
    }

    public void setGeneros(List<genero> generos) {
        this.generos = generos;
    }

    public fichaTecnica getFicha() {
        return ficha;
    }

    public void setFicha(fichaTecnica ficha) {
        this.ficha = ficha;
    }

}
