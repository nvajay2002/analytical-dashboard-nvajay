# Dashboard UI
ui <- dashboardPage(
  
  dashboardHeader(
    title = "N V AJAY Statewise Road Accidents and Persons Killed/Injured",
    titleWidth = 650, 
    tags$li(class = "dropdown", tags$a(href = "https://www.linkedin.com/in/n-v-ajay-9791791aa/", icon("linkedin"), "My Profile", target = "_blank")),
    tags$li(class = "dropdown", tags$a(href = "https://github.com/nvajay2002/analytical-dashboard-nvajay", icon("github"), "Source code and Report", target = "_blank"))
  ),
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Dataset", tabName = "data", icon = icon("database")),
      menuItem(text = "Visualization", tabName = "viz", icon = icon("chart-line")),
      menuItem(text = "Analysis", tabName = "anova", icon = icon("chart-line")),
      selectInput(inputId = "var1", label = "Select the Type", choices = choices1, selected = "Fatal Accidents - 2018")
    )
  ),
  
  dashboardBody(
    tabItems(
      #First tab item
      tabItem(tabName = "data",
              #tab box
              tabBox(id = "t1", width = 12,
                     tabPanel("About",
                              fluidRow(
                                column(width = 8,
                                       tags$br() , 
                                       tags$a("Name : N V AJAY\n Roll Number: 22A\n This comprehensive dashboard provides a detailed overview of the States/UTs-wise occurrences of Road Traffic Incidents from 2018 to 2021, with a specific focus on Fatal Road Accidents, Total Road Accidents, Persons Killed, and Persons Injured on Other Roads.The data is categorized into distinct metrics, including (FA) Fatal Accidents, (A) Total Accidents, (K) Persons Killed, and (I) Persons Injured. This visualization aims to facilitate a comprehensive understanding of the road safety landscape, aiding in the identification of trends and areas for potential interventions.")),
                                column(width = 4, tags$br() ,
                                       tags$p("The abbreviations used are (FA) for Fatal Accidents, (A) for Total Accidents, (K) for Persons Killed, and (I) for Persons Injured.")
                                )
                              )  
                              
                     ),
                     tabPanel("Data",dataTableOutput("dataT")),
                     tabPanel("Structure",verbatimTextOutput("structure")),
                     tabPanel("Summary",verbatimTextOutput("summary")))),
      tabItem(tabName = "viz",
              #tab box
              tabBox(id = "t1", width = 12,
                     tabPanel("Road Accidents and Trends by States",value = "trends", plotlyOutput("bar")),
                     tabPanel("Distribution", value = "distro",plotlyOutput("histplot")))),
      tabItem(tabName = "anova",
              tabBox(id = "t1", width = 12,
                     tabPanel("About",
                              fluidRow(
                                column(width = 8,
                                       tags$br() , 
                                       tags$a("This part of Dashboard compares different segments (FA,A,K,I) per state over years using test of Anova")),
                                column(width = 4, tags$br())
                     
                     )),
                     tabPanel("FA", verbatimTextOutput("FA")),
                     tabPanel("A", verbatimTextOutput("A")),
                     tabPanel("K", verbatimTextOutput("K")),
                     tabPanel("I", verbatimTextOutput("I"))
    )
    
  )
)))
