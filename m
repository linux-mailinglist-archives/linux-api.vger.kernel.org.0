Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC67CB7BD
	for <lists+linux-api@lfdr.de>; Tue, 17 Oct 2023 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjJQBC7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Oct 2023 21:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQBC7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Oct 2023 21:02:59 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 18:02:57 PDT
Received: from bolin (vbox.bolinlang.com [IPv6:2001:19f0:b001:f83:5400:4ff:fe1a:5b71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124992
        for <linux-api@vger.kernel.org>; Mon, 16 Oct 2023 18:02:57 -0700 (PDT)
Received: by bolin (Postfix, from userid 1000)
        id 290E4FA139; Tue, 17 Oct 2023 00:56:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1804289383-1697504160=:196329"
From:   Levo D <l-asm@mail9fcb1a.bolinlang.com>
To:     <linux-api@vger.kernel.org>
Subject: mmap a file without an overwrite risk?
User-Agent: mail (GNU Mailutils 3.15)
Date:   Tue, 17 Oct 2023 00:56:00 +0000
Message-Id: <20231017005600.290E4FA139@bolin>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_50,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--1804289383-1697504160=:196329
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-ID: <20231017005600.196329@bolin>

Attached are 2 c files with main.c having reproduce instructions

I noticed if I try to read a large file it's a bit slow and mallocing/mmap a large amount of memory waits hundreds of milliseconds from the OS. However mmap is incredibly fast but leaves my software open to memory corruption. I attached a reproducable

I tried various MAP flags and couldn't think of a way to get rid of the risk. The gist of the problem is if I mmap a file another process can overwrite data which appears in mine, or delete the file causing my code to have a bus error. Not shown in the code is me trying to write to every page in hopes it'd prevent my memory from being overwritten, it didn't work either.

If there's nothing I can do is there an alternative way to load a file quicker than malloc+read? Files can be >100MB or GBs in size


--1804289383-1697504160=:196329
Content-Type: application/octet-stream; name="main.c"
Content-Disposition: attachment; filename="main.c"
Content-Transfer-Encoding: base64
Content-ID: <20231017005600.196329.1@bolin>

LyogUmVwcm9kdWNhYmxlIHN0ZXBzCmdjYyBtYWluLmMgLW8gYXBwMQpnY2MgYXBwMi5jIC1vIGFw
cDIKZm49L3RtcC91QjJrQ0RGbERvUkE1NmdkZXV2T1ZLYkwxS0hYeE1oRFhjM3BGbmhqYmhjCmRk
IGlmPS9kZXYvemVybyBvZj0kZm4gY291bnQ9NTEyMCBicz00MDk2OyAuL2FwcDEgJGZuIDEgfCAu
L2FwcDIgJGZuCllvdSdsbCBzZWUgIlJlc3VsdCB3YXMgNzIiIGluc3RlYWQgb2YgIlJlc3VsdCB3
YXMgMCIKZGQgaWY9L2Rldi96ZXJvIG9mPSRmbiBjb3VudD01MTIwIGJzPTQwOTY7IC4vYXBwMSAk
Zm4gMCB8IC4vYXBwMiAkZm4KWW91J2xsIHNlZSB0aGUgZGVzaXJlZCAiUmVzdWx0IHdhcyAwIgpJ
biBhcHAyLmMgdW5jb21tZW50L2NvbW1lbnQgbGluZSAxMyBhbmQgMTIKZ2NjIGFwcDIuYyAtbyBh
cHAyCk5vdyB0aGlzIHdpbGwgaGF2ZSBhIGJ1cyBlcnJvciBhbmQgbGFzdCBsaW5lIHdyaXR0ZW4g
aXMgd2FraW5nCmRkIGlmPS9kZXYvemVybyBvZj0kZm4gY291bnQ9NTEyMCBicz00MDk2OyAuL2Fw
cDEgJGZuIDEgfCAuL2FwcDIgJGZuCnJlYWQgaXMgdW5hZmZlY3RlZApkZCBpZj0vZGV2L3plcm8g
b2Y9JGZuIGNvdW50PTUxMjAgYnM9NDA5NjsgLi9hcHAxICRmbiAwIHwgLi9hcHAyICRmbgoqLwoK
I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pCnsKCS8vYS5vdXQgZmlsZW5hbWUgMQoJaWYgKGFyZ2MgIT0gMykgewoJCWZwcmludGYoc3Rk
ZXJyLCAiQmFkIGFyZ3NcbiIpOwoJCXJldHVybiAxOwoJfQoJCglpbnQgZmQgPSBvcGVuKGFyZ3Zb
MV0sIE9fUkRPTkxZKTsKCXN0cnVjdCBzdGF0IHM9ezB9OwoJZnN0YXQoZmQsICZzKTsKCWNoYXIq
cDsKCWlmIChhcmd2WzJdWzBdID09ICcxJykKCQlwID0gKGNoYXIqKW1tYXAoMCwgcy5zdF9zaXpl
LCBQUk9UX1JFQUQgLCBNQVBfUFJJVkFURSwgZmQsIDApOwoJZWxzZSB7CgkJcCA9IChjaGFyKilt
YWxsb2Mocy5zdF9zaXplKTsKCQlyZWFkKGZkLCBwLCBzLnN0X3NpemUpOwoJfQoJd3JpdGUoMiwg
IlNsZWVwaW5nXG4iLCA5KTsKCXdyaXRlKDEsICJTbGVlcGluZ1xuIiwgOSk7IC8vVHJpZ2dlcnMg
dGhlIG90aGVyIGFwcCB0byB3cml0ZQoJc2xlZXAoMSk7Cgl3cml0ZSgyLCAiV2FraW5nXG4iLCA3
KTsKCgkvL3JlYWQgZmlyc3QgYnl0ZSBvZiBldmVyeSA0ayBwYWdlCglpbnQgc3VtID0gMDsKCWZv
ciAobG9uZyBpPTA7IGk8cy5zdF9zaXplOyBpKz00MDk2KSB7CgkJaWYgKHBbaV0gIT0gMCkgewoJ
CQlpbnQgej0wOwoJCX0KCQlzdW0gKz0gcFtpXTsKCX0KCWZwcmludGYoc3RkZXJyLCAiUmVzdWx0
IHdhcyAlZFxuIiwgc3VtKTsKCXJldHVybiAwOwp9Cg==
--1804289383-1697504160=:196329
Content-Type: application/octet-stream; name="app2.c"
Content-Disposition: attachment; filename="app2.c"
Content-Transfer-Encoding: base64
Content-ID: <20231017005600.196329.2@bolin>

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+
CmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWlmIChhcmdjICE9IDIpIHsKCQlm
cHJpbnRmKHN0ZGVyciwgIkJhZCBhcmdzXG4iKTsKCQlyZXR1cm4gMTsKCX0KCWNoYXIgYnVmWzQw
OTZdOwoJcmVhZCgwLCBidWYsIDQwOTYpOwoJaW50IGZkID0gb3Blbihhcmd2WzFdLCBPX1dST05M
WXxPX0NSRUFUKTsKCS8vaW50IGZkID0gb3Blbihhcmd2WzFdLCBPX1dST05MWXxPX0NSRUFUfE9f
VFJVTkN8T19DTE9FWEVDKTsgLy88LS0gVGhpcyBvbmUgY2F1c2VzIGEgYnVzIGVycm9yCgl3cml0
ZShmZCwgIkhlbGxvIiwgNSk7CglmcHJpbnRmKHN0ZGVyciwgIldyaXR0ZW4gJWRcbiIsIGZkKTsK
fQo=
--1804289383-1697504160=:196329--
