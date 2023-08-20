# MaxDamage81_infra
MaxDamage81 Infra repository

HomeWork 3 Part 1

Using jumphost:
ssh -i ~/.ssh/appuser -J appuser@158.160.47.187 appuser@10.128.0.30

Using ssh config file:

---
Host  someinternalhost
    HostName 10.128.0.30
    User appuser
    ProxyJump appuser@bastion

Host bastion
    HostName 158.160.47.187
    User appuser
---

Then just type:
ssh someinternalhost
