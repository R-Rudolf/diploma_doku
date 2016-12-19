db.getCollection('links').aggregate([
    {$project:{_id:0, links:1}},
    {$unwind:"$links"},
    {$project:{
        from: {ip: "$links.from.ip", asn: "$links.from.asn"},
        to: {ip: "$links.to.ip", asn: "$links.to.asn"}
    }},
    {$group: {
        _id: null,
        nodes_from: { $addToSet: "$from" },
        nodes_to: { $addToSet: "$to" },
    }},
    {$project: {
        nodes:{$setUnion:["$nodes_to", "$nodes_from"]}
    }},
    {$unwind:"$nodes"},
    {$group:{
        _id: "$nodes.ip",
        ip: {$first: "$nodes.ip"},
        asn: {$first: "$nodes.asn"},
    }},
//     {$project:{
//         _id: ,
//         ip: "$nodes.ip",
//         asn: "$nodes.asn",
//     }},
//     {$limit: 5},
    {$out:"to_export"}
])