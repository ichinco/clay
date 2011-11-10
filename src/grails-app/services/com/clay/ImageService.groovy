package com.clay

class ImageService {

    static transactional = true

    def addImagePoint(ImagePoint point, int imageId) {
        Image image = Image.get(imageId)
        image.points.add(point)
        image.save()

        if (!image.validate()){
            // TODO record errors
        }
    }

    def createImagePoint(double x, double y, Product product){
        ImagePoint imagePoint = new ImagePoint()
        imagePoint.x = x
        imagePoint.y = y
        imagePoint.product = product
        imagePoint.save()

        if (!imagePoint.validate()){
            // TODO record errors
        }

        return imagePoint
    }

    def createProduct(String name, String url){
        Product product = new Product()
        product.name = name
        product.url = url
        product.save()

        if (!product.validate()){
            // TODO record errors
        }

        return product
    }
}
