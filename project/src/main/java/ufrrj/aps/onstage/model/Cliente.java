public class Cliente {
    private String nome;
    private int id;
    private LocalDate dataNascimento;
    private String email;
    private String telefone;
    private String cpf;
    private String senha;

    public Cliente() {}

    public Cliente(String nome, LocalDate dataNascimento, String email,
                   String telefone, String cpf, String senha) {
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.email = email;
        this.telefone = telefone;
        this.cpf = cpf;
        this.senha = senha;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getNome() {
        return nome;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public java.sql.Date getDataNascimentoSQL() {
        return (this.dataNascimento != null)
                ? java.sql.Date.valueOf(this.dataNascimento)
                : null;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getCpf() {
        return cpf;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getSenha() {
        return senha;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
