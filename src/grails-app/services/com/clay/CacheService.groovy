package com.clay

class CacheService {

    static transactional = true

    private static Map<String,Object> cache;

    def put(String key, Object value) {
        cache.put(key, value)
    }

    def get(String key){
        return cache.get(key)
    }

    CacheService(){
        cache = new HashMap<String,Object>();
    }
}
