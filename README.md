# bash-monitor

Lightweight system resource monitor written in Bash.

## Usage

```bash
./monitor.sh
```

## What it monitors

- **CPU** — usage percentage with warning threshold
- **RAM** — memory usage percentage
- **Disk** — root partition usage
- **Network** — download/upload speed in KB/s
- **Processes** — total count and high CPU processes

## Configuration

Edit `THRESHOLD` in `lib/helpers.sh` to set warning level (default: 70%)

## Project Structure

```
bash-monitor/
├── monitor.sh
└── lib/
    ├── helpers.sh
    └── checks.sh
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
