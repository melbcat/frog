require 'launchy'
require_relative 'constants.rb'

class FuzzySearcher
  def self.search (links, search_term)

    # Grep the links array to fuzzily match our search term
    filtered_links = links.grep(/#{search_term}/io)

    # Abort if we don't find anything
    abort "Sorry. It looks like we couldn't what you were looking for" if filtered_links.empty?

    # Create link and index hashes
    # links_hash will map each class name to it's relative URL
    # index_hash will match each selection index (that we show the user) to the class name
    links_hash, index_hash = create_link_and_index_hashes(filtered_links)

    # Show all the selection options to the user
    show_selection_options(links_hash)

    # Get the user selected index and verify if it's alright
    index = get_verified_user_input(index_hash.size)

    # Get the relative URL of the required class
    relative_url = links_hash[index_hash[index]]

    # Append to base URL to form complete URL
    target_link = "#{Constants::BASE_URL}/#{relative_url}"

    # Launch browser
    Launchy.open(target_link)

  end

  def self.create_link_and_index_hashes(filtered_links)
    # Create 2 hashes
    links_hash = Hash.new
    index_hash = Hash.new

    filtered_links.each_with_index do |link, i|
      # Get class name
      class_name = link.partition("label:\"").last.partition("\"").first

      # Get relative URL
      class_url = link.partition("link:\"").last.partition("\"").first

      # Map class name to relative URL
      links_hash[class_name] = class_url

      # Map index to class name
      index_hash[i] = class_name
    end

    return links_hash, index_hash
  end

  def self.show_selection_options(links_hash)
    puts "Enter the index of the class you want. ex: Enter 1 if you wish to select the first option."
    links_hash.keys.each_with_index do |class_name, i|
      puts "#{i+1}: #{class_name}"
    end
  end

  def self.get_verified_user_input(selection_options_size)
    begin
      index = STDIN.gets.chomp.to_i - 1

      if index < 0 || index >= selection_options_size
        raise "Index out of bounds"
      end

      return index
    rescue
      abort "Sorry. It looks like you didn't enter the correct index"
    end
  end

end
