module UserService
  module Base 
    def self.create_user(params)
      user = User.new(params)

      begin
        # are there any db/model errors?
        user.save!
      rescue ActiveRecord::RecordInvalid => exception
        # return an error instance
        return ServiceContract.error(user.errors.full_messages) unless user.valid?
      end

      ServiceContract.success(user)
    end
  end
end