class PostSearchType
  include ActiveData::Model

  attribute :query, type: String
  attribute :category_id, type: Integer
  attribute :tags
  attribute :sort_order, default: 'desc'

  def index
    PostsIndex
  end

  def search
    [
      query_string,
      category_id_filter,
      tags_filter,
      sort
    ].compact.reduce(:merge)
  end

  def query_string
    query_string = {
      fields: [:name, :body],
      query: query,
      default_operator: 'and'
    }
    if query?
      index.query(query_string: query_string).highlight(highlight_params)
    else
      index.query(match_all: {})
    end
  end

  def category_id_filter
    index.filter(term: { category_id: category_id }) if category_id?
  end

  def tags_filter
    return if !tags? || tags.empty? || tags == ['']
    index.filter(terms: { tags: tags })
  end

  def sort
    index.order(created_at: sort_order)
  end

  private

  def highlight_params
    @higlight_params ||= {
      pre_tags: ['<span>'],
      post_tags: ['</span>'],
      fields: {
        name: fragment_params,
        body: fragment_params
      }
    }
  end

  def fragment_params
    @fragment_params ||= {
      fragment_size: search_settings.fragment_size,
      number_of_fragments: search_settings.number_of_fragments
    }
  end

  def search_settings
    @settings ||= Settings.search.default
  end
end
