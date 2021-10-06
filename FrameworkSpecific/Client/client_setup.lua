-- Map a Role Play framework to wrapper functions to the platform specific counterparts

frameworkFunctionMappings = {
    esx = {
        runStartupStuff = RunStartupStuffEsx,
        showNotification = ShowNotificationEsx,
        currentJob = CurrentJobEsx
    },
    custom = {
        runStartupStuff = RunStartupStuffCustom,
        showNotification = ShowNotificationCustom,
        currentJob = CurrentJobCustom
    }
}


