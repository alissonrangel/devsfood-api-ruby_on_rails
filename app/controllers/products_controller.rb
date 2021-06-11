class ProductsController < AuthorizationController 
  
  def list
    @products = {
      error: "",
      result: []      
    }
    # @products = Product.all.with_attached_featured_image

    @data = Product.all.with_attached_featured_image.order(:id).map do |prod|
      if prod.image != "null"
      {
        id: prod.id,
        id_cat: prod.category_id,
        image: prod.image,
        name: prod.name,
        ingredients: prod.ingredients,
        points: prod.points,
        price: prod.price,
        featured_image: nil
      }
      else
      {
        id: prod.id,
        id_cat: prod.category_id,
        image: prod.image,
        name: prod.name,
        ingredients: prod.ingredients,
        points: prod.points,
        price: prod.price,
        featured_image: url_for(prod.featured_image)
      }
      end
    end  
    puts "DATA 4"  
    puts @data[4]
    @result = {page: 1, pages: 1, total:@data.length, data:@data}
    @products[:result] = @result

    render json: @products
  end

  # def list2
  #   @products = Product.all.with_attached_featured_image

  #   @products.map do |prod|
  #     { 
  #       id: prod.id,
  #       id_cat: prod.category_id,
  #       image: url_for(prod.featured_image), 
  #       name: prod.name,
  #       ingredients: prod.ingredients,
  #       points: prod.points,
  #       price: prod.price,
  #       url: "dadad"
  #     }
  #   end
  #   render json: @products
  #   #render json: @products.to_json(include: { featured_image_attachment: { include: :blob } })
    
  # end

  def index
    puts "AQUIFADADD"
    puts params[:search]
    @products = {
      error: "",
      result: []      
    }
    if params[:search] != nil 
      puts params[:search]
      substring = params[:search]
      substring = substring.downcase
      @data = Product.where(["lower(name) like ?","%#{substring}%"])
    end
      
    if params[:category] != nil 
      #puts params[:search]
      category = params[:category]      
      @data = Product.where(["category_id = ?","#{category}"])
    end
    
    if @data == nil
      @data = Product.all
    end
    
    @result = {page: 1, pages: 1, total:@data.length, data:@data}
    @products[:result] = @result
    
    render json: @products
  end

  def create
      @product = Product.create(post_params)
    if @product.persisted?
      render json: {                
        id: @product.id
      }
    else
      render json: { error: 'Não foi possível criar o produto' }
    end
  end
  private
  def post_params    
      params.permit(:name, :image, :featured_image, :ingredients, :category_id, :price, :points)
  end

end