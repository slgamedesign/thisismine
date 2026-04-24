<div align="center">
  <img src="assets/thatsmineintro.png" width="500">
  <h1>⚖️ That's Mine! (License Game)</h1>
</div>

  *An educational simulation game about copyright, licenses, and legal demands.*

  [![Engine: Godot 4.4](https://img.shields.io/badge/Godot-4.4-478cbf?logo=godot-engine&logoColor=white)](#)
  [![Course: TADS](https://img.shields.io/badge/Academic-TADS-4f46e5.svg)](#)
  [![OST: Original](https://img.shields.io/badge/Audio-Original_Soundtrack-1db954.svg)](#)
</div>

---

## 📖 About the Project

**That's Mine!** is an interactive simulation game designed to teach players about intellectual property, product licensing, and copyright infringement. Heavily inspired by the bureaucratic thriller *Papers, Please*, the player acts as a legal reviewer who must analyze incoming lawsuits, verify product licenses, and determine if an actual infraction has occurred.

This project was developed as a Final Project for the **Technical English** course in the **TADS** (Tecnologia em Análise e Desenvolvimento de Sistemas) undergraduate program. It makes learning about licenses (Creative Commons, Open Source, and strict Copyright) engaging through deductive gameplay and decision-making.

---

## 🎨 Art & Audio (100% Original)

A major highlight of this project is its custom audiovisual identity:
* **Original Soundtrack (OST):** All background music and audio tracks were composed and performed entirely from scratch by the developers themselves (who play together in a band).
* **Custom Sprites:** Every character, document, and environmental asset was hand-drawn specifically for this game.

---

## 🎮 Gameplay Mechanics
<img src="assets/thatsmine.gif" width="600">

The game loop relies on reading comprehension and attention to detail. During a shift, the player goes through the following steps:

1. **The Demand:** A character approaches the desk and hands over a lawsuit/demand document.
2. **Analysis:** The player reads the document and identifies the specific license of the product being sued over.
3. **Investigation:** The player cross-references the license rules to mark any legal infractions (if they exist).
4. **The Verdict:** Based on the evidence, the player must officially **Approve** or **Disapprove** the lawsuit.

---

## 🚀 How to Play

You do not need to download the Godot Engine to play the game! 

### Play on Windows
1. Go to the [Releases](#) page of this repository.
2. Download the `.exe` and its associated `.pck` file.
3. Keep both files in the same folder and double-click the `.exe` to start your shift.

### For Developers (Build from Source)
If you want to edit the game or see how it works under the hood:
1. Download **Godot Engine 4.4** from the official website.
2. Clone this repository.
3. Open Godot, click **Import**, select the `project.godot` file, and press `F5` to run.

---

## 🛠️ Technical Architecture

* **Engine:** Godot Engine 4.4.
* **Core Logic:** The game's architecture is driven by `Global.gd`, a Singleton/Autoload script that tracks the current state of the game, generates lawsuits, records player decisions, and manages the flow between scenes.

---

## 📝 License & Usage

**PLEASE READ THE LICENSE CAREFULLY:** The specific terms of use, distribution, and attribution for this educational project are detailed in the `LICENSE.md` file included in this repository. Ensure you review it before using or modifying the assets.
