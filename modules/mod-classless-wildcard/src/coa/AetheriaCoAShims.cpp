/*
 * Aetheria shims for functions the reference CoA core defines in code Aetheria does not carry.
 * Kalibros' Esteria module answers the same questions with stubs; these do the same for the Hero.
 */

#include "CoAPort.h"
#include "AscensionWildcard.h"
#include "AscensionWitchHunterCompletion.h"
#include "ClasslessMgr.h"
#include "Player.h"

// CoA answers this from its appearance collection, which Aetheria does not have: the Shadowhound keeps
// its creature display (0 means "no override").
uint32 AscensionWitchHunter::GetShadowhoundDisplay(Player* /*player*/)
{
    return 0;
}

// In CoA a "wildcard Hero" is a character that picked its abilities freely. Here that is exactly the Hero
// class while the Classless system is enabled.
bool AscensionWildcard::IsWildcardHero(Player const* player)
{
    return player && player->getClass() == CLASS_HERO && sClasslessMgr->cfg.enabled;
}
