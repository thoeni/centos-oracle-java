FROM	centos

ENV	UPDATE_VERSION=7u80
ENV	JAVA_VERSION=1.7.0_80
ENV	BUILD=b15

RUN	yum -y update
RUN	yum -y install wget
RUN	wget -c --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${UPDATE_VERSION}-${BUILD}/jdk-${UPDATE_VERSION}-linux-x64.rpm" --output-document="jdk-${UPDATE_VERSION}-linux-x64.rpm"
RUN	rpm -i jdk-${UPDATE_VERSION}-linux-x64.rpm
RUN	alternatives --install /usr/bin/java java /usr/java/jdk${JAVA_VERSION}/bin/java 1
RUN	alternatives --set java /usr/java/jdk${JAVA_VERSION}/bin/java
RUN	export JAVA_HOME=/usr/java/jdk${JAVA_VERSION}/
RUN	echo "export JAVA_HOME=/usr/java/jdk${JAVA_VERSION}/" | tee /etc/environment
RUN	source /etc/environment
RUN	rm jdk-${UPDATE_VERSION}-linux-x64.rpm
RUN	yum -y install openssh-server
RUN	chkconfig sshd on

ENV	JAVA_HOME=/usr/java/jdk${JAVA_VERSION}/

EXPOSE	22

CMD	["service sshd start"]
