def require_seed(name)
  require Rails.root.join("db/seeds/#{name}")
end

require_seed 'categories'
