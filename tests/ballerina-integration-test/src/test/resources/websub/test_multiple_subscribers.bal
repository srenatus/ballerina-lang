// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/mime;
import ballerina/http;
import ballerina/websub;

endpoint websub:Listener websubEP {
    port:8383
};

@websub:SubscriberServiceConfig {
    path:"/websub",
    subscribeOnStartUp:true,
    topic: "http://three.websub.topic.com",
    hub: "https://localhost:9191/websub/hub",
    resourceUrl: "https://localhost:8080/publish", //invalid resource URL to test hub/topic prioritization
    leaseSeconds: 3600,
    secret: "Kslk30SNF2AChs2"
}
service<websub:Service> websubSubscriber bind websubEP {
    onNotification (websub:Notification notification) {
        json payload = check notification.getJsonPayload();
        io:println("WebSub Notification Received by One: " + payload.toString());
    }
}

@websub:SubscriberServiceConfig {
    path:"/websubTwo",
    subscribeOnStartUp:true,
    resourceUrl: "http://localhost:8080/publisherTwo/discover",
    leaseSeconds: 1200,
    secret: "SwklSSf42DLA"
}
service<websub:Service> websubSubscriberTwo bind websubEP {
    onNotification (websub:Notification notification) {
        json payload = check notification.getJsonPayload();
        io:println("WebSub Notification Received by Two: " + payload.toString());
    }
}
