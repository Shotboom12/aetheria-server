/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// This is where scripts' loading functions should be declared:
void AddSC_centaur_travel();
void AddSC_slime_centaur_racials();
void AddSC_kyrian_hover();
void AddSC_kyrian_racials();
void AddSC_venthyr_racials();
void AddSC_ethereal_forms();
void AddSC_race_racials();
void AddSC_drakkin_racials();
void AddSC_drakonid_racials();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddCustomScripts()
{
    AddSC_centaur_travel();
    AddSC_slime_centaur_racials();
    AddSC_kyrian_hover();
    AddSC_kyrian_racials();
    AddSC_venthyr_racials();
    AddSC_ethereal_forms();
    AddSC_race_racials();
    AddSC_drakkin_racials();
    AddSC_drakonid_racials();
}
