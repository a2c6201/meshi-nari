require 'swagger_helper'

RSpec.describe 'api/v1/menus' do
  path '/api/v1/users/{user_id}/menus' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    let(:user) { create(:user) }
    let(:user_id) { user.id }
    let(:menus) { create_list(:menu, 10, user_id:) }

    before do
      menus
    end

    get('list menus') do
      consumes 'application/json'
      response(200, 'successful') do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            user_id: { type: :integer },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          },
          required: ['id', 'name', 'user_id', 'created_at', 'updated_at']
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    post('create menu') do
      consumes 'application/json'
      parameter name: :menu, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          user_id: { type: :integer }
        },
        required: %i(name user_id)
      }
      response(201, 'successful') do
        let(:menu) { { name: 'test_menu', user_id: user_id } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
