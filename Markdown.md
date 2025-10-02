# Instalación de zonas mestras primarias
## 1. Instala o servidor BIND9 no equipo darthvader. Comproba que xa funciona coma servidor DNS caché pegando no documento de entrega a saída deste comando dig @localhost www.edu.xunta.es
dig @localhost www.edu.xunta.es

## 2. Configura o servidor BIND9 para que empregue como reenviador 8.8.8.8. pegando no documento de entrega contido do ficheiro /etc/bind/named.conf.options e a saída deste comando: dig @localhost www.mecd.gob.es
dig @localhost www.mecd.gob.es



## 3. Instala unha zona primaria de resolución directa chamada "starwars.lan" e engade os seguintes rexistros de recursos (a maiores dos rexistros NS e SOA imprescindibles):
- Tipo A: darthvader con IP 192.168.20.10
- Tipo A: skywalker con IP 192.168.20.101
- Tipo A: skywalker con IP 192.168.20.111
- Tipo A: luke con IP 192.168.20.22
- Tipo A: darthsidious con IP 192.168.20.11
- Tipo A: yoda con IP 192.168.20.24 e 192.168.20.25
- Tipo A: c3p0 con IP 192.168.20.26
- Tipo CNAME palpatine a darthsidious
- TIPO MX con prioridade 10 sobre o equipo c3po
- TIPO TXT "lenda" con "Que a forza te acompanhe"
- TIPO NS con darthsidious
- Pega no documento de entrega o contido do arquivo de zona, e do arquivo /etc/bind/named.conf.local
### Arquivo db.starwars.lan
```
;
; Archivo de zona para starwars.lan
;
$TTL    86400   ; TTL por defecto para todos los registros (1 día)
$ORIGIN starwars.lan.

; Registro SOA (Start of Authority)
@       IN      SOA     ns1.starwars.lan. admin.starwars.lan. (
                        1              ; Serial (AAAAMMDDNN)
                        3600           ; Refresh (1 hora)
                        1800           ; Retry (30 minutos)
                        1209600        ; Expire (2 semanas)
                        86400          ; Negative Cache TTL (1 día)
                        )

; Registro NS (Name Server)
@       IN      NS      darthsidious.starwars.lan.

; Registros A
darthvader  IN      A       192.168.20.10
skywalker   IN      A       192.168.20.101
skywalker   IN      A       192.168.20.111
luke    IN      A       192.168.20.22
darthsidious    IN      A       192.168.20.11
yoda    IN      A       192.168.20.24
yoda    IN      A       192.168.20.25
c3p0    IN      A       192.168.20.26

; Registro MX (Mail Exchange)
@       IN      MX      10 c3po.starwars.lan.

; Registro CNAME
palpatine   IN      CNAME   darthsidious.starwars.lan.
```
### Arquivo /etc/bind/named.conf.local
```
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

// Zona directa para starwars.lan
zone "starwars.lan" {
    type master;
    file "/etc/bind/db.starwars.lan";
    allow-update { none; };
};
```
## 4. Instala unha zona de resolución inversa que teña que ver co enderezo do equipo darthvader, e engade rexistros PTR para os rexistros tipo A do exercicio anterior. Pega no documento de entrega o contido do arquivo de zona, e do arquivo /etc/bind/named.conf.local
### Arquivo db.20.168.192
```
;
; Archivo de zona inversa para la red 192.168.20.0/24
; Zona: 20.168.192.in-addr.arpa
;
$TTL    86400   ; TTL por defecto para todos los registros (1 día)
$ORIGIN 20.168.192.in-addr.arpa.

; Registro SOA (Start of Authority)
@       IN      SOA     ns1.starwars.lan. admin.starwars.lan. (
                        2025100201     ; Serial (AAAAMMDDNN)
                        3600           ; Refresh (1 hora)
                        1800           ; Retry (30 minutos)
                        1209600        ; Expire (2 semanas)
                        86400          ; Negative Cache TTL (1 día)
                        )

; Registro NS (Name Server)
@       IN      NS      darthsidious.starwars.lan.

; Registros PTR (Pointer Records) para resolución inversa
10      IN      PTR     darthvader.starwars.lan.
101     IN      PTR     skywalker.starwars.lan.
111     IN      PTR     skywalker.starwars.lan.
22      IN      PTR     luke.starwars.lan.
11      IN      PTR     darthsidious.starwars.lan.
24      IN      PTR     yoda.starwars.lan.
25      IN      PTR     yoda.starwars.lan.
26      IN      PTR     c3p0.starwars.lan.
```
### Arquivo /etc/bind/named.conf.local
```
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

// Zona directa para starwars.lan
zone "starwars.lan" {
    type master;
    file "/etc/bind/db.starwars.lan";
    allow-update { none; };
};

// Zona inversa para la red 192.168.20.0/24
zone "20.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.20.168.192";
    allow-update { none; };
};
```
## 5. Comproba que podes resolver os distintos rexistros de recursos. Pega no documento de entrega a saída dos comandos:
- nslookup darthvader.starwars.lan localhost
- nslookup skywalker.starwars.lan localhost
- nslookup starwars.lan localhost
- nslookup -q=mx starwars.lan localhost
- nslookup -q=ns starwars.lan localhost
- nslookup -q=soa starwars.lan localhost
- nslookup -q=txt lenda.starwars.lan localhost
- nslookup 192.168.20.11 localhost