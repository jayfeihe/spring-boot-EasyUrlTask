<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringBoot EasyUrlTask</title>
    <#import "common/common-import.ftl" as common>
    <@common.commonStyle />

</head>
<body>

<el-container>

    <el-container>
        <el-header>
            <#--<el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item>EasyTask</el-breadcrumb-item>
                <el-breadcrumb-item>任务管理</el-breadcrumb-item>
                <el-breadcrumb-item>任务列表</el-breadcrumb-item>
            </el-breadcrumb>-->
        </el-header>
        <el-main>
            <#--内容展示-->
            <div id="app">
            <el-form ref="form" :model="formData" label-width="120px">
                <el-form-item label="请求ID">
                    <el-input v-model="formData.requestId" :disabled="true"></el-input>
                </el-form-item>
                <el-form-item label="请求方式">
                    <el-select v-model="formData.method" placeholder="请求方式">
                        <el-option label="POST" value="POST" ></el-option>
                        <el-option label="GET" value="GET"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="启用状态">
                    <el-switch v-model="formData.status"></el-switch>
                </el-form-item>
                <el-form-item label="Token URL">
                    <el-input type="textarea" v-model="formData.tokenUrl"></el-input>
                </el-form-item>
                <el-form-item label="请求参数JSON">
                    <el-input type="textarea" v-model="formData.param"></el-input>
                </el-form-item>
                <el-form-item label="请求参数类型">
                    <el-select v-model="formData.paramType" placeholder="请求参数类型">
                        <el-option label="FORM" value="FORM"></el-option>
                        <el-option label="JSON" value="JSON" ></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="获取TOKEN表达式">
                    <el-input type="textarea" v-model="formData.tokenExpression"></el-input>
                </el-form-item>
                <el-form-item label="追加Token参数">
                    <el-input type="textarea" v-model="formData.appendName"></el-input>
                </el-form-item>
                <el-form-item label="追加Token方式">
                    <el-select v-model="formData.appendType" placeholder="追加方式">
                        <el-option label="URL" value="URL" ></el-option>
                        <el-option label="FORM" value="FORM"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button type="success" @click="onTest">测试</el-button>
                    <el-button type="primary" @click="onSubmit">保存</el-button>
                    <el-button>取消</el-button>
                </el-form-item>

            </el-form>
            </div>
        </el-main>
    </el-container>
</el-container>


</body>
<@common.commonScript />
<style>
    .el-header {
        background-color: #B3C0D1;
        color: #333;
        line-height: 60px;
    }

    .el-aside {
        color: #333;
    }
</style>

<script>
    var Main = {
        data() {
            return {
                formData:{
                    "requestId":"${requestId!!}",
                    "tokenUrl":"",
                    "method":"",
                    "param":"",
                    "paramType":"",
                    "appendType":"",
                    "appendName":"",
                    "tokenExpression":"",
                    "status":"",
                }
            }
        },
        created: function(){
            // 组件创建完后获取数据，
            // 此时 data 已经被 observed 了
            this.fetchData();
        },
        methods: {
            fetchData: function () {
                this.$http.post('${request.contextPath}/urlPlus/token/find',this.formData,{emulateJSON:false}).then(function(res){
                    console.log(res);
                    if(res.body.code==0){
                        this.formData = res.body.msg;
                    }
                }).catch(function (error) {
                        console.log(error);
                    });
            },
            onSubmit:function() {
                //发送post请求
                this.$http.post('${request.contextPath}/urlPlus/token/save',this.formData,{emulateJSON:false}).then(function(res){
                    if(res.body.code==0){
                        this.$confirm(res.body.msg);
                    }else{
                        this.$confirm(res.body.msg);
                    }
                },function(){
                    console.log('请求失败处理');
                });
            },
            onTest:function() {
                //发送post请求
                this.$http.post('${request.contextPath}/urlPlus/token/test',this.formData,{emulateJSON:false}).then(function(res){
                    if(res.body.code==0){
                        this.$confirm(res.body.msg);
                    }else{
                        this.$confirm(res.body.msg);
                    }
                },function(){
                    console.log('请求失败处理');
                });
            }
        }
    }
    var Ctor = Vue.extend(Main)
    new Ctor().$mount('#app')
</script>
</html>