# Traffic Light Simulation System

## Overview

This project compares **Smart Traffic Light Control** vs **Traditional Traffic Light Control** using Python and Pygame. The smart system uses dynamic signal timing based on real-time vehicle detection, while the traditional system uses fixed 30-second intervals.

## Features

- **Smart System**: Adjusts green light duration based on vehicle count and type (PCU calculation)
- **Traditional System**: Fixed 30-second green light for all phases
- Real-time visualization with Pygame
- Supports multiple vehicle types: cars, buses, trucks, bikes
- Performance metrics: waiting time, vehicles crossed, green time per phase

## Installation

1. Install Python 3.11 or higher
2. Install required packages:
```bash
pip install pygame pillow
```

## How to Run

### Smart Simulation
```bash
python smart-simulation.py
```

### Traditional Simulation
```bash
python traditional-simulation.py
```

### Docker (Optional)
```bash
docker build -t traffic-sim .
docker run --rm traffic-sim
```

## Configuration

Edit `traffic_data.txt` to set vehicle counts (8 lines: Phase 0 and Phase 1 data for cars, motorbikes, trucks, tuk-tuks).

## Controls

- **SPACE**: Spawn vehicle manually
- **ESC/Q**: Exit simulation

## Output

Both simulations generate a performance report showing average waiting time, vehicles crossed, and green time per phase.