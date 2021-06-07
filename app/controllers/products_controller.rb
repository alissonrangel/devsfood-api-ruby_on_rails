class ProductsController < AuthorizationController 
  
  def list
    @products = {
      error: "",
      result: []      
    }
    @data = Product.all.order(:id).map do |prod|
      {
        id: prod.id,
        id_cat: prod.category_id,
        image: prod.image,
        name: prod.name,
        ingredients: prod.ingredients,
        points: prod.points,
        price: prod.price        
      }
    end    
    @result = {page: 1, pages: 1, total:@data.length, data:@data}
    @products[:result] = @result

    render json: @products
  end

end