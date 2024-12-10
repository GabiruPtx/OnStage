public class ClienteDAO {
    public void salvarCliente(Cliente cliente) {
        String sql = "INSERT INTO cliente (nome, email, senha, dataNascimento, telefone, cpf) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getEmail());
            stmt.setString(3, cliente.getSenha());
            stmt.setDate(4, cliente.getDataNascimentoSQL());
            stmt.setString(5, cliente.getTelefone());
            stmt.setString(6, cliente.getCpf());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao salvar cliente: " + e.getMessage());
        }
    }

    public void alterarCliente(Cliente cliente) {
        String sql = "UPDATE cliente SET nome = ?, email = ?, senha = ?, dataNascimento = ?, telefone = ?, cpf = ? WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getEmail());
            stmt.setString(3, cliente.getSenha());
            stmt.setDate(4, cliente.getDataNascimento());
            stmt.setString(5, cliente.getTelefone());
            stmt.setString(6, cliente.getCpf());
            stmt.setInt(7, cliente.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao alterar as informações do cliente: " + e.getMessage());
        }
    }

    public void excluirCliente(int id) {
        String sql = "DELETE FROM cliente WHERE id = ?";

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao excluir cliente: " + e.getMessage());
        }
    }

    public Cliente buscarClientePorId(int id) {
        String sql = "SELECT * FROM cliente WHERE id = ?";
        Cliente cliente = null;

        try (Connection conexao = DatabaseConnection.obterConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                cliente = new Cliente();
                cliente.setId(rs.getInt("id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setEmail(rs.getString("email"));
                cliente.setSenha(rs.getString("senha"));
                cliente.setDataNascimento(rs.getDate("dataNascimento"));
                cliente.setTelefone(rs.getString("telefone"));
                cliente.setCpf(rs.getString("cpf"));
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar cliente: " + e.getMessage());
        }

        return cliente;
    }
}
