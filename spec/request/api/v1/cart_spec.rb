RSpec.describe Api::V1::RestaurantsController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let!(:dish) { FactoryGirl.create(:dish) }

  describe 'POST /api/v1/restaurants' do
    it 'show cart items' do
      post '/api/v1/restaurants', params: {
        restaurants: { data: { dish: [dish.id, dish.id] } }
      }, headers: headers

      entry = Cart.last
      expect(entry.total_unique_items).to eq 2
      expected_response = {"carts" => [{"id" => enrty.id}] }
    end
  end
end
