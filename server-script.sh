sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install maven -y
sudo yum install git -y

if [ -d "addressbook" ]
then
echo "repo is the exists and pulling"
cd /home/ec2-user/addressbook
git pull origin hello
else
echo "repo is not exists"
git clone https://github.com/sarasivavikku/addressbook.git
cd /home/ec2-user/addressbook
fi 
mvn package