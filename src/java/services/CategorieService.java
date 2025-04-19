/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.CategorieDao;
import entities.Categorie;
import java.util.List;

/**
 *
 * @author AMINE
 */
public class CategorieService implements IService<Categorie>{
    
    private final CategorieDao cd;

    public CategorieService() {
        this.cd = new CategorieDao();
    }
    
    
    @Override
    public boolean create(Categorie o) {
        return cd.create(o);
    }

    @Override
    public boolean update(Categorie o) {
       return cd.update(o);
    }

    @Override
    public boolean delete(Categorie o) {
       return cd.delete(o);
    }

    @Override
    public List<Categorie> findAll() {
        return cd.findAll();
    }

    @Override
    public Categorie findById(int id) {
       return cd.findById(id);
    }
    
}
