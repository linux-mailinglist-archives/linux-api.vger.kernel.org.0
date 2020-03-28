Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32641196312
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2020 03:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgC1CUF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Mar 2020 22:20:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41683 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1CUF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Mar 2020 22:20:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id z23so9489817lfh.8
        for <linux-api@vger.kernel.org>; Fri, 27 Mar 2020 19:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=6kTAzk4E7LlwXW6lIU0+VI4nFEnSXMflGO25gvKSnN8=;
        b=LAunUqUFS9WVR8uP6krysBocg8EvmhzuVlEMAGMGxK0+IfmDiRd2rkE91AJ+q5gvVd
         XknsqKSNLSoTstzxiw15EYhxx9vx/DvLVCIPK43y54+DKIwEk1uiiP2sfAJiirGZHjq2
         jz7aU0jTUTqinPu15fs3cfxSlE9mabkBvjqZFCbkkpYbGkFEKqKnj8wz7DSZMdgDE/ME
         WybS6ZhOyoVe77/WLBfuwCfkkAGl+IkCT2+8rsP/7oG4lMBHAKtaClL1dFYBLFNH06MK
         J+O3m4HX6s7k0BR2V1U92lisht/HVykqGLdigRw/qiQGdlzhrYL0eHNwx2E+ZJdFEHPM
         49ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=6kTAzk4E7LlwXW6lIU0+VI4nFEnSXMflGO25gvKSnN8=;
        b=S7/Nol3stoN5083whiRWJkIpCskHQlACy4xFG9KWXq/OdR89YWtrS+JDAcGWdHWxFH
         urw+g4SxyP7IVRMTasPD16p6udkwlZ1YzDa9VQ+uuljJSEhMvgmU+z8Gdn1FlGyySUUb
         mhJCf6K9xRs6qg+n01YWocMBPoWDhxgF9jhbZDck7ca556u07IT6n6+fCI5vUD0Xr54t
         SDW5DWTttee3UdSyzrGEiKts2FCOEpgE/S2qT3U/8+qLv3qHuCpvthCCCKM/r+Rdh2dN
         IE7chO3EOvrD5GxNoOh23hC5vdhy7dkCLcvaLw0AEJKS6tonK9lvQlEwfbiy0SkZVdfk
         3nKQ==
X-Gm-Message-State: AGi0PubMveOXgrs0IpDVjRu2jO449ajkbAbGc2Jy56cvOPRcghxu48Zz
        nriJaM34HN3ra6T0IEfpnf0=
X-Google-Smtp-Source: APiQypLqf3r+TvSoHMoJaXqR2UEqE9MOt2wKn/Xfb0HQ7ZNd93/MRFT20TEkUSikJu2KAbpzl5r+fg==
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr1320363lfq.16.1585362001518;
        Fri, 27 Mar 2020 19:20:01 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id l11sm3753552lfg.87.2020.03.27.19.19.59
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2020 19:20:01 -0700 (PDT)
Date:   Sat, 28 Mar 2020 10:19:59 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "Mike Kravetz" <mike.kravetz@oracle.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Linux API" <linux-api@vger.kernel.org>
Cc:     akpm <akpm@linux-foundation.org>
Subject: Re: Re: [PATCH] mm: introduce MAP_FIXED_HUGETLB_LEN to mmap()
References: <1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com>, 
        <a3444ac1-90d3-83fa-fd7b-85ea77c6e0ff@nvidia.com>, 
        <0de74135-200f-ce91-3f27-5ab759220c9d@oracle.com>
X-Priority: 3
X-GUID: 2FD015B4-7EA5-4DFD-8759-5A8251224820
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2020032810195804815050@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAyMC0wMy0yOMKgYXQgMDk6MzHCoE1pa2UgS3JhdmV0esKgd3JvdGU6Cj5PbiAzLzI3LzIw
IDEyOjEyIFBNLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4+IE9uIDMvMjcvMjAgNTo1OSBBTSwgTGkg
WGluaGFpIHdyb3RlOgo+Pj4gVGhlIHB1cnBvc2Ugb2YgTUFQX0ZJWEVEX0hVR0VUTEJfTEVOIGlz
IHRvIGNoZWNrIHdoZXRoZXIgdGhlIHBhcmFtZXRlcgo+Pj4gbGVuZ3RoIGlzIHZhbGlkIG9yIG5v
dCBhY2NvcmRpbmcgdG8gdGhlIHRhcmdldCBmaWxlJ3MgaHVnZSBwYWdlIHNpemUuCj4+PiBXaGVu
IGl0IGlzIHVzZWQsIGlmIGxlbmd0aCBpcyBub3QgYWxpZ25lZCB0byB1bmRlcmx5aW5nIGh1Z2Ug
cGFnZSBzaXplLAo+Pj4gbW1hcCgpIGlzIGZhaWxlZCB3aXRoIGVycm5vIHNldCB0byBFSU5WQUwu
IFdoZW4gaXQgaXMgbm90IHVzZWQsIHRoZQo+Pj4gY3VycmVudCBzZW1hbnRpYyBpcyBtYWludGFp
bmVkLCBpLmUuLCBsZW5ndGggaXMgcm91bmQgdXAgdG8gdW5kZXJseWluZwo+Pj4gaHVnZSBwYWdl
IHNpemUuCj4+Pgo+Pj4gSW4gY3VycmVudCBjb2RlLCB0aGUgdm1hIHJlbGF0ZWQgY2FsbCwgZXhj
ZXB0IG1tYXAsIGFyZSBhbGwgY29uc2lkZXIKPj4+IG5vdCBjb3JyZWN0bHkgYWxpZ25lZCBsZW5n
dGggYXMgaW52YWxpZCBwYXJhbWV0ZXIsIGluY2x1ZGluZyBtcHJvdGVjdCwKPj4+IG11bm1hcCwg
bWxvY2ssIGV0Yy4sIGJ5IGNoZWNraW5nIHRocm91Z2ggaHVnZXRsYl92bV9vcF9zcGxpdC4gU28s
IHVzZXIKPj4+IHdpbGwgc2VlIGZhaWx1cmUsIGFmdGVyIHN1Y2Nlc3NmdWxseSBjYWxsIG1tYXAs
IGFsdGhvdWdoIHVzaW5nIHNhbWUKPj4+IGxlbmd0aCBwYXJhbWV0ZXIgdG8gb3RoZXIgbWFwcGlu
ZyBzeXNjYWxsLgo+Pj4KPj4+IFdpdGggTUFQX0ZJWEVEX0hVR0VUTEJfTEVOLCB1c2VyIGNhbiBj
aG9vc2UgdG8gY2hlY2sgaWYgbGVuZ3RoIGlzCj4+PiBjb3JyZWN0bHkgYWxpZ25lZCBhdCBmaXJz
dCBwbGFjZSB3aGVuIGNhbGwgbW1hcCwgaW5zdGVhZCBvZiBmYWlsdXJlIGFmdGVyCj4+PiBtYXBw
aW5nIGhhcyBiZWVuIGNyZWF0ZWQuCj4+Cj4+IEhpIExpLAo+Pgo+PiBUaGlzIGlzIG5vdCB3b3J0
aCBjcmVhdGluZyBhIG5ldyBNQVBfIGZsYWcuIElmIHlvdSBsb29rIGF0IHRoZSBleGlzdGluZyBm
bGFncwo+PiB5b3Ugd2lsbCBzZWUgdGhhdCB0aGV5IGFyZSBib3RoIGxpbWl0ZWQgYW5kIGNhcmVm
dWxseSBjaG9zZW4sIHNvIGFzIHRvIGNvdmVyCj4+IGEgcmVhc29uYWJsZSBjaHVuayBvZiBmdW5j
dGlvbmFsaXR5IHBlciBmbGFnLiBXZSBkb24ndCBqdXN0IGRyb3AgaW4gYSBmbGFnCj4+IGZvciB0
aW55IGNvcm5lciBjYXNlcyBsaWtlIHRoaXMgb25lLgo+Pgo+PiBidHcsIHJlbWVtYmVyIHRoYXQg
dXNlciBBUEkgY2hhbmdlcyByZXF1aXJlIG1hbiBwYWdlcyB1cGRhdGVzIGFzIHdlbGwuIEFuZAo+
PiB0aGF0IHRoZSBBUEkgaGFzIHRvIGJlIHN1cHBvcnRlZCBmb3JldmVyLiBBbmQgdGhhdCBpZiB3
ZSB1c2UgdXAgdmFsdWFibGUKPj4gZmxhZyBzbG90cyBvbiB0cml2aWEgdGhlbiB3ZSdsbCBydW4g
b3V0IG9mIGZsYWdzIHF1aXRlIHNvb24sIGFuZCB3b24ndCBiZQo+PiBhYmxlIHRvIGRvIGJyb2Fk
ZXIsIG1vcmUgaW1wb3J0YW50IHVwZ3JhZGVzLgo+Pgo+PiBBbHNvLCB3ZSBuZWVkIHRvIGluY2x1
ZGUgYSB1c2VyIHNwYWNlIEFQSSBtYWlsaW5nIGxpc3QgZm9yIHRoaW5ncyB0aGF0Cj4+IGFmZmVj
dCB0aGF0LiBBZGRpbmcgdGhlbSBub3c6IExpbnV4IEFQSSA8bGludXgtYXBpQHZnZXIua2VybmVs
Lm9yZz4KPj4gVGhlIG1hbiBwYWdlcyBtYWlsaW5nIGxpc3Qgd2lsbCBhbHNvIGJlIG5lZWRlZCBp
ZiB3ZSBnbyB0aGVyZS4KPj4KPj4gTGV0J3MgdGFrZSBhIGNsb3NlciBsb29rIGF0IHlvdXIgcHJv
YmxlbSBhbmQgc2VlIHdoYXQgaXQgdGFrZXMgdG8gc29sdmUgaXQuCj4+IElmIHdlIG5lZWQgc29t
ZSBzb3J0IG9mIGZsYWcgdG8gbW1hcCgpIG9yIG90aGVyIHJvdXRpbmVzLCBmaW5lLiBCdXQgc28g
ZmFyLAo+PiBJIGNhbiBzZWUgYXQgbGVhc3QgdHdvIHNvbHV0aW9ucyB0aGF0IGFyZSBtdWNoIGVh
c2llcjoKPgo+SSB0b28gcXVlc3Rpb24gdGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgcGF0Y2guwqAg
SXMgaXQgc2ltcGx5IHRvIGVsaW1pbmF0ZSBzb21lCj5vZiB0aGUgaHVnZXRsYiBzcGVjaWFsIGJl
aGF2aW9yIGFuZCBtYWtlIGl0IGJlaGF2ZSBtb3JlIGxpa2UgdGhlIHJlc3Qgb2YgbW0/Cj4gCj4+
IFNvbHV0aW9uIGlkZWEgIzI6IGp1c3QgZG8gdGhlIGxlbmd0aCBjaGVjayB1bmNvbmRpdGlvbmFs
bHkgaGVyZSAod2l0aG91dCBsb29raW5nCj4+IGF0IGEgbmV3IGZsYWcpLCBhbmQgcmV0dXJuIGFu
IGVycm9yIGlmIGl0IGlzIG5vdCBhbGlnbmVkLiBBbmQgc2FtZSB0aGluZyBmb3IgdGhlCj4+IE1B
UF9IVUdFVExCIGNhc2UgYmVsb3cuIEFuZCBkZWxldGUgdGhlICJsZW4gPSBBTElHTihsZW4sIGh1
Z2VfcGFnZV9zaXplKGhzKSk7IiBpbgo+PiBib3RoIGNhc2VzLgo+Pgo+PiBUaGF0IHdvdWxkIHN0
aWxsIHJlcXVpcmUgYSBtYW4gcGFnZSB1cGRhdGUsIGFuZCBjb25zZW5zdXMgdGhhdCBpdCB3b24n
dCBCcmVhawo+PiBUaGUgV29ybGQsIGJ1dCBpdCdzIHBvc3NpYmxlIChJIHJlYWxseSBkb24ndCBr
bm93KSB0aGF0IHRoaXMgaXMgYSBtb3JlIGNvbW1vbgo+PiBhbmQgZGVzaXJhYmxlIGJlaGF2aW9y
Lgo+Pgo+PiBMZXQncyBzZWUgaWYgYW55b25lIGVsc2Ugd2VpZ2hzIGluIGFib3V0IHRoaXMuCj4K
PlRoYXQgY2VydGFpbmx5IHdvdWxkIGJlIHRoZSBlYXNpZXN0IHRoaW5nIHRvIGRvLsKgIEhvd2V2
ZXIsIEknbSBndWVzc2luZwo+dGhlIGN1cnJlbnQgYmVoYXZpb3Igd2FzIGFkZGVkIHdoZW4gaHVn
ZXRsYiBtbWFwIHN1cHBvcnQgd2FzIGFkZGVkLsKgIAoKPlRoZXJlIGlzIG5vIHRlbGxpbmcgaG93
IG1hbnkgYXBwbGljYXRpb25zIG1pZ2h0IGJyZWFrIGlmIHdlIGNoYW5nZSB0aGUgYmVoYXZpb3Iu
Cj5JJ20gZ3Vlc3NpbmcgdGhpcyBpcyB0aGUgcmVhc29uIExpIGNob3NlIHRvIG9ubHkgY2hhbmdl
IHRoZSBiZWhhdmlvciBpZgo+YSBuZXcgZmxhZyB3YXMgc3BlY2lmaWVkLiAKWWVzLCBJIHdhcyBj
b25zaWRlcmluZyB0aGlzIGNoYW5nZSB3b3VsZCBicmVhayBzb21ldGhpbmcuCgo+LS0KPk1pa2Ug
S3JhdmV0eg==

