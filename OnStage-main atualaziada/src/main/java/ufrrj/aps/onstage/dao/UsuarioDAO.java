public class UsuarioDAO {
    public void salvarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuario (nome, email, senha, dataNascimento, telefone, cpf) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.setDate(4, usuario.getDataNascimentoSQL());
            stmt.setString(5, usuario.getTelefone());
            stmt.setString(6, usuario.getCpf());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao salvar usuário: " + e.getMessage());
        }
    }

    public void alterarUsuario(Usuario usuario) {
        String sql = "UPDATE usuario SET nome = ?, email = ?, senha = ?, dataNascimento = ?, telefone = ?, cpf = ? WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.setDate(4, usuario.getDataNascimento());
            stmt.setString(5, usuario.getTelefone());
            stmt.setString(6, usuario.getCpf());
            stmt.setInt(7, usuario.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao alterar as informações do usuário: " + e.getMessage());
        }
    }

    public void excluirUsuario(int id) {
        String sql = "DELETE FROM usuario WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao excluir usuário: " + e.getMessage());
        }
    }

    public Usuario buscarUsuarioPorId(int id) {
        String sql = "SELECT * FROM usuario WHERE id = ?";
        Usuario usuario = null;

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setDataNascimento(rs.getDate("dataNascimento"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCpf(rs.getString("cpf"));
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar usuário: " + e.getMessage());
        }

        return usuario;
    }
}