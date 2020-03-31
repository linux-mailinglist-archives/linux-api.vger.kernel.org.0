Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686CF198EA0
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 10:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgCaIfN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 Mar 2020 04:35:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34471 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgCaIfK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 Mar 2020 04:35:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10so20835585ljn.1
        for <linux-api@vger.kernel.org>; Tue, 31 Mar 2020 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=iDZOtcqwokL9nzGzZiVz9Fkwky7/JToasUV7T07+Tv8=;
        b=DgUtQgKMf2pMNzZSmKrIOhR0QGgWWIgFjZcD/oiZDoiLXQKJYftk6Gl6bUWJBVeVhs
         nr6iEXREmkvK3gRDgAPVoa4OTgh+WbY77wXtUmfDw1Rx+fbfFfJo3/ri2UbdTCVvQw6L
         TEQ8O3MJ3DcaVxpvDtlTpxMw5aMwmO7znKoFx4O8/T5nR/v6cEDWVEsT3ZQ57+3aVoP/
         9gJHCfMMc6N9FKXLrBS9yrhZn/fCjvBIVlm3qe6KhaS/PUZX9Oehv7iUsnQaV/5YL5Cv
         awWZ1XLCH5lt1ENo1ZVe4CHwZtelSWw2VJJb3qoRpBijW8KTjdLlWhj056Xpzb//cWb9
         6Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=iDZOtcqwokL9nzGzZiVz9Fkwky7/JToasUV7T07+Tv8=;
        b=N0ZSUKhWQk5ZMQK0+O3UOChG5lw+eid4sMnJH+q4qICdelaD4sYGp5vFSM1pcae3H7
         unmHwGQ4jfeNtt1WdvEkAGkyquNRGvjRYEb8XZwc903kKa0c+b7N2AUIaKGrYWovjXDW
         kXMb0ov9Y+Dd8/BTp2Nm0eGZUjOKXoxeOBWt6uJ9OVAQWjBWQvp6fZOMFX0jCTzyu7uZ
         5z2uphvZHXxLZ40CP/LVf4GZsSoXB/eJ2whDa9nIQnqKVMtYg8bxypRhOvp6Bl9Q7OwG
         tpr222g0kyf6LJ1alvlEVQgTsjFgJqpkIK4z+li23xkYV+6mjBwJCpwuF1EIlwkSBVK+
         OoxA==
X-Gm-Message-State: AGi0PuYsaLODL1EWRnL+kQfZE+0X15PCAEgsxZiDAjUnZAXaJBnMCLQU
        06HhET/3Gfa/2xdAE2m3J3SrG1nL
X-Google-Smtp-Source: APiQypLmgtZWLwXdHYAn+2MPAB2mp2OknckDhy6XsyxUUansBEvQA4qnvMoEXagFxEO9tx6Aege0MQ==
X-Received: by 2002:a2e:3507:: with SMTP id z7mr7093282ljz.111.1585643707998;
        Tue, 31 Mar 2020 01:35:07 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id l6sm7763294ljc.80.2020.03.31.01.35.05
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 01:35:07 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:35:05 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "Mike Kravetz" <mike.kravetz@oracle.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "Linux API" <linux-api@vger.kernel.org>,
        akpm <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: allow checking length for hugetlb mapping in mmap()
References: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com>, 
        <>, 
        <f8b5b647-9041-8127-925c-1c8dcb508f24@nvidia.com>, 
        <2020032916093522557671@gmail.com>, 
        <5e02a305-038f-b86c-31e7-85358563cbc5@oracle.com>
X-Priority: 3
X-GUID: 205FF850-EC2C-4484-B625-562C854F5537
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2020033116350399980494@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAyMC0wMy0zMcKgYXQgMDI6MznCoE1pa2UgS3JhdmV0esKgd3JvdGU6Cj5PbiAzLzI5LzIw
IDE6MDkgQU0sIExpIFhpbmhhaSB3cm90ZToKPj4gT24gMjAyMC0wMy0yOSBhdCAxMTo1MyBKb2hu
IEh1YmJhcmQgd3JvdGU6Cj4+PiBPbiAzLzI4LzIwIDg6MDggUE0sIExpIFhpbmhhaSB3cm90ZToK
Pj4+PiBJbiBjdXJyZW50IGNvZGUsIHRoZSB2bWEgcmVsYXRlZCBjYWxsIG9mIGh1Z2V0bGIgbWFw
cGluZywgZXhjZXB0IG1tYXAsCj4+Pj4gYXJlIGFsbCBjb25zaWRlciBub3QgY29ycmVjdGx5IGFs
aWduZWQgbGVuZ3RoIGFzIGludmFsaWQgcGFyYW1ldGVyLAo+Pj4+IGluY2x1ZGluZyBtcHJvdGVj
dCxtdW5tYXAsIG1sb2NrLCBldGMuLCBieSBjaGVja2luZyB0aHJvdWdoCj4+Pj4gaHVnZXRsYl92
bV9vcF9zcGxpdC4gU28sIHVzZXIgd2lsbCBzZWUgZmFpbHVyZSwgYWZ0ZXIgc3VjY2Vzc2Z1bGx5
IGNhbGwKPj4+PiBtbWFwLCBhbHRob3VnaCB1c2luZyBzYW1lIGxlbmd0aCBwYXJhbWV0ZXIgdG8g
b3RoZXIgbWFwcGluZyBzeXNjYWxsLgo+Pj4+Cj4+Pj4gSXQgaXMgZGVzaXJhYmxlIGZvciBhbGwg
aHVnZXRsYiBtYXBwaW5nIGNhbGxzIGhhdmUgY29uc2lzdGVudCBiZWhhdmlvciwKPj4+PiB3aXRo
b3V0IG1tYXAgYXMgZXhjZXB0aW9uKHdoaWNoIHJvdW5kIHVwIGxlbmd0aCB0byBhbGlnbiB1bmRl
cmx5aW5nCj4+Pj4gaHVnZXBhZ2Ugc2l6ZSkuIEluIGN1cnJlbnQgRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9tbS9odWdldGxicGFnZS5yc3QsCj4+Pj4gdGhlIGRlc2NyaXB0aW9uIGlzOgo+Pj4+
ICIKPj4+PiBTeXNjYWxscyB0aGF0IG9wZXJhdGUgb24gbWVtb3J5IGJhY2tlZCBieSBodWdldGxi
IHBhZ2VzIG9ubHkgaGF2ZSB0aGVpcgo+Pj4+IGxlbmd0aHMgYWxpZ25lZCB0byB0aGUgbmF0aXZl
IHBhZ2Ugc2l6ZSBvZiB0aGUgcHJvY2Vzc29yOyB0aGV5IHdpbGwKPj4+PiBub3JtYWxseSBmYWls
IHdpdGggZXJybm8gc2V0IHRvIEVJTlZBTCBvciBleGNsdWRlIGh1Z2V0bGIgcGFnZXMgdGhhdAo+
Pj4+IGV4dGVuZCBiZXlvbmQgdGhlIGxlbmd0aCBpZiBub3QgaHVnZXBhZ2UgYWxpZ25lZC4gRm9y
IGV4YW1wbGUsIG11bm1hcCgyKQo+Pj4+IHdpbGwgZmFpbCBpZiBtZW1vcnkgaXMgYmFja2VkIGJ5
IGEgaHVnZXRsYiBwYWdlIGFuZCB0aGUgbGVuZ3RoIGlzIHNtYWxsZXIKPj4+PiB0aGFuIHRoZSBo
dWdlcGFnZSBzaXplLgo+Pj4+ICIKPj4+PiB3aGljaCBleHByZXNzIHRoZSBjb25zaXN0ZW50IGJl
aGF2aW9yLgo+Pj4KPj4+Cj4+PiBNaXNzaW5nIGhlcmUgaXMgYSBkZXNjcmlwdGlvbiBvZiB3aGF0
IHRoZSBwYXRjaCBhY3R1YWxseSBkb2VzLi4uCj4+Pgo+Pgo+PiByaWdodCwgbW9yZSBzdGF0ZW1l
bnQgY2FuIGJlIGFkZGVkIGxpa2U6Cj4+ICIKPj4gQWZ0ZXIgdGhpcyBwYXRjaCwgYWxsIGh1Z2V0
bGIgbWFwcGluZyByZWxhdGVkIHN5c2NhbGwgd2lsIG9ubHkgYWxpZ24KPj4gbGVuZ3RoIHBhcmFt
ZXRlciB0byB0aGUgbmF0aXZlIHBhZ2Ugc2l6ZSBvZiB0aGUgcHJvY2Vzc29yLiBGb3IgbW1hcCgp
LAo+PiBodWdldGxiX2dldF91bm1tYXBlZF9hcmVhKCkgd2lsbCBzZXQgZXJybm8gdG8gRUlOVkFM
IGlmIGxlbmd0aCBpcyBub3QKPj4gYWxpZ25lZCB0byB1bmRlcmx5aW5nIGh1Z2VwYWdlIHNpemUu
Cj4+ICIKPj4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IExpIFhpbmhhaSA8bGl4aW5oYWkubHho
QGdtYWlsLmNvbT4KPj4+PiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZz4KPj4+PiBDYzogTWlrZSBLcmF2ZXR6IDxtaWtlLmtyYXZldHpAb3JhY2xlLmNvbT4KPj4+
PiBDYzogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgo+Pj4+IC0tLQo+Pj4+IGNo
YW5nZXM6Cj4+Pj4gMC4gcGF0Y2ggd2hpY2ggaW50cm9kdWNlIG5ldyBmbGFnIGZvciBtbWFwKCkK
Pj4+PsKgwqDCoMKgwqAgVGhlIG5ldyBmbGFnIHNob3VsZCBiZSBhdm9pZGVkLgo+Pj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzE1ODUzMTM5NDQtODYyNy0xLWdpdC1zZW5kLWVt
YWlsLWxpeGluaGFpLmx4aEBnbWFpbC5jb20vCj4KPkl0IGlzIG5vdCBleGFjdGx5IGNsZWFyIGlu
IHlvdXIgY29tbWl0IG1lc3NhZ2UsIGJ1dCB0aGlzIGNoYW5nZSB3aWxsIGNhdXNlCj5tbWFwKCkg
b2YgaHVnZXRsYiByYW5nZXMgdG8gZmFpbCAoLUVJTlZBTCkgaWYgbGVuZ3RoIGlzIG5vdCBhIG11
bHRpcGxlIG9mCj5odWdlIHBhZ2Ugc2l6ZS7CoCBUaGUgbW1hcCBtYW4gcGFnZSBzYXlzOgo+Cj7C
oCBIdWdlIHBhZ2UgKEh1Z2UgVExCKSBtYXBwaW5ncwo+wqDCoMKgwqDCoMKgIEZvciBtYXBwaW5n
cyB0aGF0IGVtcGxveSBodWdlIHBhZ2VzLCB0aGUgcmVxdWlyZW1lbnRzIGZvciB0aGUgYXJndW1l
bnRzCj7CoMKgwqDCoMKgwqAgb2bCoCBtbWFwKCnCoCBhbmQgbXVubWFwKCkgZGlmZmVyIHNvbWV3
aGF0IGZyb20gdGhlIHJlcXVpcmVtZW50cyBmb3IgbWFw4oCQCj7CoMKgwqDCoMKgwqAgcGluZ3Mg
dGhhdCB1c2UgdGhlIG5hdGl2ZSBzeXN0ZW0gcGFnZSBzaXplLgo+Cj7CoMKgwqDCoMKgwqAgRm9y
IG1tYXAoKSwgb2Zmc2V0IG11c3QgYmUgYSBtdWx0aXBsZSBvZiB0aGUgdW5kZXJseWluZyBodWdl
IHBhZ2Ugc2l6ZS4KPsKgwqDCoMKgwqDCoCBUaGUgc3lzdGVtIGF1dG9tYXRpY2FsbHkgYWxpZ25z
IGxlbmd0aCB0byBiZSBhIG11bHRpcGxlIG9mIHRoZSB1bmRlcmx54oCQCj7CoMKgwqDCoMKgwqAg
aW5nIGh1Z2UgcGFnZSBzaXplLgo+Cj7CoMKgwqDCoMKgwqAgRm9yIG11bm1hcCgpLCBhZGRyIGFu
ZCBsZW5ndGggbXVzdCBib3RoIGJlIGEgbXVsdGlwbGUgb2YgdGhlIHVuZGVybHlpbmcKPsKgwqDC
oMKgwqDCoCBodWdlIHBhZ2Ugc2l6ZS4KPgo+U28gdGhpcyBjaGFuZ2UgbWF5IGNhdXNlIGFwcGxp
Y2F0aW9uIGZhaWx1cmUuwqAgVGhlIGNvZGUgeW91IGFyZSByZW1vdmluZyB3YXMKPmFkZGVkIHdp
dGggY29tbWl0IGFmNzNlNGQ5NTA2ZC7CoCBUaGUgY29tbWl0IG1lc3NhZ2UgZm9yIHRoYXQgY29t
bWl0IHNheXM6Cj4KPsKgwqDCoCBodWdldGxiZnM6IGZpeCBtbWFwIGZhaWx1cmUgaW4gdW5hbGln
bmVkIHNpemUgcmVxdWVzdAo+wqDCoMKgCj7CoMKgwqAgVGhlIGN1cnJlbnQga2VybmVsIHJldHVy
bnMgLUVJTlZBTCB1bmxlc3MgYSBnaXZlbiBtbWFwIGxlbmd0aCBpcwo+wqDCoMKgICJhbG1vc3Qi
IGh1Z2VwYWdlIGFsaWduZWQuwqAgVGhpcyBpcyBiZWNhdXNlIGluIHN5c19tbWFwX3Bnb2ZmKCkg
dGhlCj7CoMKgwqAgZ2l2ZW4gbGVuZ3RoIGlzIHBhc3NlZCB0byB2bV9tbWFwX3Bnb2ZmKCkgYXMg
aXQgaXMgd2l0aG91dCBiZWluZyBhbGlnbmVkCj7CoMKgwqAgd2l0aCBodWdlcGFnZSBib3VuZGFy
eS4KPsKgwqDCoAo+wqDCoMKgIFRoaXMgaXMgYSByZWdyZXNzaW9uIGludHJvZHVjZWQgaW4gY29t
bWl0IDQwNzE2ZTI5MjQzZCAoImh1Z2V0bGJmczogZml4Cj7CoMKgwqAgYWxpZ25tZW50IG9mIGh1
Z2UgcGFnZSByZXF1ZXN0cyIpLCB3aGVyZSBhbGlnbm1lbnQgY29kZSBpcyBwdXNoZWQgaW50bwo+
wqDCoMKgIGh1Z2V0bGJfZmlsZV9zZXR1cCgpIGFuZCB0aGUgdmFyaWFibGUgbGVuIGluIGNhbGxl
ciBzaWRlIGlzIG5vdCBjaGFuZ2VkLgo+Cj5UaGUgY2hhbmdlIGluIGNvbW1pdCBhZjczZTRkOTUw
NmQgd2FzIGFkZGVkIGJlY2F1c2UgY2F1c2luZyBtbWFwIHRvIHJldHVybgo+LUVJTlZBTCBpZiBs
ZW5ndGggaXMgbm90IGEgbXVsdGlwbGUgb2YgaHVnZSBwYWdlIHNpemUgd2FzIGNvbnNpZGVyZWQg
YQo+cmVncmVzc2lvbi7CoCBJdCB3b3VsZCBzdGlsbCBiZSBjb25zaWRlcmVkIGEgcmVncmVzc2lv
biB0b2RheS4KPiAKCkFncmVlLCBpdCB3b3VsZCBjYXN1ZSByZWdyZXNzaW9uIHRvZGF5IGlmIHRo
b3NlIHVzZXIgc3BhY2UgYXBwbGljYXRpb24gc3RpbGwgd29yawppbiB0aGF0IHdheS4KCkFmdGVy
IHJlYWQgdGhyb3VnaCB0aGUgYnVnIHJlcG9ydCBwYWdlLCBpdCBpcyBpbmRlZWQgZm9yIHNvbWUg
YXBwbGljYXRpb25zIHdhbnQgdG8KdXNlIG5vdMKgYWxpZ25lZCBzaXplIGZvciBtbWFwKCksIGJ1
dCBkb24ndCBjYXJlIHdoYXQgd2lsbCBoYXBwZW4gaWYgdGhhdCBzaXplIGJlZW4gdXNlZAppbiBz
dWJzZXF1ZW50IGNhbGxzLgoKTXkgdW5kZXJzdGFuZGluZyBtYXkgd3JvbmcsIGJ1dCBpdCBzZWVt
cyB0aGF0IG9uY2Ugc29tZSBhcHBsaWNhdGlvbiBzdGFydCB0byB1c2UKc29tZSBiZWhhdmlvciBv
ZiBrZXJuZWwsIGFsdGhvdWdoIHRoYXQgdXNhZ2UgaW4gdXNlciBzcGFjZSBpcyBub3QgbG9naWNh
bCwgdGhleQp3aWxsIGJlIHByb3RlY3RlZCBmcm9tIGNoYW5nZSBpbiBrZXJuZWwgc2lkZS4KCj5J
IHVuZGVyc3RhbmQgdGhhdCB0aGUgYmVoYXZpb3Igbm90IGNvbnNpc3RlbnQuwqAgSG93ZXZlciwg
aXQgaXMgY2xlYXJseQo+ZG9jdW1lbnRlZC7CoCBJIGRvIG5vdCBiZWxpZXZlIHdlIGNhbiBjaGFu
Z2UgdGhlIGJlaGF2aW9yIG9mIHRoaXMgY29kZS4KPgo+LS0KPk1pa2UgS3JhdmV0eg==

