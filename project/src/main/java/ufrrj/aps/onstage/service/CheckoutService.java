package aps.onstage.service;

import aps.onstage.dao.CheckoutDAO;
import aps.onstage.entity.Checkout;
import aps.onstage.entity.Ingresso;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;

@ApplicationScoped
public class CheckoutService {
    @Inject
    private CheckoutDAO checkoutDAO;

    // Método para realizar o checkout de uma compra
    public void realizarCompra(Checkout checkout, List<Ingresso> ingressos) {
        // Associa os ingressos ao checkout
        checkout.setIngressos(ingressos);

        // Calcula o total pago com base nos ingressos
        double totalPago = calcularTotalPago(ingressos);
        checkout.setTotalPago(totalPago);

        // Define a data de compra (pode ser ajustado conforme necessário)
        checkout.setDataCompra("2024-12-09"); // Exemplo de data fixa

        // Salva o checkout e os ingressos no banco de dados
        checkoutDAO.salvar(checkout);
    }

    // Método para calcular o total pago com base nos ingressos
    private double calcularTotalPago(List<Ingresso> ingressos) {
        double total = 0;
        for (Ingresso ingresso : ingressos) {
            total += ingresso.getPreco() * ingresso.getQuantidade();
        }
        return total;
    }
}
