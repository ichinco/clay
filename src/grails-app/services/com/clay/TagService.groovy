package com.clay

class TagService {

    static transactional = true
    static scope = "singleton"

    def synchronized getTag(int id, String name) {
        TagType type = TagType.get(id)
        Tag tag = Tag.findByName(name)
        if (!tag){
            tag = new Tag()
            tag.type = type
            tag.name = name
            tag.save()

            if (!tag.validate()){
                return null;
            }
        }

        return tag;
    }

    def tagDesign(Tag tag, Design design){
        if (!design.tags.contains(tag) && tag){
            design.tags.add(tag)
            design.save()

            if (!design.validate()){
                // TODO error
            }
        }
    }

    def findByTag(Tag tag){
        return tag.designs
    }
}
