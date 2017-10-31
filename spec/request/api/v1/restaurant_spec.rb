require 'rails_helper'

RSpec.describe 'Restaurant', type: :request do
  let(:headers) {{HTTP_ACCEPT: 'application/json'}}

  describe 'Get api/v1/restaurants' do
    let(:restaurant_category) {FactoryGirl.create(:restaurant_category, name: 'Thai food', description: 'Thai food', id: 1)}
    let!(:restaurant) {FactoryGirl.create(:restaurant, name: 'My Thai', address: 'street 1', description: 'boring food', latitude: 33.7353997, longitude: 73.0781967, id: 1, restaurant_category_id: restaurant_category.id)}

    it 'returns collection of restaurants' do

      get '/api/v1/restaurants'

      expected_response = {"restaurants" =>
                               [{"id" => 1,
                                 "name" => "My Thai",
                                 "address" => "street 1",
                                 "description" => "boring food",
                                 "latitude" => 33.7353997,
                                 "longitude" => 73.0781967,
                                 "category_name" => "Thai food",
                                 "category_description" => "Thai food"}]}


      expect(response.status).to eq 200
      expect(response_json).to eq expected_response
    end
  end
end