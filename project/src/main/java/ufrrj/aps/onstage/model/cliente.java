package ufrrj.aps.onstage.model;

public class cliente {

    private Long id;
    private String nome;
    private String sobrenome;
    private String email;
    private String senha;
    private String CPF;
    private String telefone;
    private String data_nasc;
    private endereco endereco;

    public cliente() {

    }

    public cliente(String nome, String sobrenome, String email, String senha, String CPF, String telefone, String data_nasc,
     String logradouro, String numero, String complemento, String bairro, String cidade, String uf, String cep) {

        this.nome = nome;
        this.sobrenome = sobrenome;
        this.email = email;
        System.out.println("Senha recebida no construtor: " + senha);
        this.senha = senha;
        this.CPF = CPF;
        this.telefone = telefone;
        this.data_nasc = data_nasc;
        this.endereco = new endereco(logradouro, numero, complemento, bairro, cidade, uf, cep);

    };

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public void setSobrenome(String sobrenome) {
        this.sobrenome = sobrenome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getCPF() {
        return CPF;
    }

    public void setCPF(String CPF) {
        this.CPF = CPF;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getData_nasc() {
        return data_nasc;
    }

    public void setData_nasc(String data_nasc) {
        this.data_nasc = data_nasc;
    }

    public endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(endereco endereco) {
        this.endereco = endereco;
    }

}
