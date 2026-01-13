# RTL

# RTL (Verilog Practice Repository)

This repository contains my **RTL Verilog practice modules** along with **testbenches** for simulation.  
It includes common digital design blocks such as:

- Combinational circuits (MUX, Decoder, Encoder, Comparator, Adders, Subtractors)
- Sequential circuits (Flip-flops, Counters, Ring counters, Gray counters, Up/Down counters, etc.)
- Parameterized modules
- Simulation waveforms using **VCD** and **GTKWave**

The goal of this repo is to build strong fundamentals in **Verilog RTL design + testbench writing**.

---

---

## 🛠 Requirements

You need the following tools installed:

### ✅ 1) Icarus Verilog (iverilog)
Used to compile Verilog code.

### ✅ 2) GTKWave
Used to open `.vcd` waveform files.

---

## 💻 Installation

### Windows
Install:
- **Icarus Verilog**: https://bleyer.org/icarus/
- **GTKWave**: http://gtkwave.sourceforge.net/

After installation, verify in CMD/PowerShell:

```bash
iverilog -V
gtkwave --version



---

## ✅ Steps to Run (Using `run.bat`)

### 1) Open Command Prompt / PowerShell in the repository folder  
Example:
```
D:\verilog\RTL
```

### 2) Run the batch file
```bat
run.bat
```

### 3) It will ask:
```
Enter name:
```

### 4) Type the module name without extension  
Example:
```
mux_2to1
```

### 5) The script will automatically:

**Compile:**
```bash
iverilog -o mux_2to1.vvp mux_2to1.v mux_2to1_tb.v
```

**Run:**
```bash
vvp mux_2to1.vvp
```

**Open:**
```bash
gtkwave mux_2to1.vcd
```
## ▶️ Manual Simulation Steps

If you want to run simulations manually:

### 1) Compile
```bash
iverilog -o <module_name>.vvp <module_name>.v <module_name>_tb.v
```

Example:
```bash
iverilog -o mux_2to1.vvp mux_2to1.v mux_2to1_tb.v
```

### 2) Run simulation
```bash
vvp <module_name>.vvp
```

### 3) Open waveform
```bash
gtkwave <module_name>.vcd
```
