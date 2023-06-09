workspace {

    model {
        user = person "User" "A community manager."
        
        discord = softwareSystem "Discord API" "" "External"
        
        group "TogetherCrew" {
        
            softwareSystem = softwareSystem "TogetherCrew System" {
        
                uiComm = container "uiComm" "Typescript and Next.js"
                serverComm = container "serverComm" "Typescript and Express.js" {
                    group "Controllers" {
                        authController = component "Auth Controller"
                        guildController = component "Guild Controller"
                        heatmapController = component "Heatmap Controller"
                        memberActivityController = component "Member Activity Controller"
                        notionController = component "Notion Controller"
                        userController = component "User Controller"
                    }

                    group "Services" {
                        authService = component "Auth Service"
                        guildService = component "Guild Service"
                        heatmapService = component "Heatmap Service"
                        memberActivityService = component "Member Activity Service"
                        tokenService = component "Token Service"
                        userService = component "User Service"
                    }

                    # relationships between controllers and services
                    authController -> userService
                    authController -> authService
                    authController -> tokenService
                    authController -> guildService
                    guildController -> guildService
                    guildController -> userService
                    guildController -> authService
                    heatmapController -> guildService
                    heatmapController -> heatmapService
                    memberActivityController -> guildService
                    memberActivityController -> memberActivityService
                    userController -> tokenService
                    userController -> userService
                }
                botComm = container "botComm" "Javascript"
                daolytics = container "DAOlytics" "Python"
                
                rabbitmq = container "RabbitMQ" "Message broker"

                mongodb = container "MongoDB" "Account and analytics data" {
                    tags "Database"
                }
                neo4j = container "Neo4j" "Analytics data" {
                    tags "Database", "Target"
                }
            }
            
            # relationship between people and software systems
            user -> softwareSystem "View metrics, configure settings"
            softwareSystem -> discord "Makes API calls to" "JSON/HTTPS"
            
            # relationships to/from containers
            user -> uiComm "Visits app.togethercrew.com using" "HTTPS"
            uiComm -> serverComm "Makes API calls to" "JSON/HTTPS"
            serverComm -> mongodb "Reads from and writes to" "Wire Protocol/TCP"
            serverComm -> neo4j "Reads from" "Bolt Protocol/TCP" "Target"
            serverComm -> rabbitmq "Emits and listens to events using" "AMQP"
            botComm -> rabbitmq "Emits and listens to events using" "AMQP"
            botComm -> mongodb "Reads from and writes to" "Wire Protocol/TCP"
            botComm -> discord "Makes API calls to" "JSON/HTTPS"
            daolytics -> mongodb "Reads from and writes to" "Wire Protocol/TCP"
            daolytics -> rabbitmq "Emits and listens to events using" "AMQP"
            daolytics -> neo4j "Reads from and writes to" "Bolt Protocol/TCP"
            
        }
    }

    views {
    
        systemContext softwareSystem "SystemContext" {
            include *
            # autoLayout
        }

        container softwareSystem {
            include *
            # autoLayout
        }

        component serverComm {
            include *
            autoLayout
        }
        
        theme default
        
        styles {
         element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Customer" {
                background #08427b
            }
            element "Bank Staff" {
                background #999999
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Failover" {
                opacity 25
            }
            element "Target" {
                opacity 50
            }
        }
    }
    
}