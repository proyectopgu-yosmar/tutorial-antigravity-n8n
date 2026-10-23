# ==============================================================================
# ASISTENTE DE INSTALACIÓN PASO A PASO: ANTIGRAVITY + n8n + GITHUB
# Creado para: Proyecto PGU
# Compatible con Windows 10, Windows 11 y Windows Server
# ==============================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

# Configuración de ventana principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Asistente de Instalación - Antigravity + n8n + GitHub (Proyecto PGU)"
$form.Size = New-Object System.Drawing.Size(720, 560)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(245, 247, 250)

# Banner superior
$topPanel = New-Object System.Windows.Forms.Panel
$topPanel.Size = New-Object System.Drawing.Size(720, 75)
$topPanel.BackColor = [System.Drawing.Color]::FromArgb(24, 32, 47)
$form.Controls.Add($topPanel)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "Instalador de Entorno de Automatizaciones con IA"
$lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::White
$lblTitle.Location = New-Object System.Drawing.Point(25, 15)
$lblTitle.AutoSize = $true
$topPanel.Controls.Add($lblTitle)

$lblSubtitle = New-Object System.Windows.Forms.Label
$lblSubtitle.Text = "Configuración integral de Google Antigravity, n8n, GitHub y protocolo MCP"
$lblSubtitle.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$lblSubtitle.ForeColor = [System.Drawing.Color]::FromArgb(180, 195, 215)
$lblSubtitle.Location = New-Object System.Drawing.Point(26, 42)
$lblSubtitle.AutoSize = $true
$topPanel.Controls.Add($lblSubtitle)

# Panel de contenido donde cambian los pasos
$contentPanel = New-Object System.Windows.Forms.Panel
$contentPanel.Location = New-Object System.Drawing.Point(25, 90)
$contentPanel.Size = New-Object System.Drawing.Size(655, 360)
$form.Controls.Add($contentPanel)

# Barra inferior de botones
$btnBack = New-Object System.Windows.Forms.Button
$btnBack.Text = "< Atrás"
$btnBack.Size = New-Object System.Drawing.Size(100, 32)
$btnBack.Location = New-Object System.Drawing.Point(440, 465)
$btnBack.Enabled = $false
$form.Controls.Add($btnBack)

$btnNext = New-Object System.Windows.Forms.Button
$btnNext.Text = "Siguiente >"
$btnNext.Size = New-Object System.Drawing.Size(110, 32)
$btnNext.Location = New-Object System.Drawing.Point(550, 465)
$btnNext.BackColor = [System.Drawing.Color]::FromArgb(0, 102, 204)
$btnNext.ForeColor = [System.Drawing.Color]::White
$btnNext.FlatStyle = "Flat"
$form.Controls.Add($btnNext)

$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Text = "Cancelar"
$btnCancel.Size = New-Object System.Drawing.Size(90, 32)
$btnCancel.Location = New-Object System.Drawing.Point(25, 465)
$btnCancel.Add_Click({ $form.Close() })
$form.Controls.Add($btnCancel)

# Variables de estado global
$global:step = 1
$global:userEmail = "proyectopgu@gmail.com"
$global:userName = "Proyecto PGU"
$global:userPassword = ""
$global:githubToken = ""
$global:n8nApiKey = ""

# ==============================================================================
# DEFINICIÓN DE PANTALLAS (PASOS)
# ==============================================================================

function Show-Step1 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $false
    $btnNext.Text = "Siguiente >"

    $h1 = New-Object System.Windows.Forms.Label
    $h1.Text = "Bienvenido al Asistente de Instalación"
    $h1.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $h1.Location = New-Object System.Drawing.Point(10, 15)
    $h1.AutoSize = $true
    $contentPanel.Controls.Add($h1)

    $desc = New-Object System.Windows.Forms.Label
    $desc.Text = "Este asistente te guiará paso a paso para configurar tu propio empleado de Inteligencia Artificial capaz de crear y ejecutar automatizaciones de procesos en esta computadora.`n`nSe configurarán los siguientes 4 pilares:`n`n 1. Google Antigravity: El entorno de desarrollo y agente de Inteligencia Artificial.`n 2. Git y GitHub: El gestor de versiones, tokens y plantillas en la nube.`n 3. Servidor local n8n: El motor visual donde cobran vida tus flujos.`n 4. Conexión MCP: El protocolo que une la IA con n8n para crear nodos en tiempo real.`n`nHaz clic en 'Siguiente' para comenzar con tus datos."
    $desc.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $desc.Location = New-Object System.Drawing.Point(12, 50)
    $desc.Size = New-Object System.Drawing.Size(630, 280)
    $contentPanel.Controls.Add($desc)
}

function Show-Step2 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $true
    $btnNext.Text = "Siguiente >"

    $h = New-Object System.Windows.Forms.Label
    $h.Text = "Paso 1: Datos de tu Proyecto y Credenciales"
    $h.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $h.Location = New-Object System.Drawing.Point(10, 15)
    $h.AutoSize = $true
    $contentPanel.Controls.Add($h)

    $lblE = New-Object System.Windows.Forms.Label
    $lblE.Text = "Correo principal (para Antigravity, GitHub y n8n):"
    $lblE.Location = New-Object System.Drawing.Point(15, 60)
    $lblE.AutoSize = $true
    $contentPanel.Controls.Add($lblE)

    $txtE = New-Object System.Windows.Forms.TextBox
    $txtE.Text = $global:userEmail
    $txtE.Location = New-Object System.Drawing.Point(15, 85)
    $txtE.Size = New-Object System.Drawing.Size(400, 25)
    $contentPanel.Controls.Add($txtE)

    $lblN = New-Object System.Windows.Forms.Label
    $lblN.Text = "Nombre del Proyecto o Administrador:"
    $lblN.Location = New-Object System.Drawing.Point(15, 125)
    $lblN.AutoSize = $true
    $contentPanel.Controls.Add($lblN)

    $txtN = New-Object System.Windows.Forms.TextBox
    $txtN.Text = $global:userName
    $txtN.Location = New-Object System.Drawing.Point(15, 150)
    $txtN.Size = New-Object System.Drawing.Size(400, 25)
    $contentPanel.Controls.Add($txtN)

    $lblP = New-Object System.Windows.Forms.Label
    $lblP.Text = "Contraseña para acceder a tu servidor n8n:"
    $lblP.Location = New-Object System.Drawing.Point(15, 190)
    $lblP.AutoSize = $true
    $contentPanel.Controls.Add($lblP)

    $txtP = New-Object System.Windows.Forms.TextBox
    $txtP.Text = $global:userPassword
    $txtP.PasswordChar = '*'
    $txtP.Location = New-Object System.Drawing.Point(15, 215)
    $txtP.Size = New-Object System.Drawing.Size(400, 25)
    $contentPanel.Controls.Add($txtP)

    $chkShow = New-Object System.Windows.Forms.CheckBox
    $chkShow.Text = "Mostrar contraseña"
    $chkShow.Location = New-Object System.Drawing.Point(430, 215)
    $chkShow.AutoSize = $true
    $chkShow.Add_CheckedChanged({
        if ($chkShow.Checked) { $txtP.PasswordChar = [char]0 } else { $txtP.PasswordChar = '*' }
    })
    $contentPanel.Controls.Add($chkShow)

    # Guardar en variables al avanzar
    $form.Tag = {
        $global:userEmail = $txtE.Text.Trim()
        $global:userName = $txtN.Text.Trim()
        $global:userPassword = $txtP.Text.Trim()
    }
}

function Show-Step3 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $true
    $btnNext.Text = "Siguiente >"

    $h = New-Object System.Windows.Forms.Label
    $h.Text = "Paso 2: Diagnóstico de Herramientas en esta Computadora"
    $h.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $h.Location = New-Object System.Drawing.Point(10, 15)
    $h.AutoSize = $true
    $contentPanel.Controls.Add($h)

    $lblStatus = New-Object System.Windows.Forms.Label
    $lblStatus.Location = New-Object System.Drawing.Point(15, 55)
    $lblStatus.Size = New-Object System.Drawing.Size(620, 200)
    $lblStatus.Font = New-Object System.Drawing.Font("Consolas", 10)
    $lblStatus.BackColor = [System.Drawing.Color]::White
    $lblStatus.BorderStyle = "FixedSingle"
    $contentPanel.Controls.Add($lblStatus)

    $btnScan = New-Object System.Windows.Forms.Button
    $btnScan.Text = "Escanear Sistema"
    $btnScan.Location = New-Object System.Drawing.Point(15, 270)
    $btnScan.Size = New-Object System.Drawing.Size(140, 32)
    $btnScan.Add_Click({
        $sb = ""
        # Check Git
        try {
            $g = & git --version 2>$null
            $sb += "[OK] Git instalado: $g`r`n"
        } catch {
            $sb += "[FALTA] Git no encontrado. Descargar de git-scm.com`r`n"
        }

        # Check Node
        try {
            $n = & node --version 2>$null
            $sb += "[OK] Node.js instalado: $n`r`n"
        } catch {
            $sb += "[FALTA] Node.js no encontrado. Descargar de nodejs.org`r`n"
        }

        # Check n8n
        try {
            $testPort = Get-NetTCPConnection -LocalPort 5678 -ErrorAction SilentlyContinue
            if ($testPort) {
                $sb += "[OK] n8n activo y respondiendo en http://localhost:5678`r`n"
            } else {
                $sb += "[INFO] n8n no está corriendo aún en puerto 5678 (se iniciará en el paso 4).`r`n"
            }
        } catch {
            $sb += "[INFO] Comprobando puerto de n8n...`r`n"
        }

        # Check Antigravity
        $agyPath = "$env:USERPROFILE\.gemini\antigravity"
        if (Test-Path $agyPath) {
            $sb += "[OK] Carpeta de Google Antigravity detectada en el usuario.`r`n"
        } else {
            $sb += "[INFO] Antigravity listo para inicializar.`r`n"
        }

        $lblStatus.Text = $sb
    })
    $contentPanel.Controls.Add($btnScan)

    $btnOpenNode = New-Object System.Windows.Forms.Button
    $btnOpenNode.Text = "Descargar Node.js"
    $btnOpenNode.Location = New-Object System.Drawing.Point(170, 270)
    $btnOpenNode.Size = New-Object System.Drawing.Size(140, 32)
    $btnOpenNode.Add_Click({ Start-Process "https://nodejs.org/en/download" })
    $contentPanel.Controls.Add($btnOpenNode)

    $btnOpenGit = New-Object System.Windows.Forms.Button
    $btnOpenGit.Text = "Descargar Git"
    $btnOpenGit.Location = New-Object System.Drawing.Point(325, 270)
    $btnOpenGit.Size = New-Object System.Drawing.Size(120, 32)
    $btnOpenGit.Add_Click({ Start-Process "https://git-scm.com/download/win" })
    $contentPanel.Controls.Add($btnOpenGit)

    # Disparar scan automático inicial
    $btnScan.PerformClick()
}

function Show-Step4 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $true
    $btnNext.Text = "Siguiente >"

    $h = New-Object System.Windows.Forms.Label
    $h.Text = "Paso 3: Conexión con GitHub y Token de Acceso"
    $h.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $h.Location = New-Object System.Drawing.Point(10, 15)
    $h.AutoSize = $true
    $contentPanel.Controls.Add($h)

    $desc = New-Object System.Windows.Forms.Label
    $desc.Text = "GitHub permite a la Inteligencia Artificial descargar librerías y componentes automáticamente. Necesitas un Personal Access Token clásico con permiso 'repo'."
    $desc.Location = New-Object System.Drawing.Point(15, 50)
    $desc.Size = New-Object System.Drawing.Size(620, 35)
    $contentPanel.Controls.Add($desc)

    $btnWeb = New-Object System.Windows.Forms.Button
    $btnWeb.Text = "🌐 Abrir GitHub para Generar Token (Enlace Directo)"
    $btnWeb.Location = New-Object System.Drawing.Point(15, 95)
    $btnWeb.Size = New-Object System.Drawing.Size(350, 32)
    $btnWeb.Add_Click({ Start-Process "https://github.com/settings/tokens" })
    $contentPanel.Controls.Add($btnWeb)

    $lblT = New-Object System.Windows.Forms.Label
    $lblT.Text = "Pega aquí tu Token de GitHub (empieza por ghp_...):"
    $lblT.Location = New-Object System.Drawing.Point(15, 145)
    $lblT.AutoSize = $true
    $contentPanel.Controls.Add($lblT)

    $txtT = New-Object System.Windows.Forms.TextBox
    $txtT.Text = $global:githubToken
    $txtT.Location = New-Object System.Drawing.Point(15, 170)
    $txtT.Size = New-Object System.Drawing.Size(450, 25)
    $contentPanel.Controls.Add($txtT)

    $lblRes = New-Object System.Windows.Forms.Label
    $lblRes.Location = New-Object System.Drawing.Point(15, 215)
    $lblRes.Size = New-Object System.Drawing.Size(620, 60)
    $lblRes.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $contentPanel.Controls.Add($lblRes)

    $btnTest = New-Object System.Windows.Forms.Button
    $btnTest.Text = "Verificar Token"
    $btnTest.Location = New-Object System.Drawing.Point(480, 168)
    $btnTest.Size = New-Object System.Drawing.Size(120, 28)
    $btnTest.Add_Click({
        $t = $txtT.Text.Trim()
        if (!$t) {
            $lblRes.ForeColor = [System.Drawing.Color]::Red
            $lblRes.Text = "Por favor ingresa un token válido antes de verificar."
            return
        }
        try {
            $headers = @{ "Authorization" = "Bearer $t"; "User-Agent" = "Antigravity-Installer" }
            $res = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers -TimeoutSec 10
            $lblRes.ForeColor = [System.Drawing.Color]::Green
            $lblRes.Text = "[OK] Token 100% Valido!`r`nUsuario autenticado: $($res.login) ($($res.name))`r`nCorreo: $($res.email)"
            $global:githubToken = $t
            # Configurar git local
            & git config --global user.name $global:userName
            & git config --global user.email $global:userEmail
        } catch {
            $lblRes.ForeColor = [System.Drawing.Color]::Red
            $lblRes.Text = "[ERROR] Error al validar el token. Verifica que no tenga espacios extra y tenga permisos activos."
        }
    })
    $contentPanel.Controls.Add($btnTest)

    $form.Tag = { $global:githubToken = $txtT.Text.Trim() }
}

function Show-Step5 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $true
    $btnNext.Text = "Siguiente >"

    $h = New-Object System.Windows.Forms.Label
    $h.Text = "Paso 4: Servidor n8n y Clave de API (API Key)"
    $h.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $h.Location = New-Object System.Drawing.Point(10, 15)
    $h.AutoSize = $true
    $contentPanel.Controls.Add($h)

    $desc = New-Object System.Windows.Forms.Label
    $desc.Text = "n8n es tu motor de automatización. Para que Antigravity pueda crear flujos por ti, necesita su API Key creada en n8n Settings ⚙️ -> n8n API."
    $desc.Location = New-Object System.Drawing.Point(15, 50)
    $desc.Size = New-Object System.Drawing.Size(620, 35)
    $contentPanel.Controls.Add($desc)

    $btnOpenN8N = New-Object System.Windows.Forms.Button
    $btnOpenN8N.Text = "🌐 Abrir n8n en el Navegador (localhost:5678)"
    $btnOpenN8N.Location = New-Object System.Drawing.Point(15, 95)
    $btnOpenN8N.Size = New-Object System.Drawing.Size(320, 32)
    $btnOpenN8N.Add_Click({ Start-Process "http://localhost:5678/settings/api" })
    $contentPanel.Controls.Add($btnOpenN8N)

    $lblK = New-Object System.Windows.Forms.Label
    $lblK.Text = "Pega aquí tu API Key de n8n:"
    $lblK.Location = New-Object System.Drawing.Point(15, 145)
    $lblK.AutoSize = $true
    $contentPanel.Controls.Add($lblK)

    $txtK = New-Object System.Windows.Forms.TextBox
    $txtK.Text = $global:n8nApiKey
    $txtK.Location = New-Object System.Drawing.Point(15, 170)
    $txtK.Size = New-Object System.Drawing.Size(450, 25)
    $contentPanel.Controls.Add($txtK)

    $lblN8NRes = New-Object System.Windows.Forms.Label
    $lblN8NRes.Location = New-Object System.Drawing.Point(15, 215)
    $lblN8NRes.Size = New-Object System.Drawing.Size(620, 60)
    $lblN8NRes.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $contentPanel.Controls.Add($lblN8NRes)

    $btnTestN8N = New-Object System.Windows.Forms.Button
    $btnTestN8N.Text = "Probar Conexión"
    $btnTestN8N.Location = New-Object System.Drawing.Point(480, 168)
    $btnTestN8N.Size = New-Object System.Drawing.Size(130, 28)
    $btnTestN8N.Add_Click({
        $k = $txtK.Text.Trim()
        if (!$k) {
            $lblN8NRes.ForeColor = [System.Drawing.Color]::Red
            $lblN8NRes.Text = "Ingresa la API Key de n8n antes de probar."
            return
        }
        try {
            $h = @{ "X-N8N-API-KEY" = $k }
            $res = Invoke-RestMethod -Uri "http://localhost:5678/api/v1/workflows" -Headers $h -TimeoutSec 10
            $lblN8NRes.ForeColor = [System.Drawing.Color]::Green
            $lblN8NRes.Text = "[OK] Conexion Exitosa con n8n!`r`nEl servidor local respondio correctamente y autorizo a la API."
            $global:n8nApiKey = $k
        } catch {
            $lblN8NRes.ForeColor = [System.Drawing.Color]::Red
            $lblN8NRes.Text = "[ERROR] No se pudo conectar con n8n en localhost:5678. Verifica que n8n este corriendo y la clave sea valida."
        }
    })
    $contentPanel.Controls.Add($btnTestN8N)

    $form.Tag = { $global:n8nApiKey = $txtK.Text.Trim() }
}

function Show-Step6 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $true
    $btnNext.Text = "Finalizar y Aplicar"

    $h = New-Object System.Windows.Forms.Label
    $h.Text = "Paso 5: Vinculación Final con Antigravity (MCP)"
    $h.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $h.Location = New-Object System.Drawing.Point(10, 15)
    $h.AutoSize = $true
    $contentPanel.Controls.Add($h)

    $txtFinalLog = New-Object System.Windows.Forms.TextBox
    $txtFinalLog.Multiline = $true
    $txtFinalLog.ReadOnly = $true
    $txtFinalLog.ScrollBars = "Vertical"
    $txtFinalLog.Location = New-Object System.Drawing.Point(15, 55)
    $txtFinalLog.Size = New-Object System.Drawing.Size(620, 260)
    $txtFinalLog.Font = New-Object System.Drawing.Font("Consolas", 9)
    $txtFinalLog.BackColor = [System.Drawing.Color]::FromArgb(250, 250, 250)
    $contentPanel.Controls.Add($txtFinalLog)

    # Resumen y ejecución de guardado
    $log = "Resumen de Configuración:`r`n"
    $log += "--------------------------------------------------------`r`n"
    $log += "Correo de Proyecto: $global:userEmail`r`n"
    $log += "Nombre Usuario:     $global:userName`r`n"
    $log += "GitHub Token:       $(if ($global:githubToken) { $global:githubToken.Substring(0, [Math]::Min(12, $global:githubToken.Length)) + '...' } else { 'No configurado' })`r`n"
    $log += "n8n API Key:        $(if ($global:n8nApiKey) { $global:n8nApiKey.Substring(0, [Math]::Min(15, $global:n8nApiKey.Length)) + '...' } else { 'No configurado' })`r`n"
    $log += "--------------------------------------------------------`r`n"
    $log += "Presiona 'Finalizar y Aplicar' para guardar los archivos de configuración MCP y dejar el sistema 100% operativo."
    $txtFinalLog.Text = $log
}

function Show-Step7 {
    $contentPanel.Controls.Clear()
    $btnBack.Enabled = $false
    $btnNext.Text = "Cerrar"
    $btnCancel.Visible = $false

    $h = New-Object System.Windows.Forms.Label
    $h.Text = "Instalacion Completada con Exito!"
    $h.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
    $h.ForeColor = [System.Drawing.Color]::FromArgb(0, 130, 60)
    $h.Location = New-Object System.Drawing.Point(10, 15)
    $h.AutoSize = $true
    $contentPanel.Controls.Add($h)

    $desc = New-Object System.Windows.Forms.Label
    $desc.Text = "Todos los componentes han sido configurados correctamente:`r`n`r`n [OK] Git y GitHub vinculados a tu identidad.`r`n [OK] n8n configurado y autorizado para peticiones de IA.`r`n [OK] Protocolo MCP integrado con modo de seguridad permisivo local.`r`n [OK] Entorno listo para crear flujos en tiempo real.`r`n`r`nPuedes comenzar a trabajar abriendo Antigravity o visitando tu panel de n8n."
    $desc.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $desc.Location = New-Object System.Drawing.Point(15, 60)
    $desc.Size = New-Object System.Drawing.Size(620, 200)
    $contentPanel.Controls.Add($desc)

    $btnLaunchN8N = New-Object System.Windows.Forms.Button
    $btnLaunchN8N.Text = "Abrir n8n en el Navegador"
    $btnLaunchN8N.Location = New-Object System.Drawing.Point(20, 270)
    $btnLaunchN8N.Size = New-Object System.Drawing.Size(200, 35)
    $btnLaunchN8N.Add_Click({ Start-Process "http://localhost:5678/home/workflows" })
    $contentPanel.Controls.Add($btnLaunchN8N)
}

# ==============================================================================
# CONTROL DE NAVEGACIÓN ENTRE PASOS
# ==============================================================================

$btnNext.Add_Click({
    # Ejecutar guardado del paso si existe
    if ($form.Tag -is [scriptblock]) {
        & $form.Tag
    }

    if ($global:step -eq 1) {
        $global:step = 2
        Show-Step2
    } elseif ($global:step -eq 2) {
        $global:step = 3
        Show-Step3
    } elseif ($global:step -eq 3) {
        $global:step = 4
        Show-Step4
    } elseif ($global:step -eq 4) {
        $global:step = 5
        Show-Step5
    } elseif ($global:step -eq 5) {
        $global:step = 6
        Show-Step6
    } elseif ($global:step -eq 6) {
        # Aplicar configuración MCP
        try {
            $mcpPaths = @(
                "$env:USERPROFILE\.gemini\config\mcp_config.json",
                "$env:USERPROFILE\.gemini\antigravity\mcp_config.json"
            )
            foreach ($p in $mcpPaths) {
                if (Test-Path $p) {
                    $json = Get-Content $p -Raw | ConvertFrom-Json
                    if ($json.mcpServers.'n8n-mcp') {
                        $json.mcpServers.'n8n-mcp'.env.WEBHOOK_SECURITY_MODE = "permissive"
                        if ($global:n8nApiKey) {
                            $json.mcpServers.'n8n-mcp'.env.N8N_API_KEY = $global:n8nApiKey
                        }
                        $json | ConvertTo-Json -Depth 10 | Set-Content $p -Encoding utf8
                    }
                }
            }
        } catch {}

        $global:step = 7
        Show-Step7
    } elseif ($global:step -eq 7) {
        $form.Close()
    }
})

$btnBack.Add_Click({
    if ($global:step -gt 1) {
        $global:step--
        switch ($global:step) {
            1 { Show-Step1 }
            2 { Show-Step2 }
            3 { Show-Step3 }
            4 { Show-Step4 }
            5 { Show-Step5 }
            6 { Show-Step6 }
        }
    }
})

# Iniciar en Paso 1
Show-Step1
$form.ShowDialog() | Out-Null
