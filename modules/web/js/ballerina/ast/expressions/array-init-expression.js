/**
 * Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
import _ from 'lodash';
import Expression from './expression';

/**
 * Constructor for ArrayInitExpression
 * @param {Object} args - Arguments to create the ArrayInitExpression
 * @constructor
 */
class ArrayInitExpression extends Expression {
    constructor(args) {
        super('ArrayInitExpression');
    }

    /**
     * initialize ArrayInitExpression from json object
     * @param {Object} jsonNode to initialize from
     */
    initFromJson(jsonNode) {
        var self = this;
        var generatedExpression = '[';
        _.each(jsonNode.children, function (childNode) {
            var child = self.getFactory().createFromJson(childNode);
            self.addChild(child);
            child.initFromJson(childNode);
            generatedExpression += child.getExpression() + ",";
        });
        this.setExpression(generatedExpression.replace(/,\s*$/, "") + ']', {doSilently: true});
    }

    generateExpression() {
        var generatedExpression = '[';
        _.each(this.getChildren(), function (child) {
            generatedExpression += child.getExpression() + ",";
        });
        this.setExpression(generatedExpression.replace(/,\s*$/, "") + ']', {doSilently: true});
        return this._expression;
    }
}

export default ArrayInitExpression;

