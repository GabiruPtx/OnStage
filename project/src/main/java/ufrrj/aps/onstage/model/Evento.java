package aps.onstage.entity;

<<<<<<< HEAD
import jakarta.persistence.*;

@Entity
@Table(name = "Evento")
public class Evento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titulo;
    private String duracao;
    private String classificacao;
    private String sinopse;

    public Evento() {}

    public Evento(String titulo, String duracao, String classificacao, String sinopse) {
        this.titulo = titulo;
        this.duracao = duracao;
        this.classificacao = classificacao;
        this.sinopse = sinopse;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
=======
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
>>>>>>> onstage/Neo-preciso-corrigir-transicao
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

<<<<<<< HEAD
=======
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

>>>>>>> onstage/Neo-preciso-corrigir-transicao
    public String getDuracao() {
        return duracao;
    }

    public void setDuracao(String duracao) {
        this.duracao = duracao;
    }

<<<<<<< HEAD
    public String getClassificacao() {
        return classificacao;
    }

    public void setClassificacao(String classificacao) {
        this.classificacao = classificacao;
    }

    public String getSinopse() {
        return sinopse;
    }

    public void setSinopse(String sinopse) {
        this.sinopse = sinopse;
    }
=======
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

>>>>>>> onstage/Neo-preciso-corrigir-transicao
}
