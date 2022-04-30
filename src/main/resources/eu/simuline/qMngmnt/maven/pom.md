
  <plugin>
		<groupId>org.apache.maven.plugins</groupId>
		<artifactId>maven-dependency-plugin</artifactId>
		<version>3.1.2</version>
		<executions>
	  	  <execution>
	   	    <goals>
	    	  <goal>build-classpath</goal>
	    	</goals>
	  	  </execution>
		</executions>
		<configuration>
	  	  <outputFile>${project.build.directory}/classpath.txt</outputFile>
		</configuration>
      </plugin>


      mvn versions:display-plugin-updates


      enforcer

      and so on  
