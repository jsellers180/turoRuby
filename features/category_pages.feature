@smoketest @category_page @all

Feature: Checking links for category pages

Scenario: Verifying all the links to different categories
  Given I am on the all categories page
  Then links in page should have paths:
       |  LINK_NAME                  |  LINK_LOCATION  |  LINK_PATH                     |
	   |  A Mother's Love            |                 |  /movies/mothers-day           |
	   |  Award Winners         	 |                 |  /movies/academy-awards        |
	   |  Best of Britain            |                 |  /movies/best_of_britain       |
	   |  Case Files       			 |                 |  /movies/mysteries             |
	   |  Documentaries              |                 |  /movies/documentaries         |
	   |  Feeln a Lot Like Christmas |                 |  /movies/holiday       	    |
	   |  Feeln Originals			 |                 |  /short-films/feeln-originals  |
	   |  For the Family	    	 |                 |  /movies/kids                  |
	   |  Hallmark Hall of Fame      |                 |  /movies/hallmark-hall-of-fame |
	   |  Joy of Spring        		 |                 |  /movies/easter                |
	   |  Last Chance to Watch       |                 |  /movies/last-chance           |
	   |  Laughing Matters           |                 |  /movies/comedy                |
	   |  May Bouquet            	 |                 |  /movies/weddings              |
	   |  Most Popular               |                 |  /movies/most_popular          |
	   |  Movies A-Z                 |                 |  /movies/movies-az             |
	   |  Moving Pictures	         |                 |  /movies/teardrops-fall        |
	   |  New Movies                 |                 |  /movies/new-movies            |
	   |  Romantic Moments           |                 |  /movies/romance               |
	   |  Streaming Exclusive        |                 |  /movies/exclusive             |