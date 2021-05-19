#!/bin/bash


#-----------------------Taking and placing the source code-------------------------
wget https://sourceforge.net/projects/jsudoku/files/jSudoku/jSudoku-1.3/jSudoku-src-1.3.tar.gz
tar xvzf jSudoku-src-1.3.tar.gz
mkdir src/main/java -p
find ./Sudoku-src/ -name '*.java' -exec cp {} ./src/main/java/ \;

cat << EOF > pom.xml
 <project>
      <modelVersion>4.0.0</modelVersion>

      <groupId>com.mycompany.app</groupId>
      <artifactId>my-app</artifactId>
      <version>1</version>
      <packaging>jar</packaging>
    <properties>
<maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
                   <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
   </properties>
     <build>
  <plugins>
    <plugin>
      <!-- Build an executable JAR -->
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-jar-plugin</artifactId>
      <version>3.1.0</version>
      <configuration>
        <archive>
          <manifest>
            <addClasspath>true</addClasspath>
            <classpathPrefix>lib/</classpathPrefix>
            <mainClass>com.mypackage.MyClass</mainClass>
          </manifest>
        </archive>
      </configuration>
    </plugin>
  </plugins>
</build>

 </project>
EOF




git init 
git add ./src/
git add pom.xml
git commit -m "Src add"
git push --set-upstream https://github.com/Siarhei-Prakhin/Lab1.git master




