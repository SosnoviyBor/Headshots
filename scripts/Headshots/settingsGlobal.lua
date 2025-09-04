local I = require('openmw.interfaces')

I.Settings.registerGroup {
    key = 'SettingsHeadshots_toggles',
    page = 'Headshots',
    l10n = 'Headshots',
    name = 'toggles_group_name',
    order = 0,
    permanentStorage = true,
    settings = {
        -- {
        --     key = 'modEnabled',
        --     name = 'modEnabled_name',
        --     renderer = 'checkbox',
        --     default = true,
        -- },
    }
}

I.Settings.registerGroup {
    key = 'SettingsHeadshots_values',
    page = 'Headshots',
    l10n = 'Headshots',
    name = 'values_group_name',
    description = "values_group_description",
    order = 1,
    permanentStorage = true,
    settings = {
        {
            key = 'headHeight',
            name = 'headHeight_name',
            description = 'headHeight_description',
            renderer = 'number',
            integer = false,
            default = 0.85,
            min = 0,
            max = 1
        },
        {
            key = 'mode',
            name = 'mode_name',
            description = 'mode_description',
            renderer = 'select',
            argument = {
                l10n = "Headshots",
                items = {
                    "Linear",
                    "Threshold",
                    "No helmet instakill",
                    "Instakill"
                },
            },
            default = "Linear"
        },
        {
            key = 'flatMult',
            name = 'flatMult_name',
            description = 'flatMult_description',
            renderer = 'number',
            integer = false,
            default = 1.5,
        },
        {
            key = 'marksmanMult',
            name = 'marksmanMult_name',
            description = 'marksmanMult_description',
            renderer = 'number',
            integer = false,
            default = 0.05,
        },
        {
            key = 'thresholdStep',
            name = 'thresholdStep_name',
            renderer = 'number',
            integer = true,
            default = 25,
            min = 1
        },
        -- Caius' house interior, for reference, is around 7m*7m in size
        -- Snowy Granius' bridge is about 50 meters long
        {
            key = 'distanceMin',
            name = 'distanceMin_name',
            description = 'distanceMin_description',
            renderer = 'number',
            integer = true,
            default = 20,
            min = 0
        },
        {
            key = 'damagePerMeter',
            name = 'damagePerMeter_name',
            description = 'damagePerMeter_description',
            renderer = 'number',
            integer = false,
            default = .025,
            min = 0
        },
    }
}

I.Settings.registerGroup {
    key = 'SettingsHeadshots_weaponTypes',
    page = 'Headshots',
    l10n = 'Headshots',
    name = 'weaponTypes_group_name',
    order = 2,
    permanentStorage = true,
    settings = {
        {
            key = 'marksmanBowEnabled',
            name = 'marksmanBowEnabled_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'marksmanCrossbowEnabled',
            name = 'marksmanCrossbowEnabled_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'marksmanThrownEnabled',
            name = 'marksmanThrownEnabled_name',
            renderer = 'checkbox',
            default = true,
        },
    }
}

I.Settings.registerGroup {
    key = 'SettingsHeadshots_debug',
    page = 'Headshots',
    l10n = 'Headshots',
    name = 'debug_group_name',
    order = 100,
    permanentStorage = true,
    settings = {
        {
            key = 'printToConsole',
            name = 'printToConsole_name',
            description = 'printToConsole_description',
            renderer = 'checkbox',
            default = false,
        },
    }
}