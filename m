Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D86196AD7
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 05:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC2DUh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Mar 2020 23:20:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgC2DUh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Mar 2020 23:20:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so6605338ljg.13
        for <linux-api@vger.kernel.org>; Sat, 28 Mar 2020 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=3X9DMgyygqr3V86o7kUBkGOr5Rjz8N77oVPWd+Q3v1U=;
        b=oHH6efB3dPOubJ7smouilbN+FYmO7HTpulTzt4R3r+L0XB2skWrE7z2qttXVQUSo1v
         OsEmVWw4phzv+3GTOSU+Lg5WthgPicgyERcTwfzy2/1gMLpJpi6ATEgUdqUdaKwZpidU
         ak1/++sLxEgibesDHwqLFi5VMeHFWv20AP0soXP0NOWj/umhg8tuReiuSaJ7mr7W+eAk
         smQf7qJ5Lep/yrsIJ8vEzetMnGLu6Lm+UzC4TOor1HWOzbLAGcHE8TkwfmTmiKk4C1Y9
         +F8OoTfYdRXZEzAnrWt53cYOoe92Dhnoa84FPdRHvgPEFiuT83UzdBBvWk+80JCn7q63
         OIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=3X9DMgyygqr3V86o7kUBkGOr5Rjz8N77oVPWd+Q3v1U=;
        b=Q03/39I54YTGvzG5wvZi8Eb/BWe7xF5pOiJzqJE5mIADfV3gK1SrgBUQf8TaXHMcBK
         77daCygDProuz2rSq48vDgP4DLY8RzX1LHh1MtXu2RgkGHQUEcOQqbCK2Nb9+Ky/fLRb
         M/dz32qRVAoIaueZ3l0jEFCSuUqfsQ9FIHALM8eO2OwM/e/gy5vwtZEUuCVsYdyotjCr
         XgBvlsA/jBKBo9KjQF0fpQhYJqDr3Y42gBaKbTGKqRb0jCDZZYlKBwtq4BVn2olAF5+N
         hTAzMP2WGb0iXAQ1mAZyO4NSYJIeOZScpTckcFv+mN4kepcG0lxzycSUA/UpvCzs5ap5
         R18g==
X-Gm-Message-State: AGi0PuZIMuUx7rViuhAsrlb8IPBkF1ZTIwpiq9IogcZRkhzSfhJXN+Am
        99DhXf+4Iu0Hw3sqka9xmGQ=
X-Google-Smtp-Source: APiQypIf2gKDxSV/GJaevXbYRMlUM7PEwEn5Za67t2i/Md5bEK3Mbn3zqDk/xysLQb03Mqkm+AZgKg==
X-Received: by 2002:a2e:86c6:: with SMTP id n6mr3660883ljj.46.1585452032753;
        Sat, 28 Mar 2020 20:20:32 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id r16sm1370632ljj.40.2020.03.28.20.20.30
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 20:20:31 -0700 (PDT)
Date:   Sun, 29 Mar 2020 11:20:30 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "Mike Kravetz" <mike.kravetz@oracle.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Linux API" <linux-api@vger.kernel.org>
Cc:     akpm <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: introduce MAP_FIXED_HUGETLB_LEN to mmap()
References: <1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com>, 
        <a3444ac1-90d3-83fa-fd7b-85ea77c6e0ff@nvidia.com>, 
        <0de74135-200f-ce91-3f27-5ab759220c9d@oracle.com>, 
        <2020032810195804815050@gmail.com>
X-Priority: 3
X-GUID: C1C6BB4F-B71E-4A37-9544-B4DB7D8E2D02
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2020032911202894721456@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAyMC0wMy0yOMKgYXQgMTA6MTnCoExpIFhpbmhhacKgd3JvdGU6Cj5PbiAyMDIwLTAzLTI4
wqBhdCAwOTozMcKgTWlrZSBLcmF2ZXR6wqB3cm90ZToKPj5PbiAzLzI3LzIwIDEyOjEyIFBNLCBK
b2huIEh1YmJhcmQgd3JvdGU6Cj4+PiBPbiAzLzI3LzIwIDU6NTkgQU0sIExpIFhpbmhhaSB3cm90
ZToKPj4+PiBUaGUgcHVycG9zZSBvZiBNQVBfRklYRURfSFVHRVRMQl9MRU4gaXMgdG8gY2hlY2sg
d2hldGhlciB0aGUgcGFyYW1ldGVyCj4+Pj4gbGVuZ3RoIGlzIHZhbGlkIG9yIG5vdCBhY2NvcmRp
bmcgdG8gdGhlIHRhcmdldCBmaWxlJ3MgaHVnZSBwYWdlIHNpemUuCj4+Pj4gV2hlbiBpdCBpcyB1
c2VkLCBpZiBsZW5ndGggaXMgbm90IGFsaWduZWQgdG8gdW5kZXJseWluZyBodWdlIHBhZ2Ugc2l6
ZSwKPj4+PiBtbWFwKCkgaXMgZmFpbGVkIHdpdGggZXJybm8gc2V0IHRvIEVJTlZBTC4gV2hlbiBp
dCBpcyBub3QgdXNlZCwgdGhlCj4+Pj4gY3VycmVudCBzZW1hbnRpYyBpcyBtYWludGFpbmVkLCBp
LmUuLCBsZW5ndGggaXMgcm91bmQgdXAgdG8gdW5kZXJseWluZwo+Pj4+IGh1Z2UgcGFnZSBzaXpl
Lgo+Pj4+Cj4+Pj4gSW4gY3VycmVudCBjb2RlLCB0aGUgdm1hIHJlbGF0ZWQgY2FsbCwgZXhjZXB0
IG1tYXAsIGFyZSBhbGwgY29uc2lkZXIKPj4+PiBub3QgY29ycmVjdGx5IGFsaWduZWQgbGVuZ3Ro
IGFzIGludmFsaWQgcGFyYW1ldGVyLCBpbmNsdWRpbmcgbXByb3RlY3QsCj4+Pj4gbXVubWFwLCBt
bG9jaywgZXRjLiwgYnkgY2hlY2tpbmcgdGhyb3VnaCBodWdldGxiX3ZtX29wX3NwbGl0LiBTbywg
dXNlcgo+Pj4+IHdpbGwgc2VlIGZhaWx1cmUsIGFmdGVyIHN1Y2Nlc3NmdWxseSBjYWxsIG1tYXAs
IGFsdGhvdWdoIHVzaW5nIHNhbWUKPj4+PiBsZW5ndGggcGFyYW1ldGVyIHRvIG90aGVyIG1hcHBp
bmcgc3lzY2FsbC4KPj4+Pgo+Pj4+IFdpdGggTUFQX0ZJWEVEX0hVR0VUTEJfTEVOLCB1c2VyIGNh
biBjaG9vc2UgdG8gY2hlY2sgaWYgbGVuZ3RoIGlzCj4+Pj4gY29ycmVjdGx5IGFsaWduZWQgYXQg
Zmlyc3QgcGxhY2Ugd2hlbiBjYWxsIG1tYXAsIGluc3RlYWQgb2YgZmFpbHVyZSBhZnRlcgo+Pj4+
IG1hcHBpbmcgaGFzIGJlZW4gY3JlYXRlZC4KPj4+Cj4+PiBIaSBMaSwKPj4+Cj4+PiBUaGlzIGlz
IG5vdCB3b3J0aCBjcmVhdGluZyBhIG5ldyBNQVBfIGZsYWcuIElmIHlvdSBsb29rIGF0IHRoZSBl
eGlzdGluZyBmbGFncwo+Pj4geW91IHdpbGwgc2VlIHRoYXQgdGhleSBhcmUgYm90aCBsaW1pdGVk
IGFuZCBjYXJlZnVsbHkgY2hvc2VuLCBzbyBhcyB0byBjb3Zlcgo+Pj4gYSByZWFzb25hYmxlIGNo
dW5rIG9mIGZ1bmN0aW9uYWxpdHkgcGVyIGZsYWcuIFdlIGRvbid0IGp1c3QgZHJvcCBpbiBhIGZs
YWcKPj4+IGZvciB0aW55IGNvcm5lciBjYXNlcyBsaWtlIHRoaXMgb25lLgo+Pj4KPj4+IGJ0dywg
cmVtZW1iZXIgdGhhdCB1c2VyIEFQSSBjaGFuZ2VzIHJlcXVpcmUgbWFuIHBhZ2VzIHVwZGF0ZXMg
YXMgd2VsbC4gQW5kCj4+PiB0aGF0IHRoZSBBUEkgaGFzIHRvIGJlIHN1cHBvcnRlZCBmb3JldmVy
LiBBbmQgdGhhdCBpZiB3ZSB1c2UgdXAgdmFsdWFibGUKPj4+IGZsYWcgc2xvdHMgb24gdHJpdmlh
IHRoZW4gd2UnbGwgcnVuIG91dCBvZiBmbGFncyBxdWl0ZSBzb29uLCBhbmQgd29uJ3QgYmUKPj4+
IGFibGUgdG8gZG8gYnJvYWRlciwgbW9yZSBpbXBvcnRhbnQgdXBncmFkZXMuCj4+Pgo+Pj4gQWxz
bywgd2UgbmVlZCB0byBpbmNsdWRlIGEgdXNlciBzcGFjZSBBUEkgbWFpbGluZyBsaXN0IGZvciB0
aGluZ3MgdGhhdAo+Pj4gYWZmZWN0IHRoYXQuIEFkZGluZyB0aGVtIG5vdzogTGludXggQVBJIDxs
aW51eC1hcGlAdmdlci5rZXJuZWwub3JnPgo+Pj4gVGhlIG1hbiBwYWdlcyBtYWlsaW5nIGxpc3Qg
d2lsbCBhbHNvIGJlIG5lZWRlZCBpZiB3ZSBnbyB0aGVyZS4KPj4+Cj4+PiBMZXQncyB0YWtlIGEg
Y2xvc2VyIGxvb2sgYXQgeW91ciBwcm9ibGVtIGFuZCBzZWUgd2hhdCBpdCB0YWtlcyB0byBzb2x2
ZSBpdC4KPj4+IElmIHdlIG5lZWQgc29tZSBzb3J0IG9mIGZsYWcgdG8gbW1hcCgpIG9yIG90aGVy
IHJvdXRpbmVzLCBmaW5lLiBCdXQgc28gZmFyLAo+Pj4gSSBjYW4gc2VlIGF0IGxlYXN0IHR3byBz
b2x1dGlvbnMgdGhhdCBhcmUgbXVjaCBlYXNpZXI6Cj4+Cj4+SSB0b28gcXVlc3Rpb24gdGhlIG1v
dGl2YXRpb24gZm9yIHRoaXMgcGF0Y2guwqAgSXMgaXQgc2ltcGx5IHRvIGVsaW1pbmF0ZSBzb21l
Cj4+b2YgdGhlIGh1Z2V0bGIgc3BlY2lhbCBiZWhhdmlvciBhbmQgbWFrZSBpdCBiZWhhdmUgbW9y
ZSBsaWtlIHRoZSByZXN0IG9mIG1tPwo+Pgo+Pj4gU29sdXRpb24gaWRlYSAjMjoganVzdCBkbyB0
aGUgbGVuZ3RoIGNoZWNrIHVuY29uZGl0aW9uYWxseSBoZXJlICh3aXRob3V0IGxvb2tpbmcKPj4+
IGF0IGEgbmV3IGZsYWcpLCBhbmQgcmV0dXJuIGFuIGVycm9yIGlmIGl0IGlzIG5vdCBhbGlnbmVk
LiBBbmQgc2FtZSB0aGluZyBmb3IgdGhlCj4+PiBNQVBfSFVHRVRMQiBjYXNlIGJlbG93LiBBbmQg
ZGVsZXRlIHRoZSAibGVuID0gQUxJR04obGVuLCBodWdlX3BhZ2Vfc2l6ZShocykpOyIgaW4KPj4+
IGJvdGggY2FzZXMuCj4+Pgo+Pj4gVGhhdCB3b3VsZCBzdGlsbCByZXF1aXJlIGEgbWFuIHBhZ2Ug
dXBkYXRlLCBhbmQgY29uc2Vuc3VzIHRoYXQgaXQgd29uJ3QgQnJlYWsKPj4+IFRoZSBXb3JsZCwg
YnV0IGl0J3MgcG9zc2libGUgKEkgcmVhbGx5IGRvbid0IGtub3cpIHRoYXQgdGhpcyBpcyBhIG1v
cmUgY29tbW9uCj4+PiBhbmQgZGVzaXJhYmxlIGJlaGF2aW9yLgo+Pj4KPj4+IExldCdzIHNlZSBp
ZiBhbnlvbmUgZWxzZSB3ZWlnaHMgaW4gYWJvdXQgdGhpcy4KPj4KPj5UaGF0IGNlcnRhaW5seSB3
b3VsZCBiZSB0aGUgZWFzaWVzdCB0aGluZyB0byBkby7CoCBIb3dldmVyLCBJJ20gZ3Vlc3NpbmcK
Pj50aGUgY3VycmVudCBiZWhhdmlvciB3YXMgYWRkZWQgd2hlbiBodWdldGxiIG1tYXAgc3VwcG9y
dCB3YXMgYWRkZWQuwqAKPgo+PlRoZXJlIGlzIG5vIHRlbGxpbmcgaG93IG1hbnkgYXBwbGljYXRp
b25zIG1pZ2h0IGJyZWFrIGlmIHdlIGNoYW5nZSB0aGUgYmVoYXZpb3IuCj4+SSdtIGd1ZXNzaW5n
IHRoaXMgaXMgdGhlIHJlYXNvbiBMaSBjaG9zZSB0byBvbmx5IGNoYW5nZSB0aGUgYmVoYXZpb3Ig
aWYKPj5hIG5ldyBmbGFnIHdhcyBzcGVjaWZpZWQuCj5ZZXMsIEkgd2FzIGNvbnNpZGVyaW5nIHRo
aXMgY2hhbmdlIHdvdWxkIGJyZWFrIHNvbWV0aGluZy4KPiAKSXQncyBiZXR0ZXIgdG8gaGF2ZSBh
IG5ldyBwYXRjaCB3aGljaCBkb24ndCBpbnRyb2R1Y2UgbmV3IGZsYWcsIGFuZCBJIGF0dGFjaGVk
CnN0YXRlbWVudHMgZnJvbSB0aGUga2VybmVsIGRvY3VtZW50LgpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1hcGkvMTU4NTQ1MTI5NS0yMjMwMi0xLWdpdC1zZW5kLWVtYWlsLWxpeGluaGFp
Lmx4aEBnbWFpbC5jb20vCgpMZXQncyBoYXZlIGZ1cnRoZXIgY2hlY2ssIHRoYW5rcyEKCj4+LS0K
Pj5NaWtlIEtyYXZldHo=

