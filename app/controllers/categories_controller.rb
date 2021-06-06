class CategoriesController < AuthorizationController 
  
  def list
    @categories = {
      error: "",
      result: []      
    }
    @result = Category.all.order(:id).map do |cat|
      {
        id: cat.id,
        image: cat.image,
        name: cat.title,        
      }
    end    
    
    @categories[:result] = @result

    render json: @categories
  end

end