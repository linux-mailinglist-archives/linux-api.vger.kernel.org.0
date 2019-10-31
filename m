Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA1EAA8B
	for <lists+linux-api@lfdr.de>; Thu, 31 Oct 2019 07:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJaGBH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 31 Oct 2019 02:01:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45527 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJaGBH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 31 Oct 2019 02:01:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so3542040lfa.12;
        Wed, 30 Oct 2019 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=B9pBKnFjfixHWQ/ZEyIY+63diOqN5jpX/fJTCisM0+M=;
        b=Fkp6Syx6mHbOLRCg/THpgtyk4gCS05UCGwcgJi5cBfBcrSgo/HwFigMnvXxvLOM5F2
         vGwlHeDPxUrySg3tOOeyorFr6FS/BAtjxRo/umHFbdq1mFwg5minYcuBXrauE1e39W1i
         SVJt6mccSS61DEOTkSLgFSBZJVEVaNFkOC7cynYKAX5TbhFOLln8ol90SkxWOy4ofFOG
         JiuxNf9+PFjVyC24JJaahEzYu6ZhUaCLu5VOHthNl/rrUeYoItKi0pU5Zp76DdnIlZ3e
         KGRP1tN6mASAs4LLHZBP6AwdfpOEjA4Yy+zK8YpQ2y1XcDjIBo07T8+GEHw+hjvlQK9e
         K5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=B9pBKnFjfixHWQ/ZEyIY+63diOqN5jpX/fJTCisM0+M=;
        b=eSqy0osA8RoSNC6GPnFyGXQVdvfe9wCHVypXaeQuWeMAM9T/f06gsnC5jsrN47j5eW
         tyyVRjglaObBx3bPqC9MOapqjnf6M/8RvHqRCm7ODT2u08d7XZVN1crptIUrKwtLzoTV
         aev4PHHT8ACwAXh3Zw2cNUjl0RqH/ifW2jJ2hhyqjYhCyKuuenICcwKpRHmKKlpjWY2t
         F7ziL6GZQweetrurc7wpnpdRVv9yiPD2caV5bNnGnW4/8aYROboWjKPr3usi4Gve2ZWt
         OTLP59VhIwjpzDnY8g9u74ioVvIYvb2OQCct6Sb/AHPeEkgf8pgUPC5X5cvmtp1LivSs
         iX7g==
X-Gm-Message-State: APjAAAWjvGFlFqE9ZWXYlnA+hVmZixM+RzIKb6AmhtfpqFWL/qyVC9FW
        rPp4CvntRZtzXkTfO5XG5IE=
X-Google-Smtp-Source: APXvYqzKGcjgiqWDmZQtkX4i4E9Z6uMkIO9vy8g/Qcy7z1Y1exXSWj23ipY0ULxG9VWMivkMsEKdTQ==
X-Received: by 2002:ac2:5496:: with SMTP id t22mr839811lfk.31.1572501663756;
        Wed, 30 Oct 2019 23:01:03 -0700 (PDT)
Received: from N-20L6PF1KTYA2 ([131.228.2.20])
        by smtp.gmail.com with ESMTPSA id t4sm704967lji.40.2019.10.30.23.01.00
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 23:01:02 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:01:00 +0800
From:   "Li Xinhai" <lixinhai.lxh@gmail.com>
To:     akpm <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        n-horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v2] mm: Fix checking unmapped holes for mbind
References: <201910291756045288126@gmail.com>, 
        <20191030210836.a17c0649354b59961903d1a8@linux-foundation.org>
X-Priority: 3
X-GUID: 6300A385-0B3A-4454-B5DB-0B15FEDE58AA
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2019103114005855855689@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

T24gMjAxOS0xMC0zMcKgYXQgMTI6MDjCoEFuZHJldyBNb3J0b27CoHdyb3RlOgo+KGNjIGxpbnV4
LW1hbkB2Z2VyLmtlcm5lbC5vcmcpCj4KPk9uIFR1ZSwgMjkgT2N0IDIwMTkgMTc6NTY6MDYgKzA4
MDAgIkxpIFhpbmhhaSIgPGxpeGluaGFpLmx4aEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4+IHF1ZXVl
X3BhZ2VzX3JhbmdlKCkgd2lsbCBjaGVjayBmb3IgdW5tYXBwZWQgaG9sZXMgYmVzaWRlcyBxdWV1
ZSBwYWdlcyBmb3IKPj4gbWlncmF0aW9uLiBUaGUgcnVsZXMgZm9yIGNoZWNraW5nIHVubWFwcGVk
IGhvbGVzIGFyZToKPj4gMSBVbm1hcHBlZCBob2xlcyBhdCBhbnkgcGFydCBvZiB0aGUgc3BlY2lm
aWVkIHJhbmdlIHNob3VsZCBiZSByZXBvcnRlZCBhcwo+PiDCoCBFRkFVTFQgaWYgbWJpbmQoKSBm
b3Igbm9uZSBNUE9MX0RFRkFVTFQgY2FzZXM7Cj4+IDIgVW5tYXBwZWQgaG9sZXMgYXQgYW55IHBh
cnQgb2YgdGhlIHNwZWNpZmllZCByYW5nZSBzaG91bGQgYmUgaWdub3JlZCBpZgo+PiDCoCBtYmlu
ZCgpIGZvciBNUE9MX0RFRkFVTFQgY2FzZTsKPj4gTm90ZSB0aGF0IHRoZSBzZWNvbmQgcnVsZSBp
cyB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgYnV0IGl0IHNlZW1zCj4+IGNvbmZsaWN0cyB0
aGUgTGludXggQVBJIGRlZmluaXRpb24uCj4KPkNhbiB5b3UgcXVvdGUgdGhlIHBhcnQgb2YgdGhl
IEFQSSBkZWZpbml0aW9uIHdoaWNoIHlvdSdyZSBsb29raW5nIGF0Pwo+Cj5NeSBtYmluZCgyKSBt
YW5wYWdlIHNheXMKPgo+RVJST1JTCj7CoMKgwqDCoMKgwqAgRUZBVUxUIFBhcnQgb3IgYWxsIG9m
IHRoZSBtZW1vcnkgcmFuZ2Ugc3BlY2lmaWVkIGJ5IG5vZGVtYXNrIGFuZCBtYXhuLQo+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgb2RlIHBvaW50cyBvdXRzaWRlIHlvdXIgYWNjZXNzaWJsZSBh
ZGRyZXNzIHNwYWNlLsKgIE9yLCB0aGVyZSB3YXMKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGFuIHVubWFwcGVkIGhvbGUgaW4gdGhlIHNwZWNpZmllZCBtZW1vcnkgcmFuZ2Ugc3BlY2lmaWVk
IGJ5IGFkZHIKPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFuZCBsZW4uCj4KPihJIGFzc3Vt
ZSB0aGUgZmlyc3Qgc2VudGVuY2UgbWVhbnQgdG8gc2F5ICJzcGVjaWZpZWQgYnkgYWRkciBhbmQg
bGVuIikKPiAKCnRoaXMgcGFydDrCoAoiT3IsIHRoZXJlIHdhcyBhbiB1bm1hcHBlZCBob2xlIGlu
IHRoZSBzcGVjaWZpZWQgbWVtb3J5IHJhbmdlIHNwZWNpZmllZCBieSBhZGRyIAphbmQgbGVuLiIK
aXMgY29uY2VybmVkIGJ5IG15IHBhdGNoLgoKPkkgYWdyZWUgd2l0aCB5b3VyIGludGVycHJldGF0
aW9uLCBidXQgdGhlcmUncyBubyBtZW50aW9uIGhlcmUgdGhhdAo+TVBPTF9ERUZBVUxUIGlzIHRy
ZWF0ZWQgZGlmZmVyZW50bHkgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBpdCBzaG91bGQgYmUuCj4gClRo
ZSBmaXJzdCBydWxlIG1hdGNoIHRoZSBtYW5wYWdlLCBidXQgdGhlIGN1cnJlbnQgbWVtcG9saWN5
IGltcGxlbWVudGF0aW9uIG9ubHnCoApyZXBvcnRzIEVGQVVMVCBpZiBob2xlcyBhcmUgd2l0aGlu
IHJhbmdlLCBvciBhdCB0aGUgaGVhZCBzaWRlIG9mIHJhbmdlLiBObyBFRkFVTFTCoApyZXBvcnRl
ZCBpZiBob2xlIGF0IHRhaWwgc2lkZSBvZiByYW5nZS4gSSBzdXBwb3NlIHRoZSBmaXJzdCBydWxl
IGhhcyB0byBiZSBmaXhlZC4KClRoZSBzZWNvbmRlIHJ1bGUsIHdoZW4gTVBPTF9ERUZBVUxUIGlz
IHVzZWQsIHdhcyBzdW1tYXJpemVkIGJ5IG1lIGFjY29yZGluZ8KgCnRvIG1lbXBvbGljeSBpbXBs
ZW1lbnRhdGlvbi4gQWN0dWFsbHksIHRoaXMgcnVsZSBkb2VzIG5vdCBmb2xsb3cgbWFucGFnZSBh
bmQgZXhzaXRzwqAKZm9yIGxvbmcgZGF5cy4gSW4gbXkgdW5kZXJzdGFuZGluZywgdGhpcyBydWxl
IGlzIHJlYXNvbmFibGUgKGluIGNvZGUsIMKgdGhlIGludGVybmFsIGZsYWcgCk1QT0xfTUZfRElT
Q09OVElHX09LIGlzIHVzZWQgZm9yIHRoYXQgcHVycG9zZSwgdGhlcmUgaXMgY29tbWVudHMgZm9y
IHJlYXNvbikgCmFuZCB3ZSdkIGJldHRlcsKga2VlcCBpdC4KCj4KPk1vcmUgYnJvYWRseSwgSSB3
b3JyeSB0aGF0IGl0J3MgdG9vIGxhdGUgdG8gY2hhbmdlIHRoaXMgLSBleGlzdGluZwo+YXBwbGlj
YXRpb25zIG1pZ2h0IGZhaWwgaWYgd2UgY2hhbmdlIHRoZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGUg
cHJvcG9zZWQKPmZhc2hpb24uwqAgU28gcGVyaGFwcyB3aGF0IHdlIHNob3VsZCBkbyBoZXJlIGlz
IHRvIGNoYW5nZSB0aGUgbWFucGFnZSB0bwo+bWF0Y2ggcmVhbGl0eT8KPiAKSSBwcmVmZXIgYWRk
IGRlc2NyaXB0aW9uIGluIG1hbnBhZ2UgZm9yIHRoZSBzZWNvbmQgcnVsZSwgc28gbm8gY2hhbmdl
IHRvIG91ciBjb2RlLiAKT25seSBmaXggZm9yIGZpcnN0IHJ1bGUuCgo+SXMgdGhlIGN1cnJlbnQg
YmVoYXZpb3IgY2F1c2luZyB5b3UgYW55IHByb2JsZW1zIGluIGEgcmVhbC13b3JsZCB1c2UKPmNh
c2U/IApJIHdhcyB1c2luZyBtYmluZCgpIHdpdGjCoE1QT0xfREVGQVVMVChvciBNUE9MX0JJTkQp
IHRvIHJlc2V0IGEgcmFuZ2Ugb2YgYWRkcmVzcyAKKHdoaWNoIG1heWJlIGNvbnRpZ3VvdXMgb3Ig
bm90IGluIHRoZSB3aG9sZSByYW5nZSkgdG8gdGhlIGRlZmF1bHQgcG9saWN5ICh0byBhIHNwZWNp
ZmljIApub2RlKSwgYW5kIG9ic2VydmVkIHRoaXMgaXNzdWUuIElmIG1iaW5kKCkgY2FsbCBmb3Ig
ZWFjaCBtYXBwaW5nIG9uZSBieSBvbmUsIHdlIGRvbid0IHNlZSB0aGXCoAppc3N1ZS4KCi0gWGlu
aGFpCgo=

