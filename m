Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA70321581C
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGFNOu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 09:14:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:58219 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGFNOu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 09:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594041289; x=1625577289;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject;
  bh=lE8o3aE6u3uTR7vLNY3AE6Jbc2KyMOv7RbSUR1Qe/lw=;
  b=ofc4onXsHcw2wDW6wDZ+N8EzFhc4Hgi4CLu8kajvhyl4PrEwRW+MCl+5
   aJ8bQbDIbFThKA2KnMvYPZdhdC6XYwy7f34lPpJZODvgGk/+Ss+KrPv1d
   FjYwzZSXU2Y0NXeemSZ8Br/cpFMpgfuydYxmTeTCcQFOE59aQGkEP8kH+
   E=;
IronPort-SDR: RYsVEYxAQ2X8s91vcxUTUxFmwbQWy05lrC4jFO4FVshh/R2+yNbU3GZs1w14j6SyDYz2XXnZIe
 yqt12WaBlNng==
X-IronPort-AV: E=Sophos;i="5.75,320,1589241600"; 
   d="scan'208";a="40221329"
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Jul 2020 13:14:45 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 1EDA5A1D8E;
        Mon,  6 Jul 2020 13:14:44 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 13:14:43 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.161.203) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 13:14:38 +0000
To:     Jann Horn <jannh@google.com>
CC:     Pavel Machek <pavel@ucw.cz>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
 <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
 <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <76c0a77f-38d3-56ca-7204-f56c37981f45@amazon.com>
Date:   Mon, 6 Jul 2020 15:14:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D24UWB003.ant.amazon.com (10.43.161.222) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

CgpPbiAwNi4wNy4yMCAxNDo1MiwgSmFubiBIb3JuIHdyb3RlOgo+IENBVVRJT046IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuCj4gCj4gCj4gCj4gT24gTW9uLCBK
dWwgNiwgMjAyMCBhdCAyOjI3IFBNIEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+IHdy
b3RlOgo+PiBVbmxlc3Mgd2UgY3JlYXRlIGEgdnN5c2NhbGwgdGhhdCByZXR1cm5zIGJvdGggdGhl
IFBJRCBhcyB3ZWxsIGFzIHRoZQo+PiBlcG9jaCBhbmQgdGh1cyBoYW5kbGVzIGZvcmsgKmFuZCog
c3VzcGVuZC4gSSBuZWVkIHRvIHRoaW5rIGFib3V0IHRoaXMgYQo+PiBiaXQgbW9yZSA6KS4KPiAK
PiBZb3UgY2FuJ3QgcmVsaWFibHkgZGV0ZWN0IGZvcmtpbmcgYnkgY2hlY2tpbmcgdGhlIFBJRCBp
ZiBpdCBpcwo+IHBvc3NpYmxlIGZvciBtdWx0aXBsZSBmb3JrcyB0byBiZSBjaGFpbmVkIGJlZm9y
ZSB0aGUgcmV1c2UgY2hlY2sgcnVuczoKPiAKPiAgIC0gcGlkIDEwMDAgcmVtZW1iZXJzIGl0cyBQ
SUQKPiAgIC0gcGlkIDEwMDAgZm9ya3MsIGNyZWF0aW5nIGNoaWxkIHBpZCAxMDAxCj4gICAtIHBp
ZCAxMDAwIGV4aXRzIGFuZCBpcyB3YWl0ZWQgb24gYnkgaW5pdAo+ICAgLSB0aGUgcGlkIGFsbG9j
YXRvciB3cmFwcyBhcm91bmQKPiAgIC0gcGlkIDEwMDEgZm9ya3MsIGNyZWF0aW5nIGNoaWxkIHBp
ZCAxMDAwCj4gICAtIGNoaWxkIHdpdGggcGlkIDEwMDAgdHJpZXMgdG8gY2hlY2sgZm9yIGZvcmtp
bmcsIGRldGVybWluZXMgdGhhdCBpdHMKPiBQSUQgaXMgMTAwMCwgYW5kIGNvbmNsdWRlcyB0aGF0
IGl0IGlzIHN0aWxsIHRoZSBvcmlnaW5hbCBwcm9jZXNzCj4gCgpGYWlyIHBvaW50LiBIb3dldmVy
LCB5b3UgY291bGQgYnVtcCBhbiBlcG9jaCB2YWx1ZSBvbiBmb3JrLCBubz8gSSBkb24ndCAKdGhp
bmsgd2UgbWFwIGFueXRoaW5nIGluIHRoZSB2ZHNvIHBlci1wcm9jZXNzIHRvZGF5IHRob3VnaCAu
Li4KCgpBbGV4CgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVz
ZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hs
YWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3
IDg3OQoKCg==

