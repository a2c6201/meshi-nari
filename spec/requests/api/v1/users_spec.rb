require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  # spec/factories/posts.rbで定義したテストデータを10件複製(配列)
  before do
    host! 'localhost:3000'
    FactoryBot.create_list(:user, 10)
  end

  path '/api/v1/users' do
    get('list users') do
      response 200, 'list users' do
        schema type: :array, items: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            password: { type: :string }
          },
          required: [:name, :email, :password]
        }

        run_test!

        it 'レスポンスのデータ数を確認' do
          json = JSON.parse(response.body)
          expect(json.size).to eq(10)
        end
      end
    end

    # post('create user') do
    #   response(200, 'successful') do

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end

  # path '/api/v1/users/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('show user') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   delete('delete user') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
end
