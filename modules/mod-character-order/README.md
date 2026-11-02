\# mod-character-order



An AzerothCore module that allows players to persistently reorder the characters on their account from inside the game.



\## Features



\- Adds the player command `.charorder`.

\- Uses a native in-game gossip menu.

\- Displays each character's position, name, level, race, and class.

\- Supports moving a character up, down, to the top, or to the bottom.

\- Refreshes the selected character's position immediately after every movement.

\- Hides movement options that cannot apply to the first or last character.

\- Saves the order on the character-selection screen.

\- Includes newly created characters and excludes deleted characters.

\- Requires no client modification, addon, Eluna installation, configuration file, or database migration.



\## Installation



1\. Clone this repository into your AzerothCore `modules` directory:



&#x20;  ```bash

&#x20;  git clone https://github.com/Souicia/mod-character-order.git

&#x20;  ```



2\. Run CMake configuration again.

3\. Rebuild `worldserver`.

4\. Restart the server.



\## Usage



Log into any character and enter:



```text

.charorder

```



Select a character, then choose where it should be moved. Log out to the character-selection screen to see the saved order.



\## Requirements



This module requires an AzerothCore revision containing the existing `characters.order` column and character-enumeration ordering support introduced by \[AzerothCore PR #6555](https://github.com/azerothcore/azerothcore-wotlk/pull/6555).



Current AzerothCore installations already include this support.



\## Security



The account ID is obtained from the authenticated game session. Character ownership is validated again on every gossip selection, and every database update is restricted to the authenticated account.



Reordering is saved through a synchronous database transaction.



\## Licence



This project is released under the \[MIT License](LICENSE).