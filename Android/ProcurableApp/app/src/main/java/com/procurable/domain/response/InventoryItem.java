
package com.procurable.domain.response;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class InventoryItem  implements Serializable {

    private String Name;
    private List<Item> Item = new ArrayList<Item>();
    private Integer Count;

    /**
     * 
     * @return
     *     The Name
     */
    public String getName() {
        return Name;
    }

    /**
     * 
     * @param Name
     *     The Name
     */
    public void setName(String Name) {
        this.Name = Name;
    }

    /**
     * 
     * @return
     *     The Item
     */
    public List<Item> getItem() {
        return Item;
    }

    /**
     * 
     * @param Item
     *     The Item
     */
    public void setItem(List<Item> Item) {
        this.Item = Item;
    }

    /**
     * 
     * @return
     *     The Count
     */
    public Integer getCount() {
        return Count;
    }

    /**
     * 
     * @param Count
     *     The Count
     */
    public void setCount(Integer Count) {
        this.Count = Count;
    }

}
