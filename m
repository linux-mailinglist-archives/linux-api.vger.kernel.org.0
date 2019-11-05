Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD6EF371
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfKEC3r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 Nov 2019 21:29:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45439 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfKEC3r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 Nov 2019 21:29:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id q13so19454948wrs.12;
        Mon, 04 Nov 2019 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=PdCxIC9kgvzitGViQuvGUCEVY1YRU/tDisQccY12nsw=;
        b=Y1OM1AnD545zdg0YBT3OVjAJ5W11si9KQcoAEhSUgr1gSrSyO8vq/N22MFRJvshMh+
         rFLHD4NcgYIlKz2zuuQLK4mKnfiUAjem8ZJSNUdFd7QuftTmHI2GRCKIa2Yd0F3Z+fgO
         dLTWvalY0U7SO59EWwIJSiSg8khxAvDVoDwFjCI4Zbvz5kqATo6/4FV3vq7Ff4v3WJOX
         eMAjKwnB7A/II6gcNJpxnW1OSLgzNzroy+PBdWaE9v3AtUyTrap2+vw9mnNQLWluUJZS
         D/vj4R1AWWelqEUAZcjgt2MSRnfxdeZzaSLTcC23bVtBm8a8cCHT3VGow9LApH0I9kNv
         wLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=PdCxIC9kgvzitGViQuvGUCEVY1YRU/tDisQccY12nsw=;
        b=VT0nHwpwAY21NJPg1tioUHHEm9QQK9KBhTUAtO4QRxgdIIN9L3d2y44ZmCHyw6h2l4
         H4oP3aShS/tA7W0LuMCpzCHTx9AyVE55YDZy0Dl+wi1bSSVXvFmXay1q80wwL8WXcxP5
         ubEtSArT5g7wORPW8NQlpWE2Jfz6b5FZpRi84cqkkyZsm1H+pSrPZqu+2jdrx3xKnOkw
         zy+WUGrf8tObQMIfRAATV2FzgxDb+GgHMbmowhtKJ1ez/5opRFXF29VLxYkbcn59e7oF
         575cEue1jCNHxr3vhPNDO8S/ioHR8w3MAVdy8w/e99U8cJqy3gM3DNHK54vp8Csnr8CD
         bn+Q==
X-Gm-Message-State: APjAAAXS9nDUkel4WmMy8+DdRZC/DlpPNqs6ijymBIFDN3k1Kz1+NNYD
        V8zb3JlCEqmCTN9F8mMm4Bw=
X-Google-Smtp-Source: APXvYqz1nzi7gaNWbZ4tnvSfntJCjHyjZtBNaPJIWWzm5C1eTgmyu60wFEjaYFZE0AzXmFsM29XT8A==
X-Received: by 2002:a05:6000:1181:: with SMTP id g1mr3898956wrx.131.1572920984576;
        Mon, 04 Nov 2019 18:29:44 -0800 (PST)
Received: from N-20L6PF1KTYA2 ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id l2sm17632205wrt.15.2019.11.04.18.29.42
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 18:29:44 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:29:41 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     "Michal Hocko" <mhocko@kernel.org>,
        akpm <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v2] mm: Fix checking unmapped holes for mbind
References: <201910291756045288126@gmail.com>, 
        <20191030210836.a17c0649354b59961903d1a8@linux-foundation.org>, 
        <20191031112609.GG13102@dhcp22.suse.cz>
X-Priority: 3
X-GUID: D47CCF3B-5C3D-42F7-A13F-43E0513E99E0
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2019110510294042190833@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAxOS0xMC0zMcKgYXQgMTk6MjbCoE1pY2hhbCBIb2Nrb8Kgd3JvdGU6Cj5PbiBXZWQgMzAt
MTAtMTkgMjE6MDg6MzYsIEFuZHJldyBNb3J0b24gd3JvdGU6Cj4+IChjYyBsaW51eC1tYW5Admdl
ci5rZXJuZWwub3JnKQo+Pgo+PiBPbiBUdWUsIDI5IE9jdCAyMDE5IDE3OjU2OjA2ICswODAwICJM
aSBYaW5oYWkiIDxsaXhpbmhhaS5seGhAZ21haWwuY29tPiB3cm90ZToKPj4KPj4gPiBxdWV1ZV9w
YWdlc19yYW5nZSgpIHdpbGwgY2hlY2sgZm9yIHVubWFwcGVkIGhvbGVzIGJlc2lkZXMgcXVldWUg
cGFnZXMgZm9yCj4+ID4gbWlncmF0aW9uLiBUaGUgcnVsZXMgZm9yIGNoZWNraW5nIHVubWFwcGVk
IGhvbGVzIGFyZToKPj4gPiAxIFVubWFwcGVkIGhvbGVzIGF0IGFueSBwYXJ0IG9mIHRoZSBzcGVj
aWZpZWQgcmFuZ2Ugc2hvdWxkIGJlIHJlcG9ydGVkIGFzCj4+ID4gwqAgRUZBVUxUIGlmIG1iaW5k
KCkgZm9yIG5vbmUgTVBPTF9ERUZBVUxUIGNhc2VzOwo+PiA+IDIgVW5tYXBwZWQgaG9sZXMgYXQg
YW55IHBhcnQgb2YgdGhlIHNwZWNpZmllZCByYW5nZSBzaG91bGQgYmUgaWdub3JlZCBpZgo+PiA+
IMKgIG1iaW5kKCkgZm9yIE1QT0xfREVGQVVMVCBjYXNlOwo+PiA+IE5vdGUgdGhhdCB0aGUgc2Vj
b25kIHJ1bGUgaXMgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIGJ1dCBpdCBzZWVtcwo+PiA+
IGNvbmZsaWN0cyB0aGUgTGludXggQVBJIGRlZmluaXRpb24uCj4+Cj4+IENhbiB5b3UgcXVvdGUg
dGhlIHBhcnQgb2YgdGhlIEFQSSBkZWZpbml0aW9uIHdoaWNoIHlvdSdyZSBsb29raW5nIGF0Pwo+
Pgo+PiBNeSBtYmluZCgyKSBtYW5wYWdlIHNheXMKPj4KPj4gRVJST1JTCj4+wqDCoMKgwqDCoMKg
wqAgRUZBVUxUIFBhcnQgb3IgYWxsIG9mIHRoZSBtZW1vcnkgcmFuZ2Ugc3BlY2lmaWVkIGJ5IG5v
ZGVtYXNrIGFuZCBtYXhuLQo+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2RlIHBvaW50
cyBvdXRzaWRlIHlvdXIgYWNjZXNzaWJsZSBhZGRyZXNzIHNwYWNlLsKgIE9yLCB0aGVyZSB3YXMK
Pj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFuIHVubWFwcGVkIGhvbGUgaW4gdGhlIHNw
ZWNpZmllZCBtZW1vcnkgcmFuZ2Ugc3BlY2lmaWVkIGJ5IGFkZHIKPj7CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGFuZCBsZW4uCj4+Cj4+IChJIGFzc3VtZSB0aGUgZmlyc3Qgc2VudGVuY2Ug
bWVhbnQgdG8gc2F5ICJzcGVjaWZpZWQgYnkgYWRkciBhbmQgbGVuIikKPgo+TXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IHRoaXMgcmVhbGx5IHJlZmVycyB0byBhcmVhIHBvaW50ZWQgdG8gYnkgbm9k
ZW1hc2suCj5CdHcuIHdoeSB0aGVyZSBpcyBhbnkgc3BlY2lhbCBjYXNpbmcgYXJvdW5kIHRoZSB1
bm1hcHBlZCBob2xlcyB3aXRoIHRoZQo+YWRkcmVzcyBzcGFjZSByYW5nZT8gVGhpcyBsb29rcyBs
aWtlIGFuIGFudGlwYXR0ZXJuIHRvIG90aGVyIGFkZHJlc3MKPnNwYWNlIG9wZXJhdGlvbnMgdG8g
bWUuIEUuZy4gbXVubWFwIHNpbXBseSB1bm1hcHMgYWxsIGV4aXN0aW5nIHZtYXMgaW4KPnRoZSBn
aXZlbiByYW5nZSwgbXByb3RlY3QsIG1hZHZpc2UgZXRjLiBiZWhhdmUgdGhlIHNhbWUuCj4KPlNv
IG15IHF1ZXN0aW9uIGlzLCBkbyB3ZSB3YW50IHRvIHJlbW92ZSB0aGF0IHdlaXJkIHJlc3RyaWN0
aW9uIGFuZAo+c2ltcGx5IGFjdCBvbiBhbGwgZXhpc3RpbmcgVk1BcyBpbiB0aGUgcmFuZ2U/IFRo
ZSBvbmx5IHNpdHVhdGlvbiB0aGlzCj5jb3VsZCByZWdyZXNzIHdvdWxkIGJlIGlmIHNvbWVib2R5
IHVzZWQgbWJpbmQgdG8gcHJvYmUgZm9yIGV4aXN0aW5nIFZNQXMKPmFuZCB0aGF0IHNvdW5kcyBh
IG1vcmUgdGhhbiBzZW5zaWJsZSB0byBtZS4gT3IgYW0gSSBtaXNzaW5nIGFueXRoaW5nPwo+LS0K
Pk1pY2hhbCBIb2Nrbwo+U1VTRSBMYWJzIAoKeWVzLCBtYmluZCgpIGNhcmUgYWJvdXQgdGhlIHVu
bWFwcGVkIGhvbGVzIGZvcsKgbm9uIE1QT0xfREVGQVVMVCBjYXNlcywgYnV0IApvdGhlciBvcGVy
YXRpb25zIGRvbid0IGNhcmUgdGhvc2UgaG9sZXMuIEl0IHNlZW1zIG5vIGNsdWVzIGFib3V0IHdo
eSB0aGF0IApyZXN0cmljdGlvbiB3YXMgZGVjaWRlZC4KCkF0IHByZXNlbnQsIGlmIGl0IGlzIGhh
cmQgdG8gZGVjaWRlIHRvIHJlbW92ZSB0aGlzIHJlc3RyaWN0aW9uLCB3ZSBtYXkga2VlcCB0aGUg
CmN1cnJlbnQgYmVoYXZpb3IuIE5ldyBwYXRjaCBwb3N0ZWQgZm9yIHRoaXMgcHVycG9zZSwgwqAK
IltQQVRDSCB2M10gbW06IEZpeCBjaGVja2luZyB1bm1hcHBlZCBob2xlcyBmb3IgbWJpbmQiLgpU
aGFua3MuCgpYaW5oYWkKCgo=

