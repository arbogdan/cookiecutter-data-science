shinyServer(function(input, output, session) {

  #### Login Logic ####
  login_attempt <- reactiveValues(
    message = "Please enter your login credentials",
    status = FALSE)

  #login_attempt$status <- TRUE # -- Disables login for easier debugging

  # boolean login status shows or hides conditionalPanel with sensitive info
  output$logged_in <- reactive({
    return(login_attempt$status)
  })

  output$login_info <- reactive({
    return(login_attempt$message)
  })

  # continuous evaluation of logged_in
  outputOptions(output, "logged_in", suspendWhenHidden = FALSE)

  # when login button pressed, evaluate credentials, update status/message
  observeEvent(eventExpr = input$login,
    handlerExpr = {
      
      #Get user list here (getUsers() will grab users from Vertica)
      approved_users <-
        data.frame(
          username = c("test"),
          password = c(digest("test", algo = "md5"))
        )
      #approved_users <- getUsers()
      
      # validate(
      #   need(input$user, "Please enter your username"),
      #   need(input$pw, "Please enter your password"),
      #   need(approved_users, "Problem with the vertica connection")
      # )

      is_approved <-
        approved_users %>%
        filter(username == input$user,
          password == digest(input$pw, algo = "md5"))

      if (nrow(is_approved) > 0) {
        login_attempt$status <- TRUE
        output$userpanel <- renderUI({
          sidebarUserPanel(
            span("Logged in as ", input$user),
            actionLink("logout", label = "Logout"))
        })
      }else {
        login_attempt$status <- FALSE
        login_attempt$message <-
          paste("Invalid login credentials")
      }
    }
  )

  # when logout button pressed, log out user
  observeEvent(eventExpr = input$logout,
    handlerExpr = {
      login_attempt$status <- FALSE
      login_attempt$message <- paste("Logged out")
      output$userpanel <- renderUI({

      })
      updateTextInput(session, "user", value = "")
      updateTextInput(session, "pw", value = "")
    })
  
  callModule(tab1Server, "tab1")
  callModule(tab2Server, "tab2")

})
