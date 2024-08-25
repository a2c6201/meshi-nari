# このファイルは、'rails generate rspec:install'を実行するとspec/にコピーされます
# RSpecの設定を変更するためのファイル
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
# 訳注: この行は、ActiveRecordまたはActiveRecordフィクスチャを使用していない場合は削除してください
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # すべてのリクエストスペックでlocalhostを使用する
  config.before(:each, type: :request) do
    host! 'localhost:3000'
  end

  # テストの終わりにDBをロールバックする
  config.use_transactional_fixtures = true

  # 訳注: この行は、ActiveRecordまたはActiveRecordフィクスチャを使用していない場合は削除してください
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
