describe ApplicationHelper do
  describe '#category_tree_for_select' do
    def create_category(name, parent = nil)
      create(:category, name: name, parent: parent)
    end

    let!(:music) { create_category('music_category') }

    let!(:rock) { create_category('rock_category', music) }
    let!(:punk) { create_category('punk_category', rock) }
    let!(:heavy_metal) { create_category('heavy_metal_category', rock) }

    let!(:pop) { create_category('pop_category', music) }
    let!(:french_pop) { create_category('french_pop_category', pop) }

    let!(:books) { create_category('books_category') }

    let!(:non_fiction) { create_category('non_fiction_category', books) }
    let!(:science) { create_category('science_category', non_fiction) }
    let!(:memoir) { create_category('memoir_category', non_fiction) }

    let!(:fantastic) { create_category('fantastic_category', books) }
    let!(:fantasy) { create_category('fantasy_category', fantastic) }
    let!(:cyberpunk) { create_category('cyberpunk_category', fantastic) }

    it 'returns two-dimensional array of categories sorted by name and depth' do
      desirable_tree = [
        [books.name, books.id, { depth: books.depth }],
        [fantastic.name, fantastic.id, { depth: fantastic.depth }],
        [cyberpunk.name, cyberpunk.id, { depth: cyberpunk.depth }],
        [fantasy.name, fantasy.id, { depth: fantasy.depth }],
        [non_fiction.name, non_fiction.id, { depth: non_fiction.depth }],
        [memoir.name, memoir.id, { depth: memoir.depth }],
        [science.name, science.id, { depth: science.depth }],
        [music.name, music.id, { depth: music.depth }],
        [pop.name, pop.id, { depth: pop.depth }],
        [french_pop.name, french_pop.id, { depth: french_pop.depth }],
        [rock.name, rock.id, { depth: rock.depth }],
        [heavy_metal.name, heavy_metal.id, { depth: heavy_metal.depth }],
        [punk.name, punk.id, { depth: punk.depth }]
      ]
      expect(category_tree_for_select).to eq(desirable_tree)
    end
  end
end
