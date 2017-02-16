db.getCollection('links').aggregate([
    {$project:{_id:0, links:1}},
//     {$unwind:"$links"},
    {$project:{
        length: {$size: "$links"}
//         delay: "$links.delay",
//         jitter: "$links.jitter",
//         rtt: "$links.rtt"
    }},
    {$match: {length:{$ne: 0}}},
//     {$limit: 5},
    {$out:"to_export"}
])