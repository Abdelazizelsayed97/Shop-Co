const String getProductsQuery = r'''
query products{
  products{
    id
    title
    price
    description
    category{
      id
      name
      image
    
    }
    images
    creationAt
    updatedAt
  }

}
''';