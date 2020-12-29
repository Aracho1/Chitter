configure :development, :production do
  DataMapper.setup(:default, 'postgres://localhost/chitter')
end

configure :test do
  DataMapper.setup(:default, 'postgres://localhost/chitter_test')
end