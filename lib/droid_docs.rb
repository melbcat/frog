require 'starter'

module DroidDocs

  def self.start
    # Initialize dependencies and start the program
    exiter = Exiter.new
    exact_searcher = ExactSearcher.new(exiter)
    fuzzy_searcher = FuzzySearcher.new(exiter)

    Starter.new(exiter,
                OptionsHelper.new(exiter),
                SearchTermHelper.new(exiter),
                LinksGetter.new,
                exact_searcher,
                fuzzy_searcher,
                SearchRouter.new(exact_searcher, fuzzy_searcher),
                BrowserLauncher.new).start
  end
end
