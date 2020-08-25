/**
* The  program implements an application that
* helps in parsing and stringifying the workforce paylaod
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
public with sharing class WorkForceRequestResponseDTO {
    public class Request{
		public String id;	//5000K00002AR7FA
		public String agentid;	//00528000002V3gB
	}
	Public class Response{
		public boolean success;
        public String secretKey;
        public String error;
	}
	public static WorkForceRequestResponseDTO.Request parseRequest(String json){
		return (WorkForceRequestResponseDTO.Request) System.JSON.deserialize(json, WorkForceRequestResponseDTO.Request.class);
	}
	public static WorkForceRequestResponseDTO.Response parseResponse(String json){
		return (WorkForceRequestResponseDTO.Response) System.JSON.deserialize(json, WorkForceRequestResponseDTO.Response.class);
	}
	
}
