module BlogService
  module Base
    def self.filter(params)
      # fetch means that if the key is not found, it will return the default value
      page = params.fetch(:page, 1).to_i
      per_page = params.fetch(:per_page, 10).to_i

      begin
        # Calculate the offset based on the current page
        offset = (page - 1) * per_page

        # Fetch the subset of blogs based on pagination parameters
        blogs = Blog.offset(offset).limit(per_page)
      rescue ActiveRecord::RecordInvalid => exception
        return ServiceContract.error(exception.record.errors.full_messages) unless exception.record.valid?
      end
      
      ServiceContract.success(blogs)  
    end
  end
end
