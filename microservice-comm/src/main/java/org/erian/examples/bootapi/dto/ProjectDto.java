/*
 * Copyright: Energy Research Institute @ NTU
 * microservice-comm
 * org.erian.examples.bootapi.dto -> ProjectCommDTO.java
 * Created on 22 Aug 2017-3:32:19 pm
 */
package org.erian.examples.bootapi.dto;

import java.util.List;

import org.erian.examples.bootapi.domain.*;

/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  22 Aug 2017 3:32:19 pm
 */
public class ProjectDto {
	Project project;
	List<ProjectCommunication>  projectComms;
}
