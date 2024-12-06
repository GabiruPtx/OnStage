public class UsuarioDAO {
    public void salvarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuario (nome, email, senha, dataNascimento, telefone, cpf) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.setDate(4, usuario.getDataNascimento());
            stmt.setString(5, usuario.getTelefone());
            stmt.setString(6, usuario.getCpf());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao salvar usuário: " + e.getMessage());
        }
    }

    public void alterarUsuario(Usuario usuario){
        String sql = "UPDATE usuario SET nome = ?, email = ?, senha = ?, dataNascimento = ?, telefone = ?, cpf = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.setDate(4, usuario.getDataNascimento());
            stmt.setString(5, usuario.getTelefone());
            stmt.setString(6, usuario.getCpf());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao alterar as informações do usuário: " + e.getMessage());
        }
    }

    public void excluirUsuario(String id){
        String sql = "DELETE * FROM usuario WHERE id = ?";



    }
}
