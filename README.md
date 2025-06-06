# Curso de Terraform

Bienvenidos al repositorio público del **Curso de Terraform / Infraestructura como código**. Aquí encontrarás todo el material organizado por temas, desde la introducción hasta las conclusiones y ronda de preguntas.

---

## Tabla de Contenidos

1. **Ambiente**  
   1.1. [WSL](#11-wsl)  
   1.2. [Git](#12-git)  
   1.3. [Azure DevOps](#13-azure-devops)  
   1.4. [Terraform](#14-terraform)  

---

## 1. Ambiente

En esta sección se detallan los pasos para preparar el entorno de trabajo: instalación de WSL, Git, configuración de Azure DevOps y Terraform.

### 1.1 WSL

Para poder trabajar con Terraform y las herramientas de línea de comandos en un entorno Linux dentro de Windows, utilizaremos el **Windows Subsystem for Linux (WSL)**.

#### 1.1.1 Habilitar WSL

1. Abre PowerShell **como Administrador** y ejecuta:
   ```powershell
   wsl --install
   ```
   - Este comando habilita WSL y descarga la distribución predeterminada (normalmente Ubuntu).
   - Si ya tienes WSL habilitado, puedes omitir este paso.

2. **Reinicia** tu equipo cuando termine la instalación.

3. En la primera vez que arranque WSL, se te pedirá que crees un usuario y una contraseña para la distribución de Linux (por ejemplo, Ubuntu).

#### 1.1.2 Actualizar Ubuntu

Una vez dentro de la terminal de Ubuntu:
```bash
sudo apt update && sudo apt upgrade -y
```

#### 1.1.3 Instalar herramientas adicionales (opcional)

- **build-essential** (para compilar paquetes que requieran compilación):
  ```bash
  sudo apt install build-essential -y
  ```
- **curl** (para descargar archivos):
  ```bash
  sudo apt install curl -y
  ```

> **Nota:** Asegúrate de usar WSL 2 si tu máquina lo soporta. Puedes verificar la versión con:
> ```powershell
> wsl --list --verbose
> ```
> Si no está en versión 2, puedes migrar con:
> ```powershell
> wsl --set-version <DistroName> 2
> ```

### 1.2 Git

Git es necesario para clonar repositorios, hacer control de versiones y contribuir al proyecto de Terraform.

#### 1.2.1 Instalar Git en Ubuntu (WSL)

Dentro de la terminal de Ubuntu:
```bash
sudo apt install git -y
```

#### 1.2.2 Verificar instalación

```bash
git --version
```
Deberías ver algo como:
```
git version 2.x.x
```

#### 1.2.3 Configurar usuario y correo globalmente

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu.email@ejemplo.com"
```

#### 1.2.4 Generar clave SSH (recomendado)

Para autenticarte sin contraseña al clonar o subir cambios a un repositorio remoto (GitHub, Azure Repos, GitLab, etc.):

1. Genera la clave:
   ```bash
   ssh-keygen -t ed25519 -C "tu.email@ejemplo.com"
   ```
   - Presiona Enter para aceptar las ubicaciones por defecto (`~/.ssh/id_ed25519`).
   - Ingresa una passphrase si quieres (recomendado) o déjalo vacío.

2. Copia la clave pública al portapapeles:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   y luego pégala en la sección de “SSH Keys” de tu cuenta de GitHub, GitLab o Azure DevOps.

3. Prueba la conexión:
   ```bash
   ssh -T git@github.com
   ```
   o si usas Azure DevOps:
   ```bash
   ssh -T git@ssh.dev.azure.com
   ```

### 1.3 Azure DevOps

Azure DevOps será la plataforma de CI/CD y gestión de repositorios para acompañar nuestro curso de Terraform.

#### 1.3.1 Crear una organización en Azure DevOps

1. Abre tu navegador y accede a:  
   ```
   https://dev.azure.com
   ```
2. Inicia sesión con tu cuenta de Microsoft o cuenta educativa/empresarial.
3. Si es la primera vez, se te pedirá crear tu primera “Organización”. Completa los campos:
   - **Nombre de la Organización**: por ejemplo, `terraform-curso`.
   - **Región**: selecciona la más cercana a tu ubicación (p. ej., “Global” o “Oeste de EE. UU.”).
4. Haz clic en **Crear organización**. Espera unos segundos hasta que se cree el espacio.

#### 1.3.2 Crear un Proyecto en la Organización

1. Dentro de tu organización, haz clic en **New Project**.
2. Completa los campos:
   - **Project name**: `curso-terraform`.
   - **Description**: (opcional) `Repositorio para el curso de Terraform`.
   - **Visibility**: Selecciona **Public** si quieres que cualquiera pueda ver el repositorio, o **Private** si solo miembros específicos.
3. Haz clic en **Create**.

A partir de este momento, tendrás:
- Un repositorio Git propio (`curso-terraform`).
- Secciones de Boards, Repos, Pipelines, Test Plans, Artifacts.

#### 1.3.3 Instalar Azure CLI y extensión de Azure DevOps (opcional, pero recomendado)

Si prefieres trabajar desde línea de comandos, instala **Azure CLI** en WSL:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Verifica:
```bash
az --version
```

Luego, instala la extensión de Azure DevOps:
```bash
az extension add --name azure-devops
```

Configura la organización por defecto:
```bash
az devops configure --defaults organization=https://dev.azure.com/terraform-curso
```

Ahora podrás ejecutar comandos como:
```bash
# Clonar tu repo desde la línea de comandos:
git clone https://dev.azure.com/terraform-curso/curso-terraform/_git/curso-terraform

# Crear un nuevo proyecto via CLI (si no lo hiciste por UI):
az devops project create --name "curso-terraform"
```

> **Nota:** Para interactuar con los Pipelines desde CLI, es posible que necesites un Personal Access Token (PAT) con permisos adecuados y exportarlo como:
> ```bash
> export AZURE_DEVOPS_EXT_PAT=<tu_token>
> ```

### 1.4 Terraform

Terraform es la herramienta de Infraestructura como Código que utilizaremos para aprovisionar recursos en Azure.

#### 1.4.1 Instalar Terraform en Ubuntu (WSL)

##### Opción A: Repositorio oficial de HashiCorp (recomendado)

1. Configurar repositorio:
   ```bash
   sudo apt-get update      && sudo apt-get install -y gnupg software-properties-common curl

   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   ```

2. Instalar Terraform:
   ```bash
   sudo apt-get update && sudo apt-get install terraform -y
   ```

3. Verificar versión:
   ```bash
   terraform --version
   ```
   Ejemplo de salida:
   ```
   Terraform v1.6.6
   ```

##### Opción B: Descarga manual (si necesitas una versión específica)

1. Descarga el ZIP desde la página oficial:
   ```bash
   wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
   ```
   (Reemplaza `1.6.6` con la versión deseada).

2. Descomprime y mueve el binario:
   ```bash
   unzip terraform_1.6.6_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   ```

3. Verificar instalación:
   ```bash
   terraform --version
   ```

#### 1.4.2 Configurar variables de entorno para Azure (Provider)

Para que Terraform pueda autenticar contra Azure, define las siguientes variables de entorno en tu terminal (puedes agregarlas a `~/.bashrc` o `~/.zshrc`):

```bash
export ARM_CLIENT_ID="<tu-client-id>"
export ARM_CLIENT_SECRET="<tu-client-secret>"
export ARM_TENANT_ID="<tu-tenant-id>"
export ARM_SUBSCRIPTION_ID="<tu-subscription-id>"
```

> Para obtener estos valores:
> 1. Crea un **Azure Service Principal** con permisos limitados (por ejemplo, Contributor sobre un Resource Group específico):
>    ```bash
>    az ad sp create-for-rbac --name "sp-terraform" >      --role="Contributor" >      --scopes="/subscriptions/<tu-subscription-id>/resourceGroups/<tu-rg>" >      --sdk-auth
>    ```
> 2. La salida JSON contendrá `clientId`, `clientSecret`, `tenantId`, `subscriptionId`. Asígnalos a las variables de entorno arriba.

#### 1.4.3 Primer archivo Terraform de ejemplo

Crea un directorio llamado `terraform-basico/` y, dentro, un `main.tf` con el siguiente contenido mínimo:

```hcl
# main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Ejemplo: Resource Group
resource "azurerm_resource_group" "rg_ejemplo" {
  name     = "rg-terraform-ejemplo"
  location = "eastus"
}

output "resource_group_name" {
  value = azurerm_resource_group.rg_ejemplo.name
}
```

##### Pasos para ejecutar:

1. Inicia Terraform en ese directorio:
   ```bash
   cd terraform-basico/
   terraform init
   ```

2. Valida la sintaxis:
   ```bash
   terraform validate
   ```

3. Haz un plan para ver qué se creará:
   ```bash
   terraform plan
   ```

4. Aplica el plan:
   ```bash
   terraform apply
   ```

Después de unos segundos, verás que el Resource Group `rg-terraform-ejemplo` se crea en tu suscripción Azure.

---

> **Siguiente Paso:** Con estos cuatro subtemas (WSL, Git, Azure DevOps y Terraform) ya tienes tu ambiente totalmente preparado. En las siguientes secciones del curso profundizaremos en la escritura de código Terraform, creación de módulos, pipelines y buenas prácticas.
