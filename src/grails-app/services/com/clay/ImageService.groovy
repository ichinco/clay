package com.clay

class ImageService {

    static transactional = true

    def addImagePoint(ImagePoint point, int imageId) {
        Image image = Image.get(imageId)
        image.points.add(point)
        image.save()

        if (!image.validate()){
            throw new RuntimeException(image.errors.toString())
        }
    }

    def createImagePoint(double x, double y, double width, double height, Product product, User user, Image image){
        ImagePoint imagePoint = new ImagePoint()
        imagePoint.left = x
        imagePoint.top = y
        imagePoint.width = width
        imagePoint.height = height
        imagePoint.product = product
        imagePoint.image = image;
        imagePoint.save()

        if (!imagePoint.validate()){
            throw new RuntimeException(imagePoint.errors.toString())
        }

        return imagePoint
    }

    def createProduct(String name, String url){
        Product product = new Product()
        product.name = name
        product.url = url
        product.save()

        if (!product.validate()){
            throw new RuntimeException(product.errors.toString())
        }

        return product
    }
}
