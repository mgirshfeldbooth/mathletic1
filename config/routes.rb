Rails.application.routes.draw do

  get("/", { :controller => "rounds", :action => "index" })

  get("/play", { :controller => "rounds", :action => "create" })

  get("/round_complete", { :controller => "rounds", :action => "complete" })

  get("/stats", { :controller => "rounds", :action => "stats" })

  # Routes for the Round resource:

  # CREATE
  post("/insert_round", { :controller => "rounds", :action => "create" })
          
  # READ
  get("/rounds", { :controller => "rounds", :action => "index" })
  
  get("/rounds/:path_id", { :controller => "rounds", :action => "show" })
  
  # UPDATE
  
  post("/modify_round/:path_id", { :controller => "rounds", :action => "update" })
  
  # DELETE
  get("/delete_round/:path_id", { :controller => "rounds", :action => "destroy" })

  #------------------------------

  # Routes for the Attempt resource:

  # CREATE
  post("/insert_attempt", { :controller => "attempts", :action => "create" })
          
  # READ
  get("/attempts", { :controller => "attempts", :action => "index" })
  
  get("/attempts/:path_id", { :controller => "attempts", :action => "show" })
  
  # UPDATE
  
  post("/modify_attempt/:path_id", { :controller => "attempts", :action => "update" })
  
  # DELETE
  get("/delete_attempt/:path_id", { :controller => "attempts", :action => "destroy" })

  #------------------------------

  # Routes for the Exercise resource:

  # CREATE
  post("/insert_exercise", { :controller => "exercises", :action => "create" })
          
  # READ
  get("/exercises", { :controller => "exercises", :action => "index" })
  
  get("/exercises/:path_id", { :controller => "exercises", :action => "show" })
  
  # UPDATE
  
  post("/modify_exercise/:path_id", { :controller => "exercises", :action => "update" })
  
  # DELETE
  get("/delete_exercise/:path_id", { :controller => "exercises", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
