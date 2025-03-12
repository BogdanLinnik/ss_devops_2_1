echo "This script will test project build time for npm and yarn tools."

echo "Pre test cleanup"
echo "Try to remove node_modules"
rm -rf node_modules

echo "Try to clean npm cache"
rm -rf package-lock.json
npm cache clean --force

echo "Try to clean yarn cache"
rm -rf yarn.lock
yarn cache clean

echo "Run build by npm"
node_install_time=$(npm install | grep 'packages in' | awk -F ' ' '{ print $NF }')
node_build_time=$(npm run build | grep 'Time: ' | awk -F ' ' '{ print $NF }')

echo "Post npm build cleanup"
rm -rf node_modules
rm -rf package-lock.json
npm cache clean --force

echo "Run build by yarn"
yarn_install_time=$(yarn install | grep 'Done in' | awk -F ' ' '{ print $NF }')
yarn_build_time=$(yarn run build | grep 'Done in' | awk -F ' ' '{ print $NF }')

echo "Post yarn build cleanup"
rm -rf node_modules
rm -rf yarn.lock
yarn cache clean

echo " "
echo "Project setup stats:"
echo "--------------------------------------------"
echo "npm:"
echo "     * install time - $node_install_time"
echo "     * build time - $node_build_time"
echo "yarn:"
echo "     * install time - $yarn_install_time"
echo "     * build time - $yarn_build_time"
echo "--------------------------------------------"
echo " "
