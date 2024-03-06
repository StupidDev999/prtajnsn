# Use the latest Arch Linux image
FROM archlinux:latest

# Enable multilib repository and update system
RUN echo '[multilib]' >> /etc/pacman.conf \
    && echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf \
    && pacman -Syu --noconfirm

# Update system and install necessary packages
RUN pacman -Syu --noconfirm \
    && pacman -S base-devel git sudo mingw-w64 gcc clang glslang wine-staging winetricks giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox --noconfirm \
    # Clean up cache to reduce image size
    && pacman -S meson ninja vulkan-intel vulkan-icd-loader --noconfirm \
    && pacman -Scc --noconfirm

# Create a user for the development environment (e.g., developer)
# Replace 'developer' with the desired username
RUN useradd -m -G wheel -s /bin/bash developer \
    && echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer

# Switch to the new user
USER developer

# Set the working directory to the developer's home directory
WORKDIR /home/developer

# Optional: Set environment variables for MinGW-w64 if necessary

# Start a shell by default
CMD ["/bin/bash"]
