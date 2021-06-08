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
        price: prod.price,
        featured_image: prod.featured_image        
      }
    end  
    puts "DATA 4"  
    puts @data[4]
    @result = {page: 1, pages: 1, total:@data.length, data:@data}
    @products[:result] = @result

    render json: @products
  end

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
    else
      @data = Product.all
    end
    if params[:category] != nil 
      #puts params[:search]
      category = params[:category]      
      @data = Product.where(["category_id = ?","#{category}"])
    else
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