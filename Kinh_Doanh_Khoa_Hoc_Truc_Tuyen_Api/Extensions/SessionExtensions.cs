﻿using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace Kinh_Doanh_Khoa_Hoc_Truc_Tuyen_Api.Extensions
{
    public static class SessionExtensions
    {
        public static void Set<T>(this ISession session, string key, T value)
        {
            session.SetString(key, JsonConvert.SerializeObject(value));
        }

        public static T Get<T>(this ISession session, string key)
        {
            var value = session.GetString(key);
            return value == null ? default(T) :
                JsonConvert.DeserializeObject<T>(value);
        }
    }
}