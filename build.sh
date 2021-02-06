REF="1.8.0"

git clone --depth 1 -b "${REF}" "https://github.com/Foundry376/Mailspring" "src"
cd src

# Remove unsupported packages:
rm -r app/internal_packages/{link-tracking,open-tracking,thread-sharing,participant-profile}


for patch in ../patches/*.js; do
  echo "Applying ${patch}..."
  node "${patch}"
done

for patch in ../patches/*.patch; do
  echo "Applying ${patch}..."
  patch -p 1 < "${patch}"
done

pattern='(support@getmailspring\.com|https?://support\.getmailspring\.com/(hc/en-us/requests/new|(?:^W))|https://github.com/Foundry376/Mailspring/issues(?:^W))'
rg -l "${pattern}" | while IFS=$'\n' read -r file; do
  rg --passthru "${pattern}" --replace 'https://git.io/msl-issues' "${file}" | sponge "${file}"
done

pattern='Foundry376/Mailspring'
rg -l "${pattern}" | while IFS=$'\n' read -r file; do
  rg --passthru "${pattern}" --replace 'notpushkin/Mailspring-Libre' "${file}" | sponge "${file}"
done

pattern='[\w\.]*getmailspring\.com'
rg -l "${pattern}" | while IFS=$'\n' read -r file; do
  rg --passthru "${pattern}" --replace '0.0.0.0' "${file}" | sponge "${file}"
done

npm ci --unsafe-perm=true --allow-root
DEBUG=electron-packager,electron-osx-sign npm run build
