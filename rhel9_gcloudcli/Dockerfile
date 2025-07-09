# Use a RHEL 9 base image.
# You'll likely need to pull this from a Red Hat registry (e.g., registry.access.redhat.com/ubi9/ubi)
# or a private registry if you have a RHEL subscription.
# Replace 'registry.access.redhat.com/ubi9/ubi' with your actual RHEL 9 base image.
FROM registry.access.redhat.com/ubi9/ubi:latest

# Set environment variables for non-interactive installation
ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1 \
    CLOUDSDK_INSTALL_DIR=/usr/local/gcloud

# Add the Google Cloud SDK repository
RUN dnf install -y dnf-plugins-core && \
    dnf config-manager --add-repo https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64.repo && \
    rpm --import https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg

# Due to a potential issue with strong crypto policies in RHEL 9 and older GPG keys
# for the Google Cloud SDK, you might need to temporarily relax the crypto policy.
# However, it's better to ensure the latest gpgkey is used, which the above `rpm --import` does.
# If you still encounter GPG errors, you might temporarily use:
# RUN update-crypto-policies --set DEFAULT:SHA1 && \
#     dnf install -y google-cloud-cli && \
#     update-crypto-policies --set DEFAULT

# Install the Google Cloud CLI
RUN dnf install -y google-cloud-cli

# Clean up dnf cache to reduce image size
RUN dnf clean all && rm -rf /var/cache/dnf

# Add gcloud to the PATH
ENV PATH="${PATH}:${CLOUDSDK_INSTALL_DIR}/google-cloud-sdk/bin"

# (Optional) Set a default command or entrypoint for the container
# For example, to just show the gcloud version when the container starts:
# CMD ["gcloud", "version"]

# Alternatively, set an entrypoint to always have gcloud available
ENTRYPOINT ["/bin/bash"]