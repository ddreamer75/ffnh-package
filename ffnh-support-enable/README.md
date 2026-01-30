# ffnh-support-enable

Dieses Gluon-Paket fügt im Konfigurationsmodus (Config Mode) eine Option hinzu, die es ermöglicht, den Supportzugang des **Freifunk Nordhessen e.V.** für einen Knoten zu aktivieren.  
Wenn die Option aktiviert ist, werden die in der `site.conf` hinterlegten Support‑SSH‑Keys automatisch in die `authorized_keys` des Gerätes eingetragen – **ohne Nutzer‑Schlüssel zu verändern**.

Das Paket stellt sicher, dass die Support‑Schlüssel stets mit der Domain‑Konfiguration synchron sind.  
Änderungen in der `site.conf` durch Firmware‑Updates werden automatisch übernommen (neue Admins → Schlüssel hinzugefügt, ausgeschiedene Admins → Schlüssel entfernt).

---

## 📦 Funktionen

### ✔ Config Mode Integration
Im Konfigurationsmodus erscheint eine zusätzliche Checkbox:

**„Unterstützung durch Freifunk Nordhessen e.V. zulassen“**

### ✔ Synchronisation der Support‑SSH‑Keys
Wenn aktiviert:

- Support‑Keys aus `site.conf` werden **hinzugefügt**
- Keys von ausgeschiedenen Administratoren werden **entfernt**
- Nutzerschlüssel bleiben vollständig **unangetastet**

automatisch ausgeführt.

---

## 🔧 Konfiguration (`site.conf`)

Die Support‑Schlüssel werden in der Domain‑Konfiguration definiert:

```lua
support = {
  ssh = {
    keys = {
      "ssh-ed25519 AAAA... admin1",
      "ssh-ed25519 BBBB... admin2",
      "ssh-ed25519 CCCC... admin3",
    }
  }
}
