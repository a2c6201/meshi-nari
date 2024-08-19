require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do


  path '/api/v1/users' do

    get('list users') do
      # spec/factories/posts.rbで定義したテストデータを10件複製(配列)
      before do
        host! 'localhost:3000'
        FactoryBot.create_list(:user, 10)
      end
      # リクエストヘッダがJSON形式であることを示す
      consumes 'application/json'
      response 200, 'list users' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            email: { type: :string },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          },
          required: ['id', 'name', 'email', 'created_at', 'updated_at']
        }
        run_test!

        it '全ユーザーが取得できるか' do
          json = JSON.parse(response.body)
          expect(json.size).to eq(10)
        end
      end
    end

    post('create user') do
      # リクエストボディがJSON形式であることを示す
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [:name, :email, :password]
      }

      response '201', 'user created' do
        let(:user) { { name: 'test_user', email: 'test@example.com', password: 'test_pass' } }
        run_test!
      end

      response '422', '無効なリクエスト' do
        let(:user) { { name: 'test_user', email: 'test@example.com' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    # get('show user') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

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

    # factory_botで作成したユーザーを削除する
    delete('delete user') do
      consumes 'application/json'
      before do
        @user = FactoryBot.create(:user)
      end
      response(200, 'successful') do
        let(:id) { @user.id }

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
