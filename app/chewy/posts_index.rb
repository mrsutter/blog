class PostsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      title: {
        tokenizer: 'standard',
        filter: %w(lowercase asciifolding)
      }
    }
  }

  define_type Post do
    field :name
    field :body
    field :category_id, type: 'integer'
    field :tags, index: 'not_analyzed', value: -> { tags.map(&:name) }
    field :created_at, type: 'date'
  end
end
