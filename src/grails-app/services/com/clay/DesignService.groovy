package com.clay

import org.joda.time.DateTime
import grails.util.GrailsConfig
import org.joda.time.Hours

class DesignService {

    def cacheService

    static transactional = true

    List<Design> getDesignList(String name){
        List<Design> designList = (List<Design>) cacheService.get(getCacheKey(name))
        return designList
    }

    String getCacheKey(String listName){
        return "designList" + listName
    }

    String getMostRecentDesignListName(){
        return cacheService.get("currentDesignList")
    }

    def saveMostRecentDesignListName(String name){
        cacheService.put("currentDesignList", name)
    }

    def saveDesignList(String name, List<Design> designs){
        cacheService.put(getCacheKey(name), designs)
    }

    def createDesignCache(){
        DateTime now = new DateTime()
        DateTime anHourAgo = new DateTime().minusHours(36);
        def votes = DesignVote.findAll("from DesignVote where dateCreated >= ?", [anHourAgo.toDate()])
        Map<Design,Double> designMap = [:]
        votes.each({
            Double total = designMap.get(it.design)
            if (!total){
                designMap.put(it.design, 0)
                total = 0
            }

            DateTime created = new DateTime(it.dateCreated)
            Hours hoursSinceCreated = Hours.hoursBetween(now, created);
            double voteWeight = Math.abs(1D / hoursSinceCreated.getHours());

            if (it.type.name.equals(GrailsConfig.clay.vote.down)){
                voteWeight = -1 * voteWeight;
            }

            designMap.put(it.design, total + voteWeight)
            it.design.images.url //prime object with data from hibernate.
        })

        def designs = designMap.keySet().sort({
            Design a, Design b ->
                designMap.get(a).compareTo(designMap.get(b))
        })

        String name = UUID.randomUUID()
        saveMostRecentDesignListName(name)
        saveDesignList(name, designs)
    }
}
