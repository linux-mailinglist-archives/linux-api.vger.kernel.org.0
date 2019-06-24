Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA450C4F
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfFXNsS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 09:48:18 -0400
Received: from m13-129.163.com ([220.181.13.129]:16837 "EHLO m13-129.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfFXNsS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 24 Jun 2019 09:48:18 -0400
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 09:48:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=aUGKt
        vZSy+6o0S9PVtKxbkzfcp42LXfJggJvKQBcobw=; b=mQly/kqzO1oiR3doEt8hS
        ppAyTx2uccPH4rQaW6E2hG79FGTcWdoLaP4/usBjKU2gFnZ6g0P1Qr5yI5bZGeqw
        nMLcNJNkKT9jAvWPUFg2jPFPiJ2mlOTez343k0d5uFJ+Tnw2Sd7t8QRdjMDgLSQz
        ZOuiDhAZpZrNIfxQpY2au4=
Received: from weijieut$163.com ( [121.237.48.209] ) by
 ajax-webmail-wmsvr129 (Coremail) ; Mon, 24 Jun 2019 21:30:10 +0800 (CST)
X-Originating-IP: [121.237.48.209]
Date:   Mon, 24 Jun 2019 21:30:10 +0800 (CST)
From:   "Weijie Yang" <weijieut@163.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     axboe@fb.com, fengguang.wu@intel.com, linux-api@vger.kernel.org,
        "weijie.yang@samsung.com" <weijie.yang@samsung.com>
Subject: [bug report] read-ahead can't work properly
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <37a8bb5a.af8b.16b89adff5d.Coremail.weijieut@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: gcGowADXbfJi0BBdeBX+AA--.3677W
X-CM-SenderInfo: xzhlyxxhxwqiywtou0bp/xtbBDQLdsFaD5oP5fAAAsX
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

CldoZW4gdHJ5IHRoZSBmaWxlIHJlYWRhaGVhZCBieSBwb3NpeF9mYWR2aXNlKCksIEkgZmluZCBp
dCBjYW4ndCB3b3JrIHByb3Blcmx5LgoKRm9yIGV4YW1wbGUsIHBvc2l4X2ZhZHZpc2UoUE9TSVhf
RkFEVl9XSUxMTkVFRCkgYSAxME1CIGZpbGUsIHRoZSBrZXJuZWwKYWN0dWFsbHkgIHJlYWRhaGVh
ZCBvbmx5IDUxMktCIGRhdGEgdG8gdGhlIHBhZ2UgY2FjaGUsIGV2ZW4gaWYgdGhlcmUgYXJlIGVu
b3VnaApmcmVlIG1lbW9yeSBpbiB0aGUgbWFjaGluZS4KCldoZW4gdHJhY2UgdG8ga2VybmVsLCBJ
IGZpbmQgdGhlIGlzc3VlIGlzIGF0IGZvcmNlX3BhZ2VfY2FjaGVfcmVhZGFoZWFkKCk6CiAKICAg
ICAgICBtYXhfcGFnZXMgPSBtYXhfdCh1bnNpZ25lZCBsb25nLCBiZGktPmlvX3BhZ2VzLCByYS0+
cmFfcGFnZXMpOwogICAgICAgIG5yX3RvX3JlYWQgPSBtaW4obnJfdG9fcmVhZCwgbWF4X3BhZ2Vz
KTsKCk5vIG1hdGVyIHdoYXQgaW5wdXQgbnJfdG9fcmVhZCBpcywgaXQgaXMgbGltaXRlZCB0byBh
IHZlcnkgc21hbGwgc2l6ZSwgc3VjaCBhcyAxMjggcGFnZXMuCgpJIHRoaW5rIHRoZSBtaW4oKSBs
aW1pdCBjb2RlIGlzIHRvIGxpbWl0IHBlci1kaXNrLWlvIHNpemUsIG5vdCB0aGUgdG90YWwgbnJf
dG9fcmVhZC4KYW5kIHRyYWNlIHRoZSBnaXQgbG9nLCB0aGlzIGlzc3VlIGlzIGludHJvZHVjZWQg
YnkgNmQyYmU5MTVlNTg5CmFmdGVyIHRoYXQsIG5yX3RvX3JlYWQgaXMgbGltaXRlZCBhdCBzbWFs
bCwgZXZlbiBpZiB0aGVyZSBhcmUgZW5vdWdoIGZyZWUgbWVtb3J5LgpiZWZvcmUgdGhhdCwgdXNl
ciBjYW4gcmVhZGFoZWFkIGEgdmVyeSBsYXJnZSBmaWxlIGlmIHRoZXkgaGF2ZSBlbm91Z2ggbWVt
b3J5LgoKV2hlbiByZWFkIHRoZSBwb3NpeF9mYWR2aXNlKCkgbWFuLXBhZ2UsIGl0IHNheXMgcmVh
ZGFoZWFkIGRhdGEgZGVwZW5kaW5nIG9uCnZpcnR1YWwgbWVtb3J5IGxvYWQuIApTbyBpZiB0aGVy
ZSBhcmUgZW5vdWdoIG1lbW9yeSwgaXQgc2hvdWxkIHJlYWQgYXMgbWFueSBkYXRhIGFzIHVzZXIg
ZXhwZWN0ZWQuCgpFeHBlY3Qgc29tZW9uZSBjYW4gY2xhcmlmeSBvci9hbmQgZml4IGl0LiAKClRo
YW5rcyAKCgoKCg==
