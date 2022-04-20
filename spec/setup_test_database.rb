require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'bookmark_manager_test')

  connection.exec("TRUNCATE bookmarks RESTART IDENTITY CASCADE;")
end
