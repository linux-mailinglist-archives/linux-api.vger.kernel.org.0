Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43B196BD9
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC2IJo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Mar 2020 04:09:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42087 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgC2IJo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Mar 2020 04:09:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so14479687ljp.9
        for <linux-api@vger.kernel.org>; Sun, 29 Mar 2020 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=nfIG8cn5n2jKn60XaCZ4m2Evv6duWnqoHOxTAvuXroc=;
        b=LSlukffnQeidqHJw+H/ywQArEQNfBpeSuTTOgudmCvnMZcKJ8WYRRHLnQoVA/uOQpy
         CGbI3zHZCrt3p1FU1mINwNjepIWt24KmBnPKR8lhSqxy4UFvFS4xIlWUQNlEE7UoY6nE
         z2FahkFUQ4KR6M0ehxHYtibelEe1nKUTGh68OvaF+xcs2RlnXPNjwphi7UZBIT0GAnjF
         2YaGrtYou9aaqkcFnFvN3pnk+qjuydqeF2//G93geP/h5hCWPZM1RSPOZHvjrIWpGX7n
         qeaaSQkgivOuEwQoDBv9eBsL4OO4VK/7HERAHRaDSbCBWFuFSexKCBjOtzBvyc7KB3o3
         vxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=nfIG8cn5n2jKn60XaCZ4m2Evv6duWnqoHOxTAvuXroc=;
        b=mUVvLKXQkOBvgrNwaeEkRP+kw3dVUYXqxxARSBpLpRG8WOkR+tl8qs9K08ASW753ya
         XOYdrSM8P/YNQ96pbPyzJiJd5zJi0pYmqV4LOFF0T1AtKvuCmVbBb1We5MUzH++zXemS
         pZoOAf8dSXX89QHGhtL8FOG/c8HJgkbAdrTttdhCpMwX2FO7cwEmU2QAC1oYhWIWHX0D
         aCuRg3kaYDRofJSKvG6ytYMMtBJStW1PL6y9KcVUHyc6e/xvBCmAIG4oAe7MoJI3344p
         vLZV+YH7NP5n23Y0qy2zfzCwjU9oRzj5M54HilYMRRW3KsP0IPmUBel7UtyRleQX3dqE
         xwlw==
X-Gm-Message-State: AGi0PuYn9Ayz2TIB74KWVWFLtFWcnNkpqvzXM3sh7t7NuH4WTjsdlkdw
        uJYYOcO6woqyMj2BIY4MzgU=
X-Google-Smtp-Source: APiQypI17PLA1euK5hEyobg/043mt/+YoUyBOoWAdZwIbSLsQhqezAKpgX04wPKg0aa9L87v9WU9hg==
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr4128523lji.150.1585469378894;
        Sun, 29 Mar 2020 01:09:38 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id d12sm5724504lfi.86.2020.03.29.01.09.36
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 01:09:38 -0700 (PDT)
Date:   Sun, 29 Mar 2020 16:09:36 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "John Hubbard" <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "Linux API" <linux-api@vger.kernel.org>,
        akpm <akpm@linux-foundation.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: allow checking length for hugetlb mapping in mmap()
References: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com>, 
        <f8b5b647-9041-8127-925c-1c8dcb508f24@nvidia.com>
X-Priority: 3
X-GUID: E72919FA-68BF-475A-B2C4-CA1C9D6727E2
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2020032916093522557671@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAyMC0wMy0yOcKgYXQgMTE6NTPCoEpvaG4gSHViYmFyZMKgd3JvdGU6Cj5PbiAzLzI4LzIw
IDg6MDggUE0sIExpIFhpbmhhaSB3cm90ZToKPj4gSW4gY3VycmVudCBjb2RlLCB0aGUgdm1hIHJl
bGF0ZWQgY2FsbCBvZiBodWdldGxiIG1hcHBpbmcsIGV4Y2VwdCBtbWFwLAo+PiBhcmUgYWxsIGNv
bnNpZGVyIG5vdCBjb3JyZWN0bHkgYWxpZ25lZCBsZW5ndGggYXMgaW52YWxpZCBwYXJhbWV0ZXIs
Cj4+IGluY2x1ZGluZyBtcHJvdGVjdCxtdW5tYXAsIG1sb2NrLCBldGMuLCBieSBjaGVja2luZyB0
aHJvdWdoCj4+IGh1Z2V0bGJfdm1fb3Bfc3BsaXQuIFNvLCB1c2VyIHdpbGwgc2VlIGZhaWx1cmUs
IGFmdGVyIHN1Y2Nlc3NmdWxseSBjYWxsCj4+IG1tYXAsIGFsdGhvdWdoIHVzaW5nIHNhbWUgbGVu
Z3RoIHBhcmFtZXRlciB0byBvdGhlciBtYXBwaW5nIHN5c2NhbGwuCj4+Cj4+IEl0IGlzIGRlc2ly
YWJsZSBmb3IgYWxsIGh1Z2V0bGIgbWFwcGluZyBjYWxscyBoYXZlIGNvbnNpc3RlbnQgYmVoYXZp
b3IsCj4+IHdpdGhvdXQgbW1hcCBhcyBleGNlcHRpb24od2hpY2ggcm91bmQgdXAgbGVuZ3RoIHRv
IGFsaWduIHVuZGVybHlpbmcKPj4gaHVnZXBhZ2Ugc2l6ZSkuIEluIGN1cnJlbnQgRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9tbS9odWdldGxicGFnZS5yc3QsCj4+IHRoZSBkZXNjcmlwdGlvbiBp
czoKPj4gIgo+PiBTeXNjYWxscyB0aGF0IG9wZXJhdGUgb24gbWVtb3J5IGJhY2tlZCBieSBodWdl
dGxiIHBhZ2VzIG9ubHkgaGF2ZSB0aGVpcgo+PiBsZW5ndGhzIGFsaWduZWQgdG8gdGhlIG5hdGl2
ZSBwYWdlIHNpemUgb2YgdGhlIHByb2Nlc3NvcjsgdGhleSB3aWxsCj4+IG5vcm1hbGx5IGZhaWwg
d2l0aCBlcnJubyBzZXQgdG8gRUlOVkFMIG9yIGV4Y2x1ZGUgaHVnZXRsYiBwYWdlcyB0aGF0Cj4+
IGV4dGVuZCBiZXlvbmQgdGhlIGxlbmd0aCBpZiBub3QgaHVnZXBhZ2UgYWxpZ25lZC4gRm9yIGV4
YW1wbGUsIG11bm1hcCgyKQo+PiB3aWxsIGZhaWwgaWYgbWVtb3J5IGlzIGJhY2tlZCBieSBhIGh1
Z2V0bGIgcGFnZSBhbmQgdGhlIGxlbmd0aCBpcyBzbWFsbGVyCj4+IHRoYW4gdGhlIGh1Z2VwYWdl
IHNpemUuCj4+ICIKPj4gd2hpY2ggZXhwcmVzcyB0aGUgY29uc2lzdGVudCBiZWhhdmlvci4KPgo+
Cj5NaXNzaW5nIGhlcmUgaXMgYSBkZXNjcmlwdGlvbiBvZiB3aGF0IHRoZSBwYXRjaCBhY3R1YWxs
eSBkb2VzLi4uCj4gCgpyaWdodCwgbW9yZSBzdGF0ZW1lbnQgY2FuIGJlIGFkZGVkIGxpa2U6CiIK
QWZ0ZXIgdGhpcyBwYXRjaCwgYWxsIGh1Z2V0bGIgbWFwcGluZyByZWxhdGVkIHN5c2NhbGwgd2ls
IG9ubHkgYWxpZ24KbGVuZ3RoIHBhcmFtZXRlciB0byB0aGUgbmF0aXZlIHBhZ2Ugc2l6ZSBvZiB0
aGUgcHJvY2Vzc29yLiBGb3IgbW1hcCgpLApodWdldGxiX2dldF91bm1tYXBlZF9hcmVhKCkgd2ls
bCBzZXQgZXJybm8gdG8gRUlOVkFMIGlmIGxlbmd0aCBpcyBub3QKYWxpZ25lZCB0byB1bmRlcmx5
aW5nIGh1Z2VwYWdlIHNpemUuCiIKCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExpIFhpbmhhaSA8bGl4
aW5oYWkubHhoQGdtYWlsLmNvbT4KPj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+Cj4+IENjOiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFjbGUuY29t
Pgo+PiBDYzogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgo+PiAtLS0KPj4gY2hh
bmdlczoKPj4gMC4gcGF0Y2ggd2hpY2ggaW50cm9kdWNlIG5ldyBmbGFnIGZvciBtbWFwKCkKPj7C
oMKgwqDCoCBUaGUgbmV3IGZsYWcgc2hvdWxkIGJlIGF2b2lkZWQuCj4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW1tLzE1ODUzMTM5NDQtODYyNy0xLWdpdC1zZW5kLWVtYWlsLWxpeGlu
aGFpLmx4aEBnbWFpbC5jb20vCj4+Cj4+wqDCoCBtbS9tbWFwLmMgfCA4IC0tLS0tLS0tCj4+wqDC
oCAxIGZpbGUgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL21tL21t
YXAuYyBiL21tL21tYXAuYwo+PiBpbmRleCBkNjgxYTIwLi5iMmFhMTAyIDEwMDY0NAo+PiAtLS0g
YS9tbS9tbWFwLmMKPj4gKysrIGIvbW0vbW1hcC5jCj4+IEBAIC0xNTYwLDIwICsxNTYwLDEyIEBA
IHVuc2lnbmVkIGxvbmcga3N5c19tbWFwX3Bnb2ZmKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWdu
ZWQgbG9uZyBsZW4sCj4+wqDCoCBmaWxlID0gZmdldChmZCk7Cj4+wqDCoCBpZiAoIWZpbGUpCj4+
wqDCoCByZXR1cm4gLUVCQURGOwo+PiAtCWlmIChpc19maWxlX2h1Z2VwYWdlcyhmaWxlKSkKPj4g
LQlsZW4gPSBBTElHTihsZW4sIGh1Z2VfcGFnZV9zaXplKGhzdGF0ZV9maWxlKGZpbGUpKSk7Cj4K
Pgo+Li4uYW5kIGl0IGxvb2tzIGxpa2UgdGhpcyBpcyBzaW1wbHkgcmVtb3ZpbmcgdGhlIGZvcmNl
ZCBhbGlnbm1lbnQuIEFuZCBub3QgYWRkaW5nCj5hbnkgZXJyb3IgY2FzZSBmb3Igbm9uLWFsaWdu
ZWQgY2FzZXMuIFNvIG5vdyBJJ20gbm90IGltbWVkaWF0ZWx5IHN1cmUgd2hhdCBoYXBwZW5zIGlm
IGEKPm5vbi1hbGlnbmVkIGFkZHJlc3MgaXMgcGFzc2VkIGluLgo+Cj5JIHdvdWxkIGhhdmUgZXhw
ZWN0ZWQgdG8gc2VlIGVpdGhlciBlcnJvciBjaGVja2luZyBvciBhbiBBTElHTiBjYWxsIGhlcmUs
IGJ1dCBub3cgYm90aAo+YXJlIGdvbmUsIHNvIEknbSBsb3N0IGFuZCBjb25mdXNlZC4gOikKPiAK
CkFmdGVyIHRoaXMgcGF0Y2gsIHRoZSBhbGlnbmVtZW50IHdpbGwgb25seSBvbiAibmF0aXZlIHBh
Z2Ugc2l6ZSBvZiB0aGUgcHJvY2Vzc29yIiBhcyBkb25lIGluCmRvX21tYXAoKS4gVGhlbiwgZm9s
bG93aW5nIHRoZSBjb2RlIHBhdGgsIGNoZWNraW5nIGZ1cnRoZXIgYnkgaHVnZXRsYl9nZXRfdW5t
bWFwZWRfYXJlYSgpCmFjY29yZGluZyB0b8KgdW5kZXJseWluZyBodWdlcGFnZSBzaXplLgoKPgo+
dGhhbmtzLAo+LS0KPkpvaG4gSHViYmFyZAo+TlZJRElBCj4KPj7CoMKgIHJldHZhbCA9IC1FSU5W
QUw7Cj4+wqDCoCBpZiAodW5saWtlbHkoZmxhZ3MgJiBNQVBfSFVHRVRMQiAmJiAhaXNfZmlsZV9o
dWdlcGFnZXMoZmlsZSkpKQo+PsKgwqAgZ290byBvdXRfZnB1dDsKPj7CoMKgIH0gZWxzZSBpZiAo
ZmxhZ3MgJiBNQVBfSFVHRVRMQikgewo+PsKgwqAgc3RydWN0IHVzZXJfc3RydWN0ICp1c2VyID0g
TlVMTDsKPj4gLQlzdHJ1Y3QgaHN0YXRlICpoczsKPj7CoMKgCj4+IC0JaHMgPSBoc3RhdGVfc2l6
ZWxvZygoZmxhZ3MgPj4gTUFQX0hVR0VfU0hJRlQpICYgTUFQX0hVR0VfTUFTSyk7Cj4+IC0JaWYg
KCFocykKPj4gLQlyZXR1cm4gLUVJTlZBTDsKPj4gLQo+PiAtCWxlbiA9IEFMSUdOKGxlbiwgaHVn
ZV9wYWdlX3NpemUoaHMpKTsKPj7CoMKgIC8qCj4+wqDCoCAqIFZNX05PUkVTRVJWRSBpcyB1c2Vk
IGJlY2F1c2UgdGhlIHJlc2VydmF0aW9ucyB3aWxsIGJlCj4+wqDCoCAqIHRha2VuIHdoZW4gdm1f
b3BzLT5tbWFwKCkgaXMgY2FsbGVkCj4+

