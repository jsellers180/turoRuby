module NavigationHelpers

  # Path mapping
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the sign up page/
      '/signup/startnow'

    when /the login page/
      '/login'

    when /Log Out/
      '/logout'
    
    when /the forgot password page/
      '/login/forgot'

    when /the direct sign up page with params/
      '/signup/direct/?azra1=test1&azra2=test2'
      
    when / the intdj2 sign up page with params/
      '/signup/intdj2/?azra1=test1&azra2=test2'
      
    when /the sign up page with params/
      '/signup/startnow/?azra1=test1&azra2=test2'
      
    when /the all categories page/
      '/all-categories'

    when /the all movies page/
      '/movies/all-movies'

    when /the hallmark hall of fame page/
      '/movies/hallmark-hall-of-fame'

    when /the series page/
      '/tv/series'

    when /the feeln originals page/
      '/short-films/feeln-originals'

    when /the user json/
      '/v1/user.json?source=1mainstream'

    when /the supported devices page/
      '/supported-devices'

    when /the prices and membership page/
      '/prices-membership'

    when /the most popular page/
      '/movies/most_popular'

    when /the new movies page/
      '/movies/new-movies'

    when /the kids movies page/
      '/movies/kids'

    when /the search page/
      '/search'

      # behind the login wall
    when /the account page/
      '/account'

    when /the activate devices page/
      '/activate'

    when /the watchlist page/
      '/account/watchlist'

    when /the history page/
      '/account/history'

        # Path mapping to Terms and Conditions page
    when /the terms and conditions page/
      '/termsandconditions'

   # Path mapping to Privacy Policy page
    when /the privacy policy page/
      '/privacypolicy'

   # Path mapping to Film pages
    when /the away and back film page/
      '/films/away_and_back'

    when /the ethan frome film page/
      '/films/ethan_frome'

    when /the hitch film page/
      '/films/hitch'

    when /the be there film page/
      'films/be_there'

    when /the on golden pond film page/
      'films/on-golden-pond'

    when /the locket film page/
      'films/the-locket'

    when /the rose hill film page/
      'films/rose-hill'
    # End mapping to Film pages

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
