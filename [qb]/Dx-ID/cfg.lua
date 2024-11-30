cfg = {}
cfg.chatEvent = 'chat:addMessage'
cfg.showOn = 'seperateInterface' -- 'chat' - 'seperateInterface'
cfg.mugShot = true
cfg.showDistance = 5.0
cfg.showTimeout = 10 --second

cfg.interfacePositons = {
    ['top-left'] = { ['left'] = '0%', ['top'] = '0%' },
    ['top-center'] = { ['left'] = '50%', ['transform'] = 'translate(-50%, 0)' },
    ['top-right'] = { ['right'] = '0%', ['top'] = '0%' },
    ['center-left'] = { ['left'] = '0%', ['top'] = '50%', ['transform'] = 'translate(0, -50%)' },
    ['center-center'] = { ['left'] = '50%', ['top'] = '50%', ['transform'] = 'translate(-50%, -50%)' },
    ['center-right'] = { ['right'] = '0%', ['top'] = '50%', ['transform'] = 'translate(0, -50%)' },
    ['bottom-left'] = { ['left'] = '0%', ['bottom'] = '0%' },
    ['bottom-center'] = { ['left'] = '50%', ['bottom'] = '0%', ['transform'] = 'translate(-50%, 0)' },
    ['bottom-right'] = { ['right'] = '0%', ['bottom'] = '0%' },
}
cfg.interfacePosition = 'center-right'

if not IsDuplicityVersion() then return end

cfg.framework = 'qb' -- qb - esx
cfg.locale = 'en'
cfg.locales = {
    ['en'] = {
        ['name'] = 'Name',
        ['surname'] = 'Surname',
        ['gender'] = 'Gender',
        ['dob'] = 'Date Of Birth',
        ['nationality'] = 'Nationality',
        ['citizenid'] = 'Citizen ID',
        ['signature'] = 'Signature',
        ['male'] = 'Male',
        ['female'] = 'Female',
        ['type'] = 'Type',
        ['nothavealicense'] = 'You do not have a license.',
        ['unknown'] = 'Unknown',
        ['drive'] = 'Class C',


        -- for esx
        ['drive_bike'] = 'Class M1',
        ['drive_truck'] = 'Class A'
    },
}

cfg.cards = {
    --qb cards
    ['idcard'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'id_card', -- or false
        useItemInfo = true,
        cardBackground = 'card',
        title = 'Citizen Card',
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
                itemInfoKey = 'firstname',
            },
            [2] = {
                title = cfg.locales[cfg.locale]['nationality'],
                editableFunctionName = 'getNationality',
                itemInfoKey = 'nationality'
            },
            [3] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
                itemInfoKey = 'lastname'
            },
            [4] = {
                title = cfg.locales[cfg.locale]['citizenid'],
                editableFunctionName = 'getCID',
                itemInfoKey = 'citizenid'
            },
            [5] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender',
                itemInfoKey = 'gender'
            },
            [6] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
                itemInfoKey = 'birthdate'
            },
            [7] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
    ['drivercard'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'driver_license', -- or false
        useItemInfo = true,
        cardBackground = 'card',
        title = 'Driver License',
        canShow = function(src)
            local player = QBCore.Functions.GetPlayer(src);
            if not player then return false end
            return player.PlayerData.metadata["licences"]["driver"]
        end,
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
                itemInfoKey = 'firstname'
            },
            [2] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
                itemInfoKey = 'lastname'
            },
            [3] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
                itemInfoKey = 'birthdate'
            },
            [4] = {
                title = cfg.locales[cfg.locale]['type'],
                editableFunctionName = 'getDriverType',
                itemInfoKey = 'type'
            },
            [5] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender'
            },
            [6] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
    ['lawyerpass'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'lawyerpass', -- or false
        useItemInfo = false,
        cardBackground = 'PD',
        title = 'Lawyer Pass',
        titleColor = 'orange',
        canShow = function(src)
            local player = QBCore.Functions.GetPlayer(src);
            if not player then return false end
            return player.PlayerData.job.name == 'doj' and true or false
        end,
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
            },
            [2] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
            },
            [3] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
            },
            [4] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender',
            },
            [5] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
    ['policecard'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'policecard', -- or false
        useItemInfo = false,
        cardBackground = 'PD',
        title = 'Police Badge',
        titleColor = 'blue',
        canShow = function(src)
            local player = QBCore.Functions.GetPlayer(src);
            if not player then return false end
            return player.PlayerData.job.name == 'police' or player.PlayerData.job.name == 'bcso' and true or false
        end,
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
            },
            [2] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
            },
            [3] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
            },
            [4] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender',
            },
            [5] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
    ['emscard'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'ems_idcard', -- or false
        useItemInfo = false,
        cardBackground = 'EMS',
        title = 'EMS Badge',
        titleColor = 'red',
        canShow = function(src)
            local player = QBCore.Functions.GetPlayer(src);
            if not player then return false end
            return player.PlayerData.job.name == 'ambulance' and true or false
        end,
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
            },
            [2] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
            },
            [3] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
            },
            [4] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender',
            },
            [5] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
    ['VCorporationCard'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'vcorporation_idcard', -- or false
        useItemInfo = false,
        cardBackground = 'card',
        title = 'VCorporation LTD',
        titleColor = 'orange',
        canShow = function(src)
            local player = QBCore.Functions.GetPlayer(src);
            if not player then return false end
            return player.PlayerData.job.name == 'vcorporation' and true or false
        end,
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
            },
            [2] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
            },
            [3] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
            },
            [4] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender',
            },
            [5] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
    ['weaponlicense'] = {
        command = false, -- or 'showidcard' -- Shows the card in the information of the person using the command
        item = 'weaponlicense', -- or false
        useItemInfo = false,
        cardBackground = 'card',
        title = 'Weapon License',
        titleColor = 'red',
        canShow = function(src)
            local player = QBCore.Functions.GetPlayer(src);
            if not player then return false end
            return player.PlayerData.metadata["licences"]["weapon"]
        end,
        fields = {
            [1] = {
                title = cfg.locales[cfg.locale]['name'],
                editableFunctionName = 'getName',
            },
            [2] = {
                title = cfg.locales[cfg.locale]['surname'],
                editableFunctionName = 'getSurname',
            },
            [3] = {
                title = cfg.locales[cfg.locale]['dob'],
                editableFunctionName = 'getDOB',
            },
            [4] = {
                title = cfg.locales[cfg.locale]['gender'],
                editableFunctionName = 'getGender',
            },
            [5] = {
                title = cfg.locales[cfg.locale]['signature'],
                editableFunctionName = 'getSignature'
            }
        }
    },
}

cfg.metadataKey = GetResourceState('ox_inventory') == 'started' and 'metadata' or 'info' -- 'info' for qb-inventory, 'metadata' for ox_inventory
