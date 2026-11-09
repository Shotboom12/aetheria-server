/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */
// Aetheria partial Guardian package: only individually reviewed Hero-gated scripts are registered.

#include "AscensionGuardianResources.h"
#include "SpellInfo.h"

void AddAscensionGuardianDrumScripts();
void AddAscensionGuardianFavorScripts();
void AddAscensionGuardianEventScripts();
void AddAscensionGuardianAbilityScripts();
void AddAscensionGuardianCompletionScripts();
void AddAscensionGuardianStandardScripts();
void AddAscensionGuardianTalentScripts();

void AddCoAGuardianPackage()
{
    AddAscensionGuardianDrumScripts();
    AddAscensionGuardianFavorScripts();
    AddAscensionGuardianEventScripts();
    AddAscensionGuardianAbilityScripts();
    AddAscensionGuardianCompletionScripts();
    AddAscensionGuardianStandardScripts();
    AddAscensionGuardianTalentScripts();
}

void ApplyCoAGuardianContracts(SpellInfo* spellInfo)
{
    ApplyAscensionGuardianResourceContracts(spellInfo);
}

