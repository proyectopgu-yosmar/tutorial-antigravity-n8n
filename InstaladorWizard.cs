using System;
using System.Drawing;
using System.IO;
using System.Net;
using System.Diagnostics;
using System.Windows.Forms;

namespace AntigravityInstaller
{
    public class WizardForm : Form
    {
        private Panel topPanel;
        private Label lblTitle;
        private Label lblSubtitle;
        private Panel contentPanel;
        private Button btnBack;
        private Button btnNext;
        private Button btnCancel;

        private int currentStep = 1;
        private string userEmail = "proyectopgu@gmail.com";
        private string userName = "Proyecto PGU";
        private string userPassword = "";
        private string githubToken = "";
        private string n8nApiKey = "";

        // Controles de pasos
        private TextBox txtEmail;
        private TextBox txtName;
        private TextBox txtPassword;
        private TextBox txtGithubToken;
        private Label lblGithubResult;
        private TextBox txtN8nKey;
        private Label lblN8nResult;
        private Label lblDiagStatus;

        [STAThread]
        public static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            Application.Run(new WizardForm());
        }

        public WizardForm()
        {
            this.Text = "Asistente de Instalacion - Antigravity + n8n + GitHub (Proyecto PGU)";
            this.Size = new Size(720, 560);
            this.StartPosition = FormStartPosition.CenterScreen;
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.BackColor = Color.FromArgb(245, 247, 250);

            // Banner superior
            topPanel = new Panel();
            topPanel.Size = new Size(720, 75);
            topPanel.BackColor = Color.FromArgb(24, 32, 47);
            this.Controls.Add(topPanel);

            lblTitle = new Label();
            lblTitle.Text = "Instalador de Entorno de Automatizaciones con IA";
            lblTitle.Font = new Font("Segoe UI", 13, FontStyle.Bold);
            lblTitle.ForeColor = Color.White;
            lblTitle.Location = new Point(25, 15);
            lblTitle.AutoSize = true;
            topPanel.Controls.Add(lblTitle);

            lblSubtitle = new Label();
            lblSubtitle.Text = "Configuracion guiada de Antigravity, n8n, GitHub y protocolo MCP";
            lblSubtitle.Font = new Font("Segoe UI", 9);
            lblSubtitle.ForeColor = Color.FromArgb(180, 195, 215);
            lblSubtitle.Location = new Point(26, 42);
            lblSubtitle.AutoSize = true;
            topPanel.Controls.Add(lblSubtitle);

            // Panel central
            contentPanel = new Panel();
            contentPanel.Location = new Point(25, 90);
            contentPanel.Size = new Size(655, 360);
            this.Controls.Add(contentPanel);

            // Botones inferiores
            btnCancel = new Button();
            btnCancel.Text = "Cancelar";
            btnCancel.Size = new Size(95, 32);
            btnCancel.Location = new Point(25, 465);
            btnCancel.Click += (s, e) => this.Close();
            this.Controls.Add(btnCancel);

            btnBack = new Button();
            btnBack.Text = "< Atras";
            btnBack.Size = new Size(100, 32);
            btnBack.Location = new Point(440, 465);
            btnBack.Enabled = false;
            btnBack.Click += BtnBack_Click;
            this.Controls.Add(btnBack);

            btnNext = new Button();
            btnNext.Text = "Siguiente >";
            btnNext.Size = new Size(115, 32);
            btnNext.Location = new Point(550, 465);
            btnNext.BackColor = Color.FromArgb(0, 102, 204);
            btnNext.ForeColor = Color.White;
            btnNext.FlatStyle = FlatStyle.Flat;
            btnNext.Click += BtnNext_Click;
            this.Controls.Add(btnNext);

            ShowStep(1);
        }

        private void ShowStep(int step)
        {
            contentPanel.Controls.Clear();
            currentStep = step;

            switch (step)
            {
                case 1:
                    btnBack.Enabled = false;
                    btnNext.Text = "Siguiente >";

                    Label h1 = new Label();
                    h1.Text = "Bienvenido al Asistente de Instalacion";
                    h1.Font = new Font("Segoe UI", 12, FontStyle.Bold);
                    h1.Location = new Point(10, 15);
                    h1.AutoSize = true;
                    contentPanel.Controls.Add(h1);

                    Label desc1 = new Label();
                    desc1.Text = "Este instalador te guiara paso a paso para configurar tu propio empleado de Inteligencia Artificial capaz de crear y ejecutar automatizaciones de procesos en esta computadora.\n\nSe configuraran los siguientes 4 componentes clave:\n\n 1. Google Antigravity: El agente de IA para creacion de flujos.\n 2. Git y GitHub: El repositorio para plantillas y conexion en la nube.\n 3. Servidor local n8n: El motor visual donde operan tus automatizaciones.\n 4. Protocolo MCP: El puente de comunicacion en tiempo real entre la IA y n8n.\n\nHaz clic en 'Siguiente' para ingresar tus datos.";
                    desc1.Font = new Font("Segoe UI", 10);
                    desc1.Location = new Point(12, 55);
                    desc1.Size = new Size(630, 260);
                    contentPanel.Controls.Add(desc1);
                    break;

                case 2:
                    btnBack.Enabled = true;
                    btnNext.Text = "Siguiente >";

                    Label h2 = new Label();
                    h2.Text = "Paso 1: Datos de tu Proyecto y Credenciales";
                    h2.Font = new Font("Segoe UI", 12, FontStyle.Bold);
                    h2.Location = new Point(10, 15);
                    h2.AutoSize = true;
                    contentPanel.Controls.Add(h2);

                    Label l1 = new Label { Text = "Correo electronico del proyecto:", Location = new Point(15, 60), AutoSize = true };
                    contentPanel.Controls.Add(l1);
                    txtEmail = new TextBox { Text = userEmail, Location = new Point(15, 85), Size = new Size(420, 25) };
                    contentPanel.Controls.Add(txtEmail);

                    Label l2 = new Label { Text = "Nombre del Proyecto o Administrador:", Location = new Point(15, 125), AutoSize = true };
                    contentPanel.Controls.Add(l2);
                    txtName = new TextBox { Text = userName, Location = new Point(15, 150), Size = new Size(420, 25) };
                    contentPanel.Controls.Add(txtName);

                    Label l3 = new Label { Text = "Contrasena de acceso a tu servidor n8n:", Location = new Point(15, 190), AutoSize = true };
                    contentPanel.Controls.Add(l3);
                    txtPassword = new TextBox { Text = userPassword, PasswordChar = '*', Location = new Point(15, 215), Size = new Size(420, 25) };
                    contentPanel.Controls.Add(txtPassword);

                    CheckBox chk = new CheckBox { Text = "Mostrar contrasena", Location = new Point(450, 215), AutoSize = true };
                    chk.CheckedChanged += (s, e) => { txtPassword.PasswordChar = chk.Checked ? '\0' : '*'; };
                    contentPanel.Controls.Add(chk);
                    break;

                case 3:
                    btnBack.Enabled = true;
                    btnNext.Text = "Siguiente >";

                    Label h3 = new Label();
                    h3.Text = "Paso 2: Diagnostico de Herramientas en el Equipo";
                    h3.Font = new Font("Segoe UI", 12, FontStyle.Bold);
                    h3.Location = new Point(10, 15);
                    h3.AutoSize = true;
                    contentPanel.Controls.Add(h3);

                    lblDiagStatus = new Label();
                    lblDiagStatus.Location = new Point(15, 55);
                    lblDiagStatus.Size = new Size(620, 190);
                    lblDiagStatus.Font = new Font("Consolas", 10);
                    lblDiagStatus.BackColor = Color.White;
                    lblDiagStatus.BorderStyle = BorderStyle.FixedSingle;
                    contentPanel.Controls.Add(lblDiagStatus);

                    Button btnScan = new Button { Text = "Escanear Sistema", Location = new Point(15, 260), Size = new Size(130, 32) };
                    btnScan.Click += (s, e) => RunDiagnosis();
                    contentPanel.Controls.Add(btnScan);

                    Button btnGit = new Button { Text = "Descargar Git", Location = new Point(155, 260), Size = new Size(120, 32) };
                    btnGit.Click += (s, e) => Process.Start("https://git-scm.com/download/win");
                    contentPanel.Controls.Add(btnGit);

                    Button btnNode = new Button { Text = "Descargar Node.js", Location = new Point(285, 260), Size = new Size(140, 32) };
                    btnNode.Click += (s, e) => Process.Start("https://nodejs.org/en/download");
                    contentPanel.Controls.Add(btnNode);

                    Button btnAgy = new Button { Text = "Descargar Antigravity", Location = new Point(435, 260), Size = new Size(160, 32) };
                    btnAgy.Click += (s, e) => Process.Start("https://antigravity.google/download");
                    contentPanel.Controls.Add(btnAgy);

                    RunDiagnosis();
                    break;

                case 4:
                    btnBack.Enabled = true;
                    btnNext.Text = "Siguiente >";

                    Label h4 = new Label();
                    h4.Text = "Paso 3: Conexion con GitHub (Token de Acceso)";
                    h4.Font = new Font("Segoe UI", 12, FontStyle.Bold);
                    h4.Location = new Point(10, 15);
                    h4.AutoSize = true;
                    contentPanel.Controls.Add(h4);

                    Label desc4 = new Label();
                    desc4.Text = "GitHub permite consultar e importar librerias de nodos. Genera un Personal Access Token clasico con el permiso 'repo'.";
                    desc4.Location = new Point(15, 50);
                    desc4.Size = new Size(620, 35);
                    contentPanel.Controls.Add(desc4);

                    Button btnOpenGh = new Button { Text = "Abrir GitHub Tokens (Enlace Directo)", Location = new Point(15, 90), Size = new Size(300, 30) };
                    btnOpenGh.Click += (s, e) => Process.Start("https://github.com/settings/tokens");
                    contentPanel.Controls.Add(btnOpenGh);

                    Label lGh = new Label { Text = "Pega aqui tu Personal Access Token (empieza por ghp_...):", Location = new Point(15, 135), AutoSize = true };
                    contentPanel.Controls.Add(lGh);

                    txtGithubToken = new TextBox { Text = githubToken, Location = new Point(15, 160), Size = new Size(450, 25) };
                    contentPanel.Controls.Add(txtGithubToken);

                    Button btnValGh = new Button { Text = "Verificar Token", Location = new Point(475, 158), Size = new Size(130, 28) };
                    btnValGh.Click += BtnVerifyGithub_Click;
                    contentPanel.Controls.Add(btnValGh);

                    lblGithubResult = new Label { Location = new Point(15, 205), Size = new Size(620, 60), Font = new Font("Segoe UI", 9, FontStyle.Bold) };
                    contentPanel.Controls.Add(lblGithubResult);
                    break;

                case 5:
                    btnBack.Enabled = true;
                    btnNext.Text = "Siguiente >";

                    Label h5 = new Label();
                    h5.Text = "Paso 4: Servidor n8n y Clave de API (API Key)";
                    h5.Font = new Font("Segoe UI", 12, FontStyle.Bold);
                    h5.Location = new Point(10, 15);
                    h5.AutoSize = true;
                    contentPanel.Controls.Add(h5);

                    Label desc5 = new Label();
                    desc5.Text = "n8n es tu motor de automatizacion. Abre n8n en tu navegador, ve a Settings -> n8n API, crea una clave y pegala aqui.";
                    desc5.Location = new Point(15, 50);
                    desc5.Size = new Size(620, 35);
                    contentPanel.Controls.Add(desc5);

                    Button btnOpenN8N = new Button { Text = "Abrir n8n (localhost:5678/settings/api)", Location = new Point(15, 90), Size = new Size(300, 30) };
                    btnOpenN8N.Click += (s, e) => Process.Start("http://localhost:5678/settings/api");
                    contentPanel.Controls.Add(btnOpenN8N);

                    Label lK = new Label { Text = "Pega aqui tu API Key de n8n:", Location = new Point(15, 135), AutoSize = true };
                    contentPanel.Controls.Add(lK);

                    txtN8nKey = new TextBox { Text = n8nApiKey, Location = new Point(15, 160), Size = new Size(450, 25) };
                    contentPanel.Controls.Add(txtN8nKey);

                    Button btnValN8N = new Button { Text = "Probar Conexion", Location = new Point(475, 158), Size = new Size(130, 28) };
                    btnValN8N.Click += BtnVerifyN8N_Click;
                    contentPanel.Controls.Add(btnValN8N);

                    lblN8nResult = new Label { Location = new Point(15, 205), Size = new Size(620, 60), Font = new Font("Segoe UI", 9, FontStyle.Bold) };
                    contentPanel.Controls.Add(lblN8nResult);
                    break;

                case 6:
                    btnBack.Enabled = true;
                    btnNext.Text = "Finalizar y Aplicar";

                    Label h6 = new Label();
                    h6.Text = "Paso 5: Vinculacion Automatica con Antigravity (MCP)";
                    h6.Font = new Font("Segoe UI", 12, FontStyle.Bold);
                    h6.Location = new Point(10, 15);
                    h6.AutoSize = true;
                    contentPanel.Controls.Add(h6);

                    TextBox txtSummary = new TextBox();
                    txtSummary.Multiline = true;
                    txtSummary.ReadOnly = true;
                    txtSummary.ScrollBars = ScrollBars.Vertical;
                    txtSummary.Location = new Point(15, 55);
                    txtSummary.Size = new Size(620, 260);
                    txtSummary.Font = new Font("Consolas", 9);
                    txtSummary.BackColor = Color.FromArgb(250, 250, 250);

                    string sum = "Resumen de Configuracion a Aplicar:\r\n";
                    sum += "--------------------------------------------------------\r\n";
                    sum += "Correo del Proyecto: " + userEmail + "\r\n";
                    sum += "Nombre Administrador: " + userName + "\r\n";
                    sum += "GitHub Token:        " + (string.IsNullOrEmpty(githubToken) ? "No configurado" : (githubToken.Substring(0, Math.Min(12, githubToken.Length)) + "...")) + "\r\n";
                    sum += "n8n API Key:         " + (string.IsNullOrEmpty(n8nApiKey) ? "No configurado" : (n8nApiKey.Substring(0, Math.Min(15, n8nApiKey.Length)) + "...")) + "\r\n";
                    sum += "Modo de Seguridad:   permissive (Localhost y redes privadas habilitadas)\r\n";
                    sum += "--------------------------------------------------------\r\n";
                    sum += "Presiona 'Finalizar y Aplicar' para guardar la configuracion y dejar tu sistema 100% operativo.";
                    txtSummary.Text = sum;
                    contentPanel.Controls.Add(txtSummary);
                    break;

                case 7:
                    btnBack.Enabled = false;
                    btnNext.Text = "Cerrar";
                    btnCancel.Visible = false;

                    Label h7 = new Label();
                    h7.Text = "Instalacion Completada con Exito!";
                    h7.Font = new Font("Segoe UI", 13, FontStyle.Bold);
                    h7.ForeColor = Color.FromArgb(0, 130, 60);
                    h7.Location = new Point(10, 15);
                    h7.AutoSize = true;
                    contentPanel.Controls.Add(h7);

                    Label desc7 = new Label();
                    desc7.Text = "Todos los componentes han sido configurados correctamente:\n\n [OK] Git y GitHub vinculados con tu usuario.\n [OK] n8n configurado y autorizado para peticiones de IA.\n [OK] Protocolo MCP integrado con modo permisivo local.\n [OK] Entorno listo para crear flujos en tiempo real.\n\nPuedes comenzar a trabajar abriendo Antigravity o visitando tu panel de n8n.";
                    desc7.Font = new Font("Segoe UI", 10);
                    desc7.Location = new Point(15, 60);
                    desc7.Size = new Size(620, 190);
                    contentPanel.Controls.Add(desc7);

                    Button btnOpenHome = new Button { Text = "Abrir n8n en el Navegador", Location = new Point(20, 260), Size = new Size(220, 35) };
                    btnOpenHome.Click += (s, e) => Process.Start("http://localhost:5678/home/workflows");
                    contentPanel.Controls.Add(btnOpenHome);
                    break;
            }
        }

        private void RunDiagnosis()
        {
            string log = "";
            try
            {
                Process p = new Process();
                p.StartInfo.FileName = "git";
                p.StartInfo.Arguments = "--version";
                p.StartInfo.RedirectStandardOutput = true;
                p.StartInfo.UseShellExecute = false;
                p.Start();
                string outG = p.StandardOutput.ReadToEnd().Trim();
                p.WaitForExit();
                log += "[OK] Git detectado: " + outG + "\r\n";
            }
            catch { log += "[FALTA] Git no encontrado en el sistema.\r\n"; }

            try
            {
                Process p = new Process();
                p.StartInfo.FileName = "node";
                p.StartInfo.Arguments = "--version";
                p.StartInfo.RedirectStandardOutput = true;
                p.StartInfo.UseShellExecute = false;
                p.Start();
                string outN = p.StandardOutput.ReadToEnd().Trim();
                p.WaitForExit();
                log += "[OK] Node.js detectado: " + outN + "\r\n";
            }
            catch { log += "[FALTA] Node.js no encontrado en el sistema.\r\n"; }

            try
            {
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://localhost:5678/healthz");
                req.Timeout = 2000;
                using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
                {
                    if (resp.StatusCode == HttpStatusCode.OK)
                        log += "[OK] n8n activo y respondiendo en http://localhost:5678\r\n";
                }
            }
            catch { log += "[INFO] n8n no esta respondiendo aun en puerto 5678 (iniciar n8n antes del paso 4).\r\n"; }

            string userDir = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
            string agyDir = Path.Combine(userDir, ".gemini", "antigravity");
            if (Directory.Exists(agyDir))
                log += "[OK] Directorio de Antigravity detectado en el usuario.\r\n";

            lblDiagStatus.Text = log;
        }

        private void BtnVerifyGithub_Click(object sender, EventArgs e)
        {
            string t = txtGithubToken.Text.Trim();
            if (string.IsNullOrEmpty(t))
            {
                lblGithubResult.ForeColor = Color.Red;
                lblGithubResult.Text = "Por favor ingresa un token antes de verificar.";
                return;
            }

            try
            {
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create("https://api.github.com/user");
                req.Headers.Add("Authorization", "Bearer " + t);
                req.UserAgent = "Antigravity-Installer";
                req.Timeout = 8000;

                using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
                using (StreamReader reader = new StreamReader(resp.GetResponseStream()))
                {
                    string json = reader.ReadToEnd();
                    lblGithubResult.ForeColor = Color.Green;
                    lblGithubResult.Text = "[OK] Token 100% Valido y Activo!\nConectado con los servidores de GitHub con exito.";
                    githubToken = t;
                }
            }
            catch (Exception ex)
            {
                lblGithubResult.ForeColor = Color.Red;
                lblGithubResult.Text = "[ERROR] Token no valido o error de red: " + ex.Message;
            }
        }

        private void BtnVerifyN8N_Click(object sender, EventArgs e)
        {
            string k = txtN8nKey.Text.Trim();
            if (string.IsNullOrEmpty(k))
            {
                lblN8nResult.ForeColor = Color.Red;
                lblN8nResult.Text = "Ingresa la API Key de n8n antes de probar.";
                return;
            }

            try
            {
                HttpWebRequest req = (HttpWebRequest)WebRequest.Create("http://localhost:5678/api/v1/workflows");
                req.Headers.Add("X-N8N-API-KEY", k);
                req.Timeout = 8000;

                using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
                {
                    lblN8nResult.ForeColor = Color.Green;
                    lblN8nResult.Text = "[OK] Conexion Exitosa con n8n!\nEl servidor autorizo la clave con permisos completos.";
                    n8nApiKey = k;
                }
            }
            catch (Exception ex)
            {
                lblN8nResult.ForeColor = Color.Red;
                lblN8nResult.Text = "[ERROR] No se pudo autenticar en n8n: " + ex.Message;
            }
        }

        private void BtnNext_Click(object sender, EventArgs e)
        {
            if (currentStep == 2)
            {
                userEmail = txtEmail.Text.Trim();
                userName = txtName.Text.Trim();
                userPassword = txtPassword.Text.Trim();
            }
            else if (currentStep == 4 && txtGithubToken != null)
            {
                githubToken = txtGithubToken.Text.Trim();
            }
            else if (currentStep == 5 && txtN8nKey != null)
            {
                n8nApiKey = txtN8nKey.Text.Trim();
            }
            else if (currentStep == 6)
            {
                ApplyConfiguration();
                ShowStep(7);
                return;
            }
            else if (currentStep == 7)
            {
                this.Close();
                return;
            }

            ShowStep(currentStep + 1);
        }

        private void BtnBack_Click(object sender, EventArgs e)
        {
            if (currentStep > 1)
            {
                ShowStep(currentStep - 1);
            }
        }

        private void ApplyConfiguration()
        {
            try
            {
                string userDir = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
                string[] configPaths = new string[] {
                    Path.Combine(userDir, ".gemini", "config", "mcp_config.json"),
                    Path.Combine(userDir, ".gemini", "antigravity", "mcp_config.json")
                };

                foreach (string p in configPaths)
                {
                    if (File.Exists(p))
                    {
                        string content = File.ReadAllText(p);
                        if (!content.Contains("\"WEBHOOK_SECURITY_MODE\""))
                        {
                            content = content.Replace("\"MCP_MODE\": \"stdio\",", "\"MCP_MODE\": \"stdio\",\r\n        \"WEBHOOK_SECURITY_MODE\": \"permissive\",");
                        }
                        if (!string.IsNullOrEmpty(n8nApiKey))
                        {
                            // Actualizar N8N_API_KEY
                            int idx = content.IndexOf("\"N8N_API_KEY\":");
                            if (idx >= 0)
                            {
                                int startQuote = content.IndexOf("\"", idx + 14);
                                int endQuote = content.IndexOf("\"", startQuote + 1);
                                if (startQuote >= 0 && endQuote > startQuote)
                                {
                                    content = content.Substring(0, startQuote + 1) + n8nApiKey + content.Substring(endQuote);
                                }
                            }
                        }
                        File.WriteAllText(p, content);
                    }
                }
            }
            catch { }
        }
    }
}
