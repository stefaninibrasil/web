Quando("eu visito o site {string}") do |link|
    visit link
    #binding.pry -- For Debug --> use 'exit' command to finish it
end

Então("devo ver o título {string} na página") do |title|
    expect(page.title).to eql title
end