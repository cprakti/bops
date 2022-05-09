puts "Seeding..."

puts "Radiohead"

artist1 = Artist.find_or_create_by!(name: "Radiohead")
album1 = Album.find_or_create_by!(title: "OK Computer", artist: artist1, release_year: 1997)
Record.find_or_create_by!(condition: 10, notes: "Mint", album: album1)
Record.find_or_create_by!(condition: 9, notes: "Corners of case are a bit bent", album: album1)

album2 = Album.find_or_create_by!(title: "Kid A", artist: artist1, release_year: 2000)
Record.find_or_create_by!(condition: 6, notes: "Scratched but plays", album: album2)
Record.find_or_create_by!(condition: 1, notes: "Doesn't play", album: album2)

puts "Queens of the Stone Age"

artist2 = Artist.find_or_create_by!(name: "Queens of the Stone Age")
album3 = Album.find_or_create_by!(title: "Queens of the Stone Age", artist: artist2, release_year: 1998)
Record.find_or_create_by!(condition: 4, notes: "Only the first half of the songs can be played", album: album3)
Record.find_or_create_by!(condition: 2, notes: "Only first song works", album: album3)

album4 = Album.find_or_create_by!(title: "Rated R", artist: artist2, release_year: 2000)
Record.find_or_create_by!(condition: 8, notes: "Cosmetic scratches but works well", album: album4)
Record.find_or_create_by!(condition: 5, notes: "Case is missing and first song won't play", album: album4)

puts "Seeding Complete"
