/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mapper;

/**
 *
 * @author AMINE
 */
public class CategorieCount {
    private String categorie;
    private Long nbProduits;
    
    // Constructeurs, getters et setters
    public CategorieCount(String categorie, Long nbProduits) {
        this.categorie = categorie;
        this.nbProduits = nbProduits;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public Long getNbProduits() {
        return nbProduits;
    }

    public void setNbProduits(Long nbProduits) {
        this.nbProduits = nbProduits;
    }
}

    
    

