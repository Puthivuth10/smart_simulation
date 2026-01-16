# Smart Traffic Light Simulation System

## Project Overview

This project implements a comparative study between **Smart Traffic Light Control** and **Traditional Traffic Light Control** systems using real-time vehicle detection and dynamic signal timing algorithms. The simulation is built using Python and Pygame, comparing adaptive timing based on vehicle density against fixed-time signal control.

---

## Table of Contents

1. [Features](#features)
2. [System Architecture](#system-architecture)
3. [Technologies Used](#technologies-used)
4. [Installation](#installation)
5. [Usage](#usage)
6. [File Structure](#file-structure)
7. [Configuration](#configuration)
8. [Simulation Details](#simulation-details)
9. [Performance Metrics](#performance-metrics)
10. [Docker Deployment](#docker-deployment)
11. [Requirements](#requirements)
12. [Contributors](#contributors)

---

## Features

### Smart Traffic Light System
- **Dynamic Signal Timing**: Adjusts green light duration based on real-time vehicle count and type
- **PCU-Based Calculation**: Uses Passenger Car Unit (PCU) values for different vehicle types
  - Car: 1.0 PCU
  - Motorbike: 0.3 PCU
  - Truck: 2.5 PCU
  - Tuk-tuk/Bus: 0.7 PCU
- **Adaptive Algorithm**: Green time = Total PCU × 1.8 × 0.6 (bounded between 15-90 seconds)
- **Phase-Based Vehicle Detection**: Reads traffic data from external sources (YOLO detection compatible)

### Traditional Traffic Light System
- **Fixed-Time Control**: Static 30-second green light for all phases
- **Baseline Comparison**: Provides benchmark for evaluating smart system performance

### Common Features
- **Multi-Directional Traffic**: Simulates 4-way intersection (Right, Down, Left, Up)
- **Multiple Vehicle Types**: Cars, Buses, Trucks, Bikes with different speeds and scales
- **Vehicle Turning Logic**: Vehicles can turn at intersection with realistic behavior
- **Real-Time Visualization**: Pygame-based graphical interface showing live traffic flow
- **Performance Reporting**: Generates statistical reports with waiting time, crossed vehicles, and phase information
- **Manual/Automatic Spawning**: Supports both JSON-based spawn patterns and manual vehicle generation
- **Configurable Parameters**: Adjustable speeds, gaps, signal timings, and simulation duration

---

## System Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Traffic Data Input                     │
│              (traffic_data.txt / YOLO Output)            │
└───────────────────────┬─────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────┐
│              Signal Timing Algorithm                     │
│  ┌──────────────────┐     ┌─────────────────────────┐  │
│  │  Smart System    │     │  Traditional System     │  │
│  │  (Dynamic PCU)   │     │  (Fixed 30s)            │  │
│  └──────────────────┘     └─────────────────────────┘  │
└───────────────────────┬─────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────┐
│              Pygame Simulation Engine                    │
│  • Vehicle Spawning & Movement                           │
│  • Collision Detection                                   │
│  • Traffic Signal Control                                │
│  • Visual Rendering                                      │
└───────────────────────┬─────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────┐
│              Performance Analysis                        │
│  • Average Waiting Time                                  │
│  • Vehicles Crossed Count                                │
│  • Green Time per Phase                                  │
│  • Report Generation (PNG/Console)                       │
└─────────────────────────────────────────────────────────┘
```

---

## Technologies Used

- **Python 3.11+**: Core programming language
- **Pygame 2.6.1**: Graphics and simulation framework
- **NumPy**: Numerical computations (optional)
- **Pillow (PIL)**: Image processing for reports
- **Matplotlib**: Data visualization (optional)
- **Docker**: Containerization for deployment
- **JSON**: Spawn pattern configuration

---

## Installation

### Prerequisites
- Python 3.11 or higher
- pip (Python package manager)
- Git (optional)

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd simulation
```

### Step 2: Create Virtual Environment (Recommended)
```bash
# Windows
python -m venv env
env\Scripts\activate

# Linux/Mac
python3 -m venv env
source env/bin/activate
```

### Step 3: Install Dependencies
```bash
pip install pygame numpy pillow matplotlib
```

Or install from requirements file:
```bash
pip install -r requirements.txt
```

---

## Usage

### Running Smart Traffic Light Simulation
```bash
python smart-simulation.py
```

### Running Traditional Traffic Light Simulation
```bash
python traditional-simulation.py
```

### Keyboard Controls
- **SPACE**: Manual spawn vehicle
- **ESC**: Exit simulation
- **Q**: Quit simulation

### Configuration Options
Edit the configuration variables at the top of each simulation file:

```python
USE_YOLO_DATA = True              # Read from traffic_data.txt
simulationTime = 300              # Simulation duration (seconds)
STATIC_GREEN_TIME = 30            # Traditional system green time
manualSpawnEnabled = True         # Enable manual spawning
```

---

## File Structure

```
simulation/
│
├── smart-simulation.py           # Smart traffic light system
├── traditional-simulation.py     # Traditional traffic light system
├── traffic_data.txt              # Vehicle count input (YOLO compatible)
├── spawn_pattern.json            # Predefined vehicle spawn pattern
├── Dockerfile                    # Docker container configuration
├── README.md                     # This file
│
├── images/                       # Vehicle and signal images
│   ├── signals/                  # Traffic light images
│   │   ├── green.png
│   │   ├── red.png
│   │   └── yellow.png
│   ├── right/                    # Right-facing vehicles
│   ├── down/                     # Down-facing vehicles
│   ├── left/                     # Left-facing vehicles
│   └── up/                       # Up-facing vehicles
│
├── env/                          # Virtual environment (if created)
│   ├── Lib/
│   ├── Scripts/
│   └── pyvenv.cfg
│
├── Functional Requirement.docx   # Project functional requirements
├── Non-Functional Requirements.docx
└── Final Report Format_DSE.doc   # Project report format
```

---

## Configuration

### Traffic Data Format (`traffic_data.txt`)

The file contains 8 lines representing vehicle counts:

```
<Phase 0 Cars>
<Phase 0 Motorbikes>
<Phase 0 Trucks>
<Phase 0 Tuk-tuks>
<Phase 1 Cars>
<Phase 1 Motorbikes>
<Phase 1 Trucks>
<Phase 1 Tuk-tuks>
```

**Example:**
```
2    # Phase 0: 2 cars
2    # Phase 0: 2 motorbikes
0    # Phase 0: 0 trucks
0    # Phase 0: 0 tuk-tuks
50   # Phase 1: 50 cars
50   # Phase 1: 50 motorbikes
10   # Phase 1: 10 trucks
10   # Phase 1: 10 tuk-tuks
```

### Vehicle Speeds
```python
speeds = {
    'car': 2.25,
    'bus': 1.8,
    'truck': 1.8,
    'bike': 3.5
}
```

### Vehicle Scales
```python
scales = {
    'car': 0.7,
    'bus': 1.0,
    'truck': 0.9,
    'bike': 0.5
}
```

---

## Simulation Details

### Signal Control Logic

#### Smart System
1. Reads vehicle counts from `traffic_data.txt`
2. Calculates total PCU for each phase
3. Computes green time: `time = PCU × 1.8 × 0.6`
4. Bounds result: `max(15, min(90, time))`
5. Applies calculated green time to signal

#### Traditional System
1. Applies fixed 30-second green time
2. Cycles through all signals equally
3. No adaptation to traffic conditions

### Vehicle Movement
- Vehicles spawn at edges of screen
- Move towards intersection at predefined speeds
- Stop at red signals (stop line)
- Move through intersection during green
- Can turn left/right at intersection
- Removed from simulation after crossing

### Collision Avoidance
- Maintains minimum gap between vehicles (`stoppingGap = 25`)
- Vehicles decelerate near stopped vehicles
- Lane-specific movement coordination

---

## Performance Metrics

The simulation tracks and reports:

1. **Average Waiting Time**: Mean time vehicles spend waiting at signals
2. **Total Vehicles Crossed**: Number of vehicles that successfully crossed intersection
3. **Green Time Distribution**: Time allocated to each signal phase
4. **Vehicle Type Distribution**: Count of each vehicle type processed
5. **Phase-Specific Performance**: Waiting times and throughput per phase

### Report Generation
Both simulations generate a PNG report at the end showing:
- System type (Smart/Traditional)
- Total simulation time
- Average waiting time
- Vehicles crossed per direction
- Green time for each phase
- Vehicle count statistics

---

## Docker Deployment

### Building the Docker Image
```bash
docker build -t traffic-simulation .
```

### Running the Container
```bash
docker run --rm traffic-simulation
```

### Docker Configuration
The Dockerfile includes:
- Python 3.11 slim base image
- SDL2 libraries for Pygame
- Headless display configuration
- All project dependencies

---

## Requirements

### Python Packages
- `pygame>=2.6.0`
- `numpy` (optional)
- `pillow>=10.0.0`
- `matplotlib` (optional)

### System Dependencies (Linux)
- libsdl2-dev
- libsdl2-image-dev
- libsdl2-mixer-dev
- libsdl2-ttf-dev
- libjpeg-dev
- libfreetype6-dev

### Minimum System Requirements
- **OS**: Windows 10/11, Linux, macOS
- **RAM**: 4 GB
- **Processor**: Dual-core 2.0 GHz
- **Python**: 3.11 or higher

---

## Performance Comparison

### Expected Results

| Metric | Smart System | Traditional System |
|--------|--------------|-------------------|
| Avg. Waiting Time | Lower | Higher |
| Adaptability | High | None |
| Throughput | Higher | Lower |
| Green Time Efficiency | Optimized | Fixed |

### Use Cases
- **Smart System**: Best for variable traffic patterns, peak hours, asymmetric traffic
- **Traditional System**: Suitable for predictable, uniform traffic flow

---

## Troubleshooting

### Common Issues

1. **Pygame not found**
   ```bash
   pip install pygame
   ```

2. **SDL2 library errors (Linux)**
   ```bash
   sudo apt-get install libsdl2-dev libsdl2-image-dev
   ```

3. **Display issues on headless systems**
   ```bash
   export SDL_VIDEODRIVER=dummy
   ```

4. **traffic_data.txt not found**
   - Ensure the file exists in the same directory
   - Check file permissions
   - Verify correct format (8 lines of integers)

---

## Future Enhancements

- [ ] Real-time YOLO integration
- [ ] Multi-intersection simulation
- [ ] Machine learning-based optimization
- [ ] Web-based dashboard
- [ ] Emergency vehicle priority
- [ ] Pedestrian crossing simulation
- [ ] Historical data analysis
- [ ] Cloud deployment

---

## Contributors

**Project Team**: DSE Year 3 - Project Practicum
**Institution**: [Your Institution Name]
**Academic Year**: 2025-2026

---

## License

This project is developed as part of an academic practicum. All rights reserved.

---

## Acknowledgments

- Traffic engineering principles from transportation research
- Pygame community for graphics framework
- YOLO object detection framework for vehicle detection capabilities

---

## Contact

For questions or support, please contact:
- **Email**: [Your email]
- **Project Repository**: [Repository URL]

---

## Version History

- **v1.0** (January 2026): Initial release with smart and traditional simulation
- Comparative analysis framework
- Docker deployment support
- Performance reporting system

---

**Last Updated**: January 16, 2026