db.getCollection('links').aggregate([
    {$project:{_id:0, links:1}},
    {$unwind:"$links"},
    {$project:{
        from: "$links.from.ip",
        to: "$links.to.ip",
        delay: "$links.delay"
    }},
    {$group: {
        _id: {from: "$from", to: "$to"},
        delay: {$avg: "$delay"},
    }},
    {$project:{
        from: "$_id.from",
        to: "$_id.to",
        delay: "$delay"
    }},
//     {$limit: 5},
    {$out:"to_export"}
])