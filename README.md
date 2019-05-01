# sinatra-project
## Example at https://videogame-tracker.lfp2.gg
Sinatra Portfolio project and a CI/CD sandbox for experimenting with Jenkins, Docker and Kubernetes.

## Structures
### Models
 * User
   * Has a firstname, lastname, email, password.
   * has_secure_password using bcrypt
   * Has many user_games, a join table for users and games.
   * Has many games, through user_games. Used to track their library.
   * Has many created_games, through foreign_key on Game object.
   * .approved?
     * Not used but can be used in the future if I wish to lock out certain Users.
   * .cleaned
     * Returns a cleaned OpenStruct object with the basic User Attributes in case I wish to store them a user in session.
   * #null_user
     * A user with empty attributes for logged out guests. Also prevents nil related errors.
 * UserGame
   * Has a User.
   * Has a Game.
   * Only used to join a User with a Game for their library
 * Game
   * Has a name, genre, publisher and description.
   * Has many user_games, a join table for users and games.
   * Has many users through user_games.
   * Belongs to creator which is an alias for the User that created it.

### Controllers
 * MyApp < Sinatra::Base
   * Application controller which all others inherit authentication and settings from.
   * Configures views and public assets directory to be within app.
   * Enables session_secret and sessions.
   * .authenticate
     * Takes in a session, finds the user it belongs to then authenticates the session.
 * SessionsController < MyApp
   * get 'login'
     * Renders the login page.
   * post '/login'
     * Accepts a email and password and logs a User in by setting their session.
   * get '/logout'
     * Finds user through their session, authenticates them then logs them out by clearing session.
   * get '/register'
     * Renders the register form.
   * post '/register'
     * Creates a new user and sets their session with the new users info.
 * ApplicationController < MyApp
   * get '/'
     * Renders a welcome Page.
   * get '/games'
     * Renders a page with all games in the app.
     * Allows a user to create, edit, delete games and add games to their library.
   * get '/game/:id'
     * Renders information about a Game.
   * get '/game/:id/edit'
     * Renders a edit page.
     * Verifies if the user is an admin, moderator or creator before rendering.
   * post '/game/:id/edit'
     * Accepts updated game parameters.
     * Verifies if the user is an admin, moderator or creator for processing.
   * get '/game/:id/delete'
     * Deletes a game. 
     * Verifies if the user is an admin, moderator or creator for processing.
   * get '/games/new'
     * Renders a new game form.
   * post '/games/new'
     * Creates a new game.
   * get '/library'
     * Renders a User's library
   * get '/library/:id/add' do
     * Adds a game to the User's library
   * get '/library/:id/remove'
     * Removes a game from the User's library
   * get '/failure'
     * Renders a failure pages. 
     * Accepts a @error hash.
       * {'error_type' => ['error_1', 'error_2']}

## Hosting
### https://videogame-tracker.lfp2.gg
I have the app currently hosted on my Google Kubernetes Engine cluster. It has 3 replicas and grabs the image from docker hub at cooljacob204/videogame-tracker.

I have a deployment running Jenkins that waits for a push from Github whenever a new commit is made on the master branch. When it receives that commit it builds a new docker image, pushes it to the hub then deploys it to the cluster.

The deployment controller has a readiness probe running at '/'. GKE does a rolling update of the 3 pods. If it doesn't detect the updated running app after the default amount of time Kubernetes will cancels the deployment and roll back any pods that were updated.
