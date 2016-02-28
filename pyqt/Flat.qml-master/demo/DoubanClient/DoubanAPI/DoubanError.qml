// 豆瓣错误码
pragma Singleton
import QtQuick 2.0
import "./util.js" as U

QtObject {
    objectName:"DoubanError"
    function searchErrorCode(error_code){
        var e = JSON.parse(__doubanError);
        var iter;
        for(iter in e ){
            if(e[iter].error_code == error_code) {
                console.log("error_code : ",error_code);
                console.log("errorString : ",e[iter].errorString);
                // @disable-check M2
                console.log("错误说明 : ",e[iter].错误说明 );
                return e[iter];
            }
        }
        return e[iter];
    }

    readonly property string
    __doubanError:""
//    '
//[
//    {
//        "error_code": 100,
//        "errorString": "invalid_request_scheme",
//        "错误说明": "错误的请求协议"
//    },
//    {
//        "error_code": 101,
//        "errorString": "invalid_request_method",
//        "错误说明": "错误的请求方法"
//    },
//    {
//        "error_code": 102,
//        "errorString": "access_token_is_missing",
//        "错误说明": "未找到access_token"
//    },
//    {
//        "error_code": 103,
//        "errorString": "invalid_access_token",
//        "错误说明": "access_token不存在或已被用户删除，或者用户修改了密码"
//    },
//    {
//        "error_code": 104,
//        "errorString": "invalid_apikey",
//        "错误说明": "apikey不存在或已删除"
//    },
//    {
//        "error_code": 105,
//        "errorString": "apikey_is_blocked",
//        "错误说明": "apikey已被禁用"
//    },
//    {
//        "error_code": 106,
//        "errorString": "access_token_has_expired",
//        "错误说明": "access_token已过期"
//    },
//    {
//        "error_code": 107,
//        "errorString": "invalid_request_uri",
//        "错误说明": "请求地址未注册"
//    },
//    {
//        "error_code": 108,
//        "errorString": "invalid_credencial1",
//        "错误说明": "用户未授权访问此数据"
//    },
//    {
//        "error_code": 109,
//        "errorString": "invalid_credencial2",
//        "错误说明": "apikey未申请此权限"
//    },
//    {
//        "error_code": 111,
//        "errorString": "rate_limit_exceeded1",
//        "错误说明": "用户访问速度限制"
//    },
//    {
//        "error_code": 112,
//        "errorString": "rate_limit_exceeded2",
//        "错误说明": "IP访问速度限制"
//    },
//    {
//        "error_code": 113,
//        "errorString": "required_parameter_is_missing",
//        "错误说明": "缺少参数"
//    },
//    {
//        "error_code": 114,
//        "errorString": "unsupported_grant_type",
//        "错误说明": "错误的grant_type"
//    },
//    {
//        "error_code": 115,
//        "errorString": "unsupported_response_type",
//        "错误说明": "错误的response_type"
//    },
//    {
//        "error_code": 116,
//        "errorString": "client_secret_mismatch",
//        "错误说明": "client_secret不匹配"
//    },
//    {
//        "error_code": 117,
//        "errorString": "redirect_uri_mismatch",
//        "错误说明": "redirect_uri不匹配"
//    },
//    {
//        "error_code": 118,
//        "errorString": "invalid_authorization_code",
//        "错误说明": "authorization_code不存在或已过期"
//    },
//    {
//        "error_code": 119,
//        "errorString": "invalid_refresh_token",
//        "错误说明": "refresh_token不存在或已过期"
//    },
//    {
//        "error_code": 120,
//        "errorString": "username_password_mismatch",
//        "错误说明": "用户名密码不匹配"
//    },
//    {
//        "error_code": 121,
//        "errorString": "invalid_user",
//        "错误说明": "用户不存在或已删除"
//    },
//    {
//        "error_code": 122,
//        "errorString": "access_token_has_expired_since_password_changed",
//        "错误说明": "用户已被屏蔽"
//    },
//    {
//        "error_code": 123,
//        "errorString": "invalid_refresh_token",
//        "错误说明": "因用户修改密码而导致access_token过期"
//    },
//    {
//        "error_code": 125,
//        "errorString": "invalid_request_scope",
//        "错误说明": "访问的scope不合法，开发者不用太关注，一般不会出现该错误"
//    },
//    {
//        "error_code": 999,
//        "errorString": "unknown",
//        "错误说明": "未知错误"
//    },
//    {
//        "error_code": 1000,
//        "errorString": "need_permission",
//        "错误说明": "需要权限"
//    },
//    {
//        "error_code": 1001,
//        "errorString": "uri_not_found",
//        "错误说明": "资源不存在"
//    },
//    {
//        "error_code": 1002,
//        "errorString": "missing_args",
//        "错误说明": "参数不全"
//    },
//    {
//        "error_code": 1003,
//        "errorString": "image_too_large",
//        "错误说明": "上传的图片太大"
//    },
//    {
//        "error_code": 1004,
//        "errorString": "has_ban_word",
//        "错误说明": "输入有违禁词"
//    },
//    {
//        "error_code": 1005,
//        "errorString": "input_too_short",
//        "错误说明": "输入为空，或者输入字数不够"
//    },
//    {
//        "error_code": 1006,
//        "errorString": "target_not_fount",
//        "错误说明": "相关的对象不存在，比如回复帖子时，发现小组被删掉了"
//    },
//    {
//        "error_code": 1007,
//        "errorString": "need_captcha",
//        "错误说明": "需要验证码，验证码有误"
//    },
//    {
//        "error_code": 1008,
//        "errorString": "image_unknow",
//        "错误说明": "不支持的图片格式"
//    },
//    {
//        "error_code": 1009,
//        "errorString": "image_wrong_format",
//        "错误说明": "照片格式有误(仅支持JPG,JPEG,GIF,PNG或BMP)"
//    },
//    {
//        "error_code": 1010,
//        "errorString": "image_wrong_ck",
//        "错误说明": "访问私有图片ck验证错误"
//    },
//    {
//        "error_code": 1011,
//        "errorString": "image_ck_expired",
//        "错误说明": "访问私有图片ck过期"
//    },
//    {
//        "error_code": 1012,
//        "errorString": "title_missing",
//        "错误说明": "题目为空"
//    },
//    {
//        "error_code": 1013,
//        "errorString": "desc_missing",
//        "错误说明": "描述为空"
//    }
//]'
}

