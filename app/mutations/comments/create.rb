# ...
module Comments
  # ...
  class Create < Mutations::Command
    required do
      model  :user
      model  :photo
      string :body, min_length: 1
    end

    optional do
      integer :parent_user_id
    end

    def execute
      Comment.create(inputs)
    end
  end
end
