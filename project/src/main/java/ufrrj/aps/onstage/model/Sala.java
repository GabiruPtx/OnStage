package ufrrj.aps.onstage.model;

import java.util.List;

public class Sala {
    
private int id;
private Local local;
private String numero;
private List<Assento> assentos;

public Sala() {

}

public int getId() {
    return id;
}

public void setId(int id) {
    this.id = id;
}

public Local getLocal() {
    return local;
}

public void setLocal(Local local) {
    this.local = local;
}

public String getNumero() {
    return numero;
}

public void setNumero(String numero) {
    this.numero = numero;
}

public List<Assento> getAssentos() {
    return assentos;
}

public void setAssentos(List<Assento> assentos) {
    this.assentos = assentos;
}

}
