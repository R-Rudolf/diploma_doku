map = function(item){
    last_asn = item.from.asn
    
    for(i=0;i<item.links.length;i++){
        item.links[i].from.asn = last_asn;
        last_asn = item.links[i].to.asn
    }
    
    db.links2.insert(item);
}
db.links1.find().forEach(map);