## Pre-requisitos
* 1. Instalacion Terraform : 
* 2. Instalacion AWS CLI:

## Consideraciones
* 1. Comandos mostrados en Power Shell
* 2. La infraestructura AWS se ejecutara sobre REGION OREGON (us-west-2)

## Generar SSH

* Crear directorio para las keys si no existe
```
if (!(Test-Path "$env:USERPROFILE\.ssh")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh"
}
```
* Generar par de llaves SSH
```
ssh-keygen -t rsa -b 2048 -f "$env:USERPROFILE\.ssh\terraform-lab" -N '""'
```

* Verificar que se crearon las llaves
```
Get-ChildItem "$env:USERPROFILE\.ssh\terraform-lab*"
```

## Actualizar la ruta de la llave publica

* Ir al archivo main.tf principal y actualizar la linea 72, con la ruta absoluta donde se generero llave SHH (terraform-lab.pub) 

Ejemplo: 
![SHH key pub](images/ssh.png)


## Inicializar Terrraform

Nota: Ubicarse en el directorio raiz del proyecto (\lab-terraform)

* Inicializar Terraform (descargar providers)
terraform init

* Verificar la inicialización
terraform version


## Validar Configuracion

