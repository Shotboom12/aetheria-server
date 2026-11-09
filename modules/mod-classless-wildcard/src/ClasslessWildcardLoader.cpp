/* Copyright (C) 2016+ AzerothCore, GNU AGPL v3. */

void AddClasslessAddonScripts();
void AddClasslessCommandScripts();
void AddClasslessCoAScripts();
void AddClasslessCoAClassScripts();
void AddClasslessForgedScripts();
void AddClasslessLootScripts();
void AddClasslessNpcScripts();
void AddClasslessPlayerScripts();
void AddClasslessLoginStatePreloader();

void Addmod_classless_wildcardScripts()
{
    AddClasslessLoginStatePreloader();
    AddClasslessAddonScripts();
    AddClasslessCommandScripts();
    AddClasslessCoAScripts();
    AddClasslessCoAClassScripts();
    AddClasslessForgedScripts();
    AddClasslessLootScripts();
    AddClasslessNpcScripts();
    AddClasslessPlayerScripts();
}
