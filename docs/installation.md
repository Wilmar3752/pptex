# Installation Guide

## Requirements

| Tool | Minimum version | Notes |
|---|---|---|
| Docker | 20.10+ | Docker Desktop on macOS/Windows |
| Git | any | To clone the repo |
| Bash | 4.0+ | Already available on macOS/Linux; use Git Bash or WSL on Windows |

---

## macOS

### 1. Install Docker Desktop

Download from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
and follow the installer. Then start Docker Desktop from Applications.

Verify:
```bash
docker --version
# Docker version 24.x.x, ...
```

### 2. Clone pptex

```bash
git clone https://github.com/Wilmar3752/pptex.git ~/pptex
cd ~/pptex
chmod +x pptex
```

### 3. (Optional) Add pptex to your PATH

```bash
echo 'export PATH="$HOME/pptex:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

After this you can run `pptex` from any directory.

### 4. Build the image

```bash
pptex build
# or, if not in PATH:
./pptex build
```

---

## Linux (Ubuntu/Debian)

### 1. Install Docker Engine

```bash
# Remove old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# Install dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add the repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Run Docker without sudo (log out and back in after this)
sudo usermod -aG docker $USER
```

### 2. Clone pptex

```bash
git clone https://github.com/Wilmar3752/pptex.git ~/pptex
cd ~/pptex
chmod +x pptex
echo 'export PATH="$HOME/pptex:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Build

```bash
pptex build
```

---

## Windows

### Option A — Docker Desktop + WSL 2 (recommended)

1. Enable WSL 2:
   ```powershell
   wsl --install
   ```
   Restart your machine.

2. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop).
   In Settings → General, enable **Use the WSL 2 based engine**.

3. Open your WSL terminal (Ubuntu) and follow the **Linux** steps above.

### Option B — Docker Desktop + Git Bash

1. Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop).
2. Install [Git for Windows](https://git-scm.com/download/win) (includes Git Bash).
3. Open Git Bash:
   ```bash
   git clone https://github.com/Wilmar3752/pptex.git ~/pptex
   cd ~/pptex
   chmod +x pptex
   ./pptex build
   ```

---

## Verifying the Installation

```bash
./pptex build            # Should end with "Image built successfully."
./pptex new slides test  # Should create ./test/ directory
./pptex compile test/main.tex
# Should produce test/main.pdf
```

Open `test/main.pdf` — you should see a sample presentation.

---

## Updating the Image

To get the latest TeX Live packages, rebuild the image:

```bash
./pptex build
# or force a fresh pull:
docker build --no-cache -t pptex:latest .
```

---

## Troubleshooting

### `docker: command not found`
Docker is not installed or not in your PATH. Follow the installation steps for your OS above.

### `permission denied` when running `./pptex`
```bash
chmod +x pptex
```

### Build fails with network error
Your internet connection dropped mid-download. Run `./pptex build` again.

### `Cannot connect to the Docker daemon`
Docker Desktop is not running. Start it from your Applications menu (macOS/Windows)
or run `sudo systemctl start docker` (Linux).

### PDF not generated — compilation error
Run:
```bash
./pptex shell
# Inside the container:
cd my-project
xelatex main.tex
```
Read the full error output. Common causes:
- Missing `\end{document}`
- Typo in `\input{}` path
- Missing bibliography file

### Slow first compile
The first compile downloads nothing extra, but TeX Live font/package initialization takes
30–60 seconds on cold start. Subsequent compiles are fast (5–15 s).
