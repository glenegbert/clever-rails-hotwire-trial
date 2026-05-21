require "csv"

CSV.foreach(Rails.root.join("db/photos.csv"), headers: true) do |row|
  Photo.find_or_create_by!(source_url: row["url"]) do |p|
    p.photographer = row["photographer"]
    p.src_medium   = row["src.medium"]
  end
end

[
  { email: "alice@example.com", password: "password" },
  { email: "bob@example.com",   password: "letmein" }
].each do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |u|
    u.password = attrs[:password]
  end
end
