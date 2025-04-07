/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "produits")
public class Produit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String nom;
    private int quantite;
    private float prix;
    
    @ManyToOne
    private Categorie categorie;
    
    @OneToMany (mappedBy = "produit" , fetch = FetchType.EAGER)
    private List<MouvementStock>mouvementStocks;
            
    public Produit() {
    }

    public Produit(String nom, int quantite, float prix, Categorie categorie) {
        this.nom = nom;
        this.quantite = quantite;
        this.prix = prix;
        this.categorie = categorie;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public float getPrix() {
        return prix;
    }

    public void setPrix(float prix) {
        this.prix = prix;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    public List<MouvementStock> getMouvementStocks() {
        return mouvementStocks;
    }

    public void setMouvementStocks(List<MouvementStock> mouvementStocks) {
        this.mouvementStocks = mouvementStocks;
    }

    

    
    
}
