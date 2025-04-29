/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import dao.MouvementStockDao;
import entities.MouvementStock;
import java.util.List;

/**
 *
 * @author AMINE
 */
public class MouvementStockService implements IService<MouvementStock>{
     private final MouvementStockDao msd;
     
     public MouvementStockService (){
        this.msd= new MouvementStockDao();
    }
    @Override
    public boolean create(MouvementStock o) {
       return msd.create(o);
    }

    @Override
    public boolean update(MouvementStock o) {
        return msd.update(o);
    }

    @Override
    public boolean delete(MouvementStock o) {
        return msd.delete(o);
    }

    @Override
    public List<MouvementStock> findAll() {
        return msd.findAll();
    }

    @Override
    public MouvementStock findById(int id) {
        return msd.findById(id);
    }
    
}
