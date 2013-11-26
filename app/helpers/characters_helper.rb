module CharactersHelper

  # Returns the Image for the given character. (under construction)
  def image_for(character, options = { size: 100 })
    image_id = character.code.to_i.to_s(16).upcase()
    image_prefix = ((character.code.to_i + 999) / 1000).to_s(16)
    size = options[:size]
    image_url = "58/#{image_prefix}/#{image_id}.gif"
    image_tag(image_url, alt: character.unichr, class: "gravatar")
  end
end
