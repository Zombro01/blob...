#!/bin/bash

# Define the variables
LINK_LOCAL="link.local"
EXAMPLE_COM="example.com"

echo "Starting DNS setup for $LINK_LOCAL -> $EXAMPLE_COM..."

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit
fi

# Update the system
echo "Updating package list..."
apt update -y

# Install dnsmasq
echo "Installing dnsmasq..."
apt install -y dnsmasq

# Resolve the IP address of example.com
EXAMPLE_IP=$(dig +short $EXAMPLE_COM | tail -n1)

if [ -z "$EXAMPLE_IP" ]; then
  echo "Failed to resolve IP for $EXAMPLE_COM. Please check the domain."
  exit 1
fi

echo "Resolved $EXAMPLE_COM to $EXAMPLE_IP"

# Backup the original dnsmasq configuration
echo "Backing up original dnsmasq configuration..."
cp /etc/dnsmasq.conf /etc/dnsmasq.conf.bak

# Configure dnsmasq
echo "Configuring dnsmasq to resolve $LINK_LOCAL to $EXAMPLE_IP..."
cat <<EOF > /etc/dnsmasq.conf
# DNS configuration for $LINK_LOCAL
address=/$LINK_LOCAL/$EXAMPLE_IP

# Optional: Ensure it listens on all interfaces
listen-address=127.0.0.1
EOF

# Restart dnsmasq
echo "Restarting dnsmasq service..."
systemctl restart dnsmasq

# Enable dnsmasq to start on boot
echo "Enabling dnsmasq service to start on boot..."
systemctl enable dnsmasq

echo "DNS server setup complete!"
echo "Test it using: dig @$EXAMPLE_IP $LINK_LOCAL"
