### bradley-simulator

---

### Upute s prez

- [ ] Upoznati se s arhitekturom ovakvih simulatora i ukratko ju opisati na temelju: djelovođa poslati neki članak; studentski tim pogledati po Google Scholaru i Googleu dodatne znanstvene članke i brošure postojećih simulatora
- [ ] U izabranom alatu npr. Unity / Unreal / Godot / PyGame / …, ostvariti pojednostavljenu simulaciju oklopnjaka i 3D scene, s vizualnim efektima gibanja po terenu, ispaljivanja oružja (kosi hitac) i pogotka u cilj (npr. druge oklopnjake) ili teren itd.
- [ ] Matematički model treba napraviti drastično pojednostavljen (kinematički) isključivo za potrebe demonstracije koncepta - ne bavimo se matematičkim modeliranjem ovih sustava + netko eksperimentirati s LLM-om za dinamički ali upravljivi model
- [ ] Ograničena simulacija izabranih osnovnih instrumenata na kontrolnoj ploči vozila, na temelju javno dostupnih informacija
- [ ] Demonstracija treba imati scenarij u kojemu imamo regularne situacije i onda više izvanredne/stresne situacije – npr. scenarij gdje prvih par oklopnjaka ne uzvraća paljbu, a onda uzvraćaju paljbu manje ili više točno/precizno
- [ ] Ovisno o afinitetima tima, može se kao deployment platforma ciljati obični laptop, ili mobitel, ili …

---

>[!NOTE]
>M2 Bradley research linkovi
> - Wiki: https://en.wikipedia.org/wiki/M2_Bradley
> - Interior: [https://en.defence-ua.com/weapon_and_tech/](https://en.defence-ua.com/weapon_and_tech/what_does_m2a2_bradley_look_like_from_inside_analyzing_ukraines_new_combat_vehicle_photo-5382.html)
> - Promo: https://youtu.be/xqDgn-qXr0E
> - Design: https://youtu.be/gNHnC81K7EA
> - Bradleycoft: https://www.oasis-ae.com/bradleycoft

---

>[!NOTE]
>Assets linkovi
> - Terrain (MIT License): https://terrain3d.readthedocs.io/en/latest/index.html
> - Bradley model (CC BY 4.0): https://sketchfab.com/3d-models/m2-bradley-ifv-ab022158ab5f4fbfa55d4142db7595ab
> - Textures (free): https://www.cgbookcase.com/
> - Textures (free): https://freepbr.com/
> - Tree models (Free Standard): https://sketchfab.com/3d-models/coniferous-forest-assets-pack-240ce9cf0ad3474f809a59f9446e63cd 
> - Tree models (Free Standard): https://sketchfab.com/3d-models/various-forest-assets-pack-cf138b8eb2d340cda643ed59f824989c
> - Grass models (CC BY 4.0): https://sketchfab.com/3d-models/grass-pack-lp-3352f9d646ec4f25b8aeb28e4232814a

---

<table>
    <tr>
        <th>Element</th>
        <th>Opcije</th>
        <th>Izabrano</th>
        <th>Dodjeljeni</th>
        <th>Stanje</th>
    </tr>
    <tr>
        <td>1. 3D terrain</td>
        <td>
            <ol type="a">
                <li>Simple plane</li>
                <li>3D height map/triangle mesh</li>
                <li>3D height map/triangle mesh with textures, miscellaneous objects<br/> (buildings, trees, billboards…)</li>
            </ol>
            <em>
	            (Pay attention to the sufficient terrain size to cover at least a few hundred meters and up to a couple kilometers, which is within effective firing range of various tank guns)
            </em>
        </td>
        <td><kbd>c)</kbd></td>
        <td>Golub</td>
        <td><kbd>Nedovršeno</kbd></td>
    </tr>
    <tr>
        <td>2. 3D armored vehicle/tank</td>
        <td>
            <ol type="a">
                <li>Sphere/Box</li>
                <li>Simple model – boxes and cylinders</li>
                <li>Imported 3D model</li>
                <li>Personally designed 3D model</li>
            </ol>
        </td>
        <td><kbd>c)</kbd></td>
        <td>Golub</td>
        <td><kbd>Gotovo</kbd></td>
    </tr>
    <tr>
        <td>3. 3D targets</td>
        <td>
            <ol type="a">
                <li>Sphere/Box</li>
                <li>Simple model – boxes and cylinders</li>
                <li>Imported 3D model</li>
                <li>Personally designed 3D model</li>
            </ol>
            <em>(other armored vehicles/tanks)</em>
        </td>
        <td><kbd>c)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>4. Armored vehicle/tank simulation on the terrain</td>
        <td>
            <ol type="a">
                <li>Simultaneous coupled manual control of the motion and aiming (e.g. keyboard w-s for turn left-right, space for engine thrust) </li>
                <li>Separate manual control of the motion vs. aiming (e.g. keyboard for motion, mouse for aiming)</li>
                <li>...</li>
                <li>Dynamics model using differential equations derived from forces and/or moments, but which is easily controllable by keyboard and mouse – some team member should work this out with their favorite Large Language Model (save and attach all discussions). 
                    <em>
                        <ul>
                            <li>One potential option to consider in trying to minimize complexity is to ask LLM to use forces and corresponding differential equations, but not to use moments, and instead of using moments, to have rotation angles (attitude of the object) controlled directly by the keyboard or mouse. </li>
                            <li>This model should output the same information as the model under option a, ... (for example, x, y, z, and 3 angles of rotation) – in this way, models can easily be switched in the simulation.</li>
                        </ul>
                    </em>
                </li>
            </ol>
            <em>(any one of a, b, … + mandatory d)</em>
        </td>
        <td><kbd>b)</kbd><br/><kbd>d)</kbd></td>
        <td>Golub <br/>???</td>
        <td><kbd>Gotovo</kbd> <br/> <kbd>Nedovršeno</kbd></td>
    </tr>
    <tr>
        <td>5. Target motion simulation</td>
        <td>
            <ol type="a">
                <li>No motion, static targets</li>
                <li>a + Linear terrain following motion using approximate speed</li>
                <li>...</li>
            </ol>
        </td>
        <td><kbd>?)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>6. Simulacija osnovnih instrumenata na kontrolnoj ploči vozila</td>
        <td>
            <ol type="a">
                <li>Overlay vlastitih bazičnih 3D elemenata – spljoštene sfere, izduženi kvadri kao kazaljke itd.</li>
                <li>Overlay vlastitih 2D elemenata – krugovi, izduženi trokuti kao kazaljke, itd.</li>
                <li>Overlay gotovih 2D elemenata ako postoji GUI biblioteka unutar razvojnog alata</li>
                <li>Integrirana 3D kontrolna ploča unutar 3D modela samog vozila</li>
            </ol>
            <em>(bar 2 izlazna instrumenta i bar 1 ulazni instrument)</em>
        </td>
        <td><kbd>d)</kbd></td>
        <td>Golub</td>
        <td><kbd>Nedovršeno</kbd></td>
    </tr>
    <tr>
        <td>7. Setup of initial parameters of simulation</td>
        <td>
            <ol type="a">
                <li>No configuration, armored vehicle/tank and targets always at the same positions relative to the terrain </li>
                <li>Random selection of positions of armored vehicle/tank and targets, while respecting the approximate distance between them</li>
                <li>Text configuration file </li>
                <li>Graphical user interface enabling configuration of target and launcher position on a 2D map</li>
            </ol>
        </td>
        <td><kbd>?)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>8. Design of a scenario in line with the requirements of the topic as presented on the slides during introduction of seminar topics</td>
        <td>
            <ol type="a">
                <li>Vizualni efekti eksplozija u sferi oko oklopnjaka</li>
                <li>Isto kao a</li>
                <li>b + Audio efekti eksplozija u sferi oko oklopnjaka</li>
                <li>c + Efekti na podrhtavanje kamere / promjena vidljivosti itd.</li>
            </ol>
            <em>(first, regular situations (targets that don’t return fire), then emergency/stressful situations (targets that return fire))</em>
        </td>
        <td><kbd>?)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>9. Reaction of the targets to being hit</td>
        <td>
            <ol type="a">
                <li>If the target was moving it stops when hit</li>
                <li>Target disappears</li>
                <li>Target is blown up, i.e. disappears after its own explosion</li>
                <li>Target is pushed and partially damaged, or fully blown up, depending on the impact position</li>
            </ol>
        </td>
        <td><kbd>?)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>10. Tank gun round on-firing and on-impact visual effects</td>
        <td>
            <ol type="a">
                <li>No effects</li>
                <li>Effects at the time of firing and/or on impact against the target</li>
                <li>b + Effects on impact against the terrain</li>
                <li>b + c + Effects on impact against other miscellaneous objects on the terrain</li>
            </ol>
        </td>
        <td><kbd>?)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>11. Audio simulation</td>
        <td>
            <ol type="a">
                <li>No sounds</li>
                <li>Sound effects of vehicle engine, gun round firing and explosion upon impact</li>
                <li>b + Additional generic battleground sounds</li>
            </ol>
        </td>
        <td><kbd>?)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>12. Weather conditions</td>
        <td>
            <ol type="a">
                <li>No configuration</li>
                <li>Fog density</li>
                <li>b + Time of day (Sun position) …</li>
            </ol>
        </td>
        <td><kbd>c)</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
    <tr>
        <td>13. Camera selection</td>
        <td>
            <ol type="a">
                <li>Camera provides driver view of the armored vehicle/tank</li>
                <li>If separate control of motion and gun aiming, driver camera with independently controllable crosshair marker </li>
                <li>If separate control of motion and gun aiming, camera for each view (split screen)</li>
                <li>...</li>
            </ol>
        </td>
        <td><kbd>b)</kbd></td>
        <td>Golub</td>
        <td><kbd>Nedovršeno</kbd></td>
    </tr>
    <tr>
        <td>14. Replay capabilities</td>
        <td>
            <ol type="a">
                <li>None</li>
                <li>Can replay the last executed simulation</li>
            </ol>
        </td>
        <td><kbd>a)</kbd></td>
        <td>-</td>
        <td><kbd>Gotovo</kbd></td>
    </tr>
    <tr>
        <td>15. Dokumentacija</td>
        <td>
            <ul>
                <li>primjeri postojecih simulatora oklopnih vozila</li>
                <li>lista poruka s LLM</li>
                <li>???</li>
            </ul>
        </td>
        <td><kbd>-</kbd></td>
        <td></td>
        <td><kbd>Nije početo</kbd></td>
    </tr>
</table>

---

