# configs
SV configuration files

# Structure

The repo (will) contain a directory per network: DevNet, TestNet, MainNet. In each, the configuration
parameters that the SVC agrees should be used for that network are documented. There are some
exceptions to this rule for either historical or practical reasons. Known exceptions are:
- `ui-config-values.yaml` - UI configuration values that are shared across all networks

# Runtime Configuration

For runtime configuration values (dso and amulet rules) see another repository:
https://github.com/global-synchronizer-foundation/configs-runtime
