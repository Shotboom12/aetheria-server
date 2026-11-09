/* CoA Ranger script package registration for the Hero-owned Ranger kit. */

#include "AscensionRangerTalents.h"
#include "SpellInfo.h"

void ApplyCoARangerContracts(SpellInfo* spellInfo)
{
    ApplyAscensionRangerTalentContracts(spellInfo);
}

void AddSC_AscensionRangerArchery();
void AddSC_AscensionRangerDeadeye();
void AddSC_AscensionRangerDirtyFighter();
void AddSC_AscensionRangerFalconstrike();
void AddSC_AscensionRangerFlowers();
void AddSC_AscensionRangerHookshot();
void AddSC_AscensionRangerOutmaneuver();
void AddSC_AscensionRangerPetalkeeper();
void AddSC_AscensionRangerSecondary();
void AddSC_AscensionRangerTalents();
void AddSC_AscensionRangerToTheSkies();
void AddAscensionRangerDamageScripts();
void AddAscensionRangerScalingScripts();
void AddAscensionRangerAssaultScripts();

void AddCoARangerPackage()
{
    // Rusty Shiv, Skullpiercer/Nerve Venom/Burning Toxin and Assault were defined and compiled but never registered.
    AddAscensionRangerDamageScripts();
    AddAscensionRangerScalingScripts();
    AddAscensionRangerAssaultScripts();
    AddSC_AscensionRangerArchery();
    AddSC_AscensionRangerDeadeye();
    AddSC_AscensionRangerDirtyFighter();
    AddSC_AscensionRangerFalconstrike();
    AddSC_AscensionRangerFlowers();
    AddSC_AscensionRangerHookshot();
    AddSC_AscensionRangerOutmaneuver();
    AddSC_AscensionRangerPetalkeeper();
    AddSC_AscensionRangerSecondary();
    AddSC_AscensionRangerTalents();
    AddSC_AscensionRangerToTheSkies();
}
