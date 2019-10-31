Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79320EA975
	for <lists+linux-api@lfdr.de>; Thu, 31 Oct 2019 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJaDPP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 23:15:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38246 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfJaDPP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Oct 2019 23:15:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so4602679ljc.5;
        Wed, 30 Oct 2019 20:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=ikKgT4phGkiemnDn9uv5tBrPDv6LRqZZqhBKISBfT2E=;
        b=g8RASjPETWl0dgPdytS1ac2NjiKUL7ivzcbDKd8hT9A5Nel/c3exYH8rQtEzj24skC
         Q2vo9vD8jVtm5k2OTTNmeZcWKHAosZrvb/akIiXCa+q0Aaq2d+DupZ4KW3lbaRT827sT
         gMrSgznom6jH9FkQXqwTxitvXUNpGav4MPb2RVTniSw6CMUFltIl6A06Eqc4AkgOakKx
         5nqwBNu2pwZxGZ/YKbJTGDIK/QXa95hyukrZa0kQqAlrHc9hpu4pMMGMQqzchDYPLrY6
         yRZoRTdou22oFY9U8sXpsYnlVmycXOqlqgK0c8hSJhKy5beTx0Vz2SlVgb9zJUlasEs6
         NjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=ikKgT4phGkiemnDn9uv5tBrPDv6LRqZZqhBKISBfT2E=;
        b=A7E2m+NLZnPYeWIDGpSBlsYYas0/+NOVhGzKcZlue7prPimWcisjB83cTvFhbSALrY
         NYNwbtlQM4AUYORoFFs39LxUpBPD45IWw9ZYT9WIK/f21CiGZb3Lb5JuDMi9qANS8i80
         RjhT82ZJ+b6Zkf/BW0Vn9TYPvDOrw3CyzS7E709rUMT19PSB/2EoOrsoXeY+DwtUgkM4
         Ja6ss/Pswop5DHFCtWTdhBehV4OJKu8CwHe+HYI4jB6wRnu745a4L7DR3amt66eAv3VY
         bAQfFaO5zLXWaeY+xZ42st4WGrvHgOW9lLw8x8FnxL7fmGC1W+Hf+PvYIcJX7qg3LnL/
         Os6g==
X-Gm-Message-State: APjAAAVlisubLw8ZKKaDCS4DtELPyNNdN64YB/A8vBLHZhmhRku4uBb6
        FXiuaduyxI4XCOd6EdOczKw=
X-Google-Smtp-Source: APXvYqwhK8WiPsE2WhgZ33fADXgI854nJlkgPEwNlWYkUImMSj2y7xW41V+amqj9KytDYQgBWl0wGQ==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr2155373ljk.204.1572491712548;
        Wed, 30 Oct 2019 20:15:12 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id z22sm593255ljm.92.2019.10.30.20.15.09
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 20:15:11 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:15:09 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        n-horiguchi <n-horiguchi@ah.jp.nec.com>,
        akpm <akpm@linux-foundation.org>
Cc:     "Vlastimil Babka" <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH v2] mm: Fix checking unmapped holes for mbind
References: <201910291756045288126@gmail.com>
X-Priority: 3
X-GUID: FCAE7372-2FB5-4EB4-8FED-18F68E495B1E
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2019103111150700409251@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAxOS0xMC0yOcKgYXQgMTc6NTbCoExpIFhpbmhhacKgd3JvdGU6Cj5xdWV1ZV9wYWdlc19y
YW5nZSgpIHdpbGwgY2hlY2sgZm9yIHVubWFwcGVkIGhvbGVzIGJlc2lkZXMgcXVldWUgcGFnZXMg
Zm9yCj5taWdyYXRpb24uIFRoZSBydWxlcyBmb3IgY2hlY2tpbmcgdW5tYXBwZWQgaG9sZXMgYXJl
Ogo+MSBVbm1hcHBlZCBob2xlcyBhdCBhbnkgcGFydCBvZiB0aGUgc3BlY2lmaWVkIHJhbmdlIHNo
b3VsZCBiZSByZXBvcnRlZCBhcwo+wqAgRUZBVUxUIGlmIG1iaW5kKCkgZm9yIG5vbmUgTVBPTF9E
RUZBVUxUIGNhc2VzOwo+MiBVbm1hcHBlZCBob2xlcyBhdCBhbnkgcGFydCBvZiB0aGUgc3BlY2lm
aWVkIHJhbmdlIHNob3VsZCBiZSBpZ25vcmVkIGlmCj7CoCBtYmluZCgpIGZvciBNUE9MX0RFRkFV
TFQgY2FzZTsKPk5vdGUgdGhhdCB0aGUgc2Vjb25kIHJ1bGUgaXMgdGhlIGN1cnJlbnQgaW1wbGVt
ZW50YXRpb24sIGJ1dCBpdCBzZWVtcwo+Y29uZmxpY3RzIHRoZSBMaW51eCBBUEkgZGVmaW5pdGlv
bi4KPgo+cXVldWVfcGFnZXNfdGVzdF93YWxrKCkgaXMgZml4ZWQgYnkgaW50cm9kdWNlIG5ldyBm
aWVsZHMgaW4gc3RydWN0Cj5xdWV1ZV9wYWdlcyB3aGljaCBoZWxwIHRvIGNoZWNrOgo+MSBob2xl
cyBhdCBoZWFkIGFuZCB0YWlsIHNpZGUgb2Ygc3BlY2lmaWVkIHJhbmdlOwo+MiB0aGUgd2hvbGUg
cmFuZ2UgaXMgaW4gYSBob2xlOwo+Cj5CZXNpZGVzLCBxdWV1ZV9wYWdlc190ZXN0X3dhbGsoKSBt
dXN0IHVwZGF0ZSBwcmV2aW91cyB2bWEgcmVjb3JkIG5vIG1hdHRlcgo+dGhlIGN1cnJlbnQgdm1h
IHNob3VsZCBiZSBjb25zaWRlcmVkIGZvciBxdWV1ZSBwYWdlcyBvciBub3QuCj4gCgpNb3JlIGRl
dGFpbHMgYWJvdXQgY3VycmVudCBpc3N1ZSAod2hpY2ggYnJlYWtzIHRoZSBtYmluZCgpIEFQSSBk
ZWZpbml0aW9uKToKMS4gSW7CoHF1ZXVlX3BhZ2VzX3Rlc3Rfd2FsaygpCmNoZWNraW5nIG9uICgh
dm1hLT52bV9uZXh0ICYmIHZtYS0+dm1fZW5kIDwgZW5kKSB3b3VsZCBuZXZlciBzdWNjZXNzLCAK
YmVjYXVzZSAnZW5kJyBwYXNzZWQgZnJvbSB3YWxrX3BhZ2VfdGVzdCgpIG1ha2Ugc3VyZSAiZW5k
IDw9IMKgdm1hLT52bV9lbmQiLiBzbyBob2xlwqAKYmV5b25kIHRoZSBsYXN0IHZtYSBjYW4ndCBi
ZSBkZXRlY3RlZC7CoAoKMi7CoHF1ZXVlX3BhZ2VzX3Rlc3Rfd2FsaygpIG9ubHkgY2FsbGVkIGZv
ciB2bWEsIGFuZCAnc3RhcnQnLCAnZW5kJyBwYXJhbWV0ZXJzIGFyZSBndWFyYW50ZWVkCndpdGhp
biB2bWEuIFRoZW4sIGlmIHRoZSByYW5nZSBzdGFydGluZyBvciBlbmRpbmcgaW4gYW4gdW5tYXBw
ZWQgaG9sZSwgwqAKcXVldWVfcGFnZXNfdGVzdF93YWxrKCkgZG9uJ3QgaGF2ZSBjaGFuY2UgdG8g
YmUgY2FsbGVkIHRvIGNoZWNrLiBJbiBvdGhlciB3b3JkcywgdGhlwqAKY3VycmVudCBjb2RlIGNh
biBkZXRlY3QgdGhpcyBjYXNlIChyYW5nZSBzcGFuIG92ZXIgaG9sZSk6ClsgwqB2bWEgwqBdWyBo
b2xlIF1bIHZtYV0KwqAgwqBbIMKgIMKgIHJhbmdlIMKgIMKgIMKgXQpidXQgY2FudCBub3QgZGV0
ZWN0IHRoZXNlIGNhc2UgOgpbIMKgdm1hIMKgXVsgaG9sZSBdWyB2bWFdCsKgIMKgWyDCoHJhbmdl
IMKgXQpbIMKgdm1hIMKgXVsgaG9sZSBdWyDCoHZtYSDCoF0KwqAgwqAgwqAgwqAgwqAgwqAgWyDC
oHJhbmdlIMKgXQoKMy4gYSBjaGVja2luZyBpbiBtYmluZF9yYW5nZSgpIHRyeSB0byByZWNvdmVy
IGlmIHRoZSBob2xlIGlzIGluIGhlYWQgc2lkZSwgYnV0IGNhbid0wqAKcmVjb3ZlciBpZiBob2xl
IGlzIGluIHRhaWwgc2lkZSBvZiByYW5nZS4KCi0gWGluaGFpCgo+Rml4ZXM6IDlkOGNlYmQ0YmNk
NyAoIm1tOiBmaXggbWJpbmQgdm1hIG1lcmdlIHByb2JsZW0iKQo+Rml4ZXM6IDZmNDU3NmUzNjg3
YiAoIm1lbXBvbGljeTogYXBwbHkgcGFnZSB0YWJsZSB3YWxrZXIgb24gcXVldWVfcGFnZXNfcmFu
Z2UoKSIpCj5GaXhlczogNDg2ODRhNjViNGUzICgibW06IHBhZ2V3YWxrOiBmaXggbWlzYmVoYXZp
b3Igb2Ygd2Fsa19wYWdlX3JhbmdlIGZvciB2bWEoVk1fUEZOTUFQKSIpCj5TaWduZWQtb2ZmLWJ5
OiBMaSBYaW5oYWkgPGxpeGluaGFpLmxpQGdtYWlsLmNvbT4KPi0tLQo+Q2hhbmdlcyBpbiB2MjoK
PsKgIC0gRml4IHRoZSB1bm1hcHBlZCBob2xlcyBjaGVja2luZyBpbiBxdWV1ZV9wYWdlc190ZXN0
X3dhbGsoKSBpbnN0ZWFkIG9mwqAKPsKgIMKgIG1iaW5kX3JuYWdlKCkuCj4KPsKgbW0vbWVtcG9s
aWN5LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+
wqAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4KPmRp
ZmYgLS1naXQgYS9tbS9tZW1wb2xpY3kuYyBiL21tL21lbXBvbGljeS5jCj5pbmRleCA0YWU5Njdi
Y2Y5NTQuLjI0MDg3ZGZhNGRjZCAxMDA2NDQKPi0tLSBhL21tL21lbXBvbGljeS5jCj4rKysgYi9t
bS9tZW1wb2xpY3kuYwo+QEAgLTQxMSw2ICs0MTEsOSBAQCBzdHJ1Y3QgcXVldWVfcGFnZXMgewo+
wqAJdW5zaWduZWQgbG9uZyBmbGFnczsKPsKgCW5vZGVtYXNrX3QgKm5tYXNrOwo+wqAJc3RydWN0
IHZtX2FyZWFfc3RydWN0ICpwcmV2Owo+Kwl1bnNpZ25lZCBsb25nIHN0YXJ0Owo+Kwl1bnNpZ25l
ZCBsb25nIGVuZDsKPisJaW50IGluX2hvbGU7Cj7CoH07Cj7CoAo+wqAvKgo+QEAgLTYxOCwyOCAr
NjIxLDMxIEBAIHN0YXRpYyBpbnQgcXVldWVfcGFnZXNfdGVzdF93YWxrKHVuc2lnbmVkIGxvbmcg
c3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kLAo+wqAJdW5zaWduZWQgbG9uZyBlbmR2bWEgPSB2bWEt
PnZtX2VuZDsKPsKgCXVuc2lnbmVkIGxvbmcgZmxhZ3MgPSBxcC0+ZmxhZ3M7Cj7CoAo+LQkvKgo+
LQkqIE5lZWQgY2hlY2sgTVBPTF9NRl9TVFJJQ1QgdG8gcmV0dXJuIC1FSU8gaWYgcG9zc2libGUK
Pi0JKiByZWdhcmRsZXNzIG9mIHZtYV9taWdyYXRhYmxlCj4tCSovCj4tCWlmICghdm1hX21pZ3Jh
dGFibGUodm1hKSAmJgo+LQnCoCDCoCEoZmxhZ3MgJiBNUE9MX01GX1NUUklDVCkpCj4tCXJldHVy
biAxOwo+LQo+KwkvKiByYW5nZSBjaGVjayBmaXJzdCAqLwo+wqAJaWYgKGVuZHZtYSA+IGVuZCkK
PsKgCWVuZHZtYSA9IGVuZDsKPi0JaWYgKHZtYS0+dm1fc3RhcnQgPiBzdGFydCkKPi0Jc3RhcnQg
PSB2bWEtPnZtX3N0YXJ0Owo+KwlCVUdfT04oKHZtYS0+dm1fc3RhcnQgPiBzdGFydCkgfHwgKHZt
YS0+dm1fZW5kIDwgZW5kKSk7Cj7CoAo+KwlxcC0+aW5faG9sZSA9IDA7Cj7CoAlpZiAoIShmbGFn
cyAmIE1QT0xfTUZfRElTQ09OVElHX09LKSkgewo+LQlpZiAoIXZtYS0+dm1fbmV4dCAmJiB2bWEt
PnZtX2VuZCA8IGVuZCkKPisJaWYgKCghdm1hLT52bV9uZXh0ICYmIHZtYS0+dm1fZW5kIDwgcXAt
PmVuZCkgfHwKPisJKHZtYS0+dm1fbmV4dCAmJiBxcC0+ZW5kIDwgdm1hLT52bV9uZXh0LT52bV9z
dGFydCkpCj7CoAlyZXR1cm4gLUVGQVVMVDsKPi0JaWYgKHFwLT5wcmV2ICYmIHFwLT5wcmV2LT52
bV9lbmQgPCB2bWEtPnZtX3N0YXJ0KQo+KwlpZiAoKHFwLT5wcmV2ICYmIHFwLT5wcmV2LT52bV9l
bmQgPCB2bWEtPnZtX3N0YXJ0KSB8fAo+KwkoIXFwLT5wcmV2ICYmIHFwLT5zdGFydCA8IHZtYS0+
dm1fc3RhcnQpKQo+wqAJcmV0dXJuIC1FRkFVTFQ7Cj7CoAl9Cj7CoAo+wqAJcXAtPnByZXYgPSB2
bWE7Cj7CoAo+KwkvKgo+KwkqIE5lZWQgY2hlY2sgTVBPTF9NRl9TVFJJQ1QgdG8gcmV0dXJuIC1F
SU8gaWYgcG9zc2libGUKPisJKiByZWdhcmRsZXNzIG9mIHZtYV9taWdyYXRhYmxlCj4rCSovCj4r
CWlmICghdm1hX21pZ3JhdGFibGUodm1hKSAmJgo+KwnCoCDCoCEoZmxhZ3MgJiBNUE9MX01GX1NU
UklDVCkpCj4rCXJldHVybiAxOwo+Kwo+wqAJaWYgKGZsYWdzICYgTVBPTF9NRl9MQVpZKSB7Cj7C
oAkvKiBTaW1pbGFyIHRvIHRhc2tfbnVtYV93b3JrLCBza2lwIGluYWNjZXNzaWJsZSBWTUFzICov
Cj7CoAlpZiAoIWlzX3ZtX2h1Z2V0bGJfcGFnZSh2bWEpICYmCj5AQCAtNjc5LDE0ICs2ODUsMjMg
QEAgcXVldWVfcGFnZXNfcmFuZ2Uoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcg
c3RhcnQsIHVuc2lnbmVkIGxvbmcgZW5kLAo+wqAJbm9kZW1hc2tfdCAqbm9kZXMsIHVuc2lnbmVk
IGxvbmcgZmxhZ3MsCj7CoAlzdHJ1Y3QgbGlzdF9oZWFkICpwYWdlbGlzdCkKPsKgewo+KwlpbnQg
ZXJyOwo+wqAJc3RydWN0IHF1ZXVlX3BhZ2VzIHFwID0gewo+wqAJLnBhZ2VsaXN0ID0gcGFnZWxp
c3QsCj7CoAkuZmxhZ3MgPSBmbGFncywKPsKgCS5ubWFzayA9IG5vZGVzLAo+wqAJLnByZXYgPSBO
VUxMLAo+Kwkuc3RhcnQgPSBzdGFydCwKPisJLmVuZCA9IGVuZCwKPisJLmluX2hvbGUgPSAxLAo+
wqAJfTsKPsKgCj4tCXJldHVybiB3YWxrX3BhZ2VfcmFuZ2UobW0sIHN0YXJ0LCBlbmQsICZxdWV1
ZV9wYWdlc193YWxrX29wcywgJnFwKTsKPisJZXJyID0gd2Fsa19wYWdlX3JhbmdlKG1tLCBzdGFy
dCwgZW5kLCAmcXVldWVfcGFnZXNfd2Fsa19vcHMsICZxcCk7Cj4rCS8qIHdob2xlIHJhbmdlIGlu
IHVubWFwcGVkIGhvbGUgKi8KPisJaWYgKHFwLT5pbl9ob2xlICYmICEoZmxhZ3MgJiBNUE9MX01G
X0RJU0NPTlRJR19PSykpCj4rCWVyciA9IC1FRkFVTFQ7Cj4rCj4rCXJldHVybiBlcnI7Cj7CoH0K
PsKgCj7CoC8qCj5AQCAtNzM4LDggKzc1Myw3IEBAIHN0YXRpYyBpbnQgbWJpbmRfcmFuZ2Uoc3Ry
dWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsCj7CoAl1bnNpZ25lZCBsb25n
IHZtZW5kOwo+wqAKPsKgCXZtYSA9IGZpbmRfdm1hKG1tLCBzdGFydCk7Cj4tCWlmICghdm1hIHx8
IHZtYS0+dm1fc3RhcnQgPiBzdGFydCkKPi0JcmV0dXJuIC1FRkFVTFQ7Cj4rCUJVR19PTighdm1h
KTsKPsKgCj7CoAlwcmV2ID0gdm1hLT52bV9wcmV2Owo+wqAJaWYgKHN0YXJ0ID4gdm1hLT52bV9z
dGFydCkKPi0twqAKPjIuMjIuMA==

