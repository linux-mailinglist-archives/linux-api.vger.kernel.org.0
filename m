Return-Path: <linux-api+bounces-13-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC37E5F16
	for <lists+linux-api@lfdr.de>; Wed,  8 Nov 2023 21:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C4FB20B59
	for <lists+linux-api@lfdr.de>; Wed,  8 Nov 2023 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BC3716F;
	Wed,  8 Nov 2023 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5337171
	for <linux-api@vger.kernel.org>; Wed,  8 Nov 2023 20:21:59 +0000 (UTC)
Received: from bolin (vbox.bolinlang.com [IPv6:2001:19f0:b001:f83:5400:4ff:fe1a:5b71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1F42132
	for <linux-api@vger.kernel.org>; Wed,  8 Nov 2023 12:21:59 -0800 (PST)
Received: by bolin (Postfix, from userid 1000)
	id 404E0FA16D; Wed,  8 Nov 2023 20:21:55 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1804289383-1699474915=:261119"
From: Levo D <l-asm@mail9fcb1a.bolinlang.com>
To: <linux-api@vger.kernel.org>
Subject: mmap causing bus error
User-Agent: mail (GNU Mailutils 3.15)
Date: Wed,  8 Nov 2023 20:21:55 +0000
Message-Id: <20231108202155.404E0FA16D@bolin>

--1804289383-1699474915=:261119
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-ID: <20231108202155.261119@bolin>

When I mmap a file it's possible to have a bus error and I attached some code to reproduce it

The reproduce steps are in main.c. I choose to use mmap because I noticed doing an `read` on a large file is a bit slow. It seems like the kernel will zero out everything then write the file contents to the buffer. mmap is significantly faster but risk corrupting data and having a bus error (also doesn't seem like zero copy).

Essentially what the program is is write to the contents of the file while main.c is using it which causes bad data OR it will TRUNC the file and cause a bus error + coredump. Are there ways to get a copy without being as 'slow' as `read` and doesn't have the downsides of mmap?

--1804289383-1699474915=:261119
Content-Type: application/octet-stream; name="main.c"
Content-Disposition: attachment; filename="main.c"
Content-Transfer-Encoding: base64
Content-ID: <20231108202155.261119.1@bolin>

LyogUmVwcm9kdWNhYmxlIHN0ZXBzCmdjYyAtZyBtYWluLmMgLW8gYXBwMQpnY2MgLWcgYXBwMi5j
IC1vIGFwcDIKZm49L3RtcC91QjJrQ0RGbERvUkE1NmdkZXV2T1ZLYkwxS0hYeE1oRFhjM3BGbmhq
YmhjCmRkIGlmPS9kZXYvemVybyBvZj0kZm4gY291bnQ9NTEyMCBicz00MDk2OyAuL2FwcDEgJGZu
IDEgfCAuL2FwcDIgJGZuCllvdSdsbCBzZWUgIlJlc3VsdCB3YXMgNzIiIGluc3RlYWQgb2YgIlJl
c3VsdCB3YXMgMCIKKGFwcCAyIG1vZGlmaWVzICRmbiBzbyB3ZSdsbCBuZWVkIGRkIGFnYWluKQpk
ZCBpZj0vZGV2L3plcm8gb2Y9JGZuIGNvdW50PTUxMjAgYnM9NDA5NjsgLi9hcHAxICRmbiAwIHwg
Li9hcHAyICRmbgpZb3UnbGwgc2VlIHRoZSBkZXNpcmVkICJSZXN1bHQgd2FzIDAiCkluIGFwcDIu
YyB1bmNvbW1lbnQvY29tbWVudCBsaW5lIDEzIGFuZCAxMgpnY2MgYXBwMi5jIC1vIGFwcDIKTm93
IHRoaXMgd2lsbCBoYXZlIGEgYnVzIGVycm9yIGFuZCAiUmVzdWx0IiBsaW5lIHdpbGwgbm90IHBy
aW50CmRkIGlmPS9kZXYvemVybyBvZj0kZm4gY291bnQ9NTEyMCBicz00MDk2OyAuL2FwcDEgJGZu
IDEgfCAuL2FwcDIgJGZuCnJlYWQgaXMgdW5hZmZlY3RlZApkZCBpZj0vZGV2L3plcm8gb2Y9JGZu
IGNvdW50PTUxMjAgYnM9NDA5NjsgLi9hcHAxICRmbiAwIHwgLi9hcHAyICRmbgoqLwoKI2luY2x1
ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5j
bHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4K
I2luY2x1ZGUgPHN5cy9zdGF0Lmg+CmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsK
CS8vYS5vdXQgZmlsZW5hbWUgMQoJaWYgKGFyZ2MgIT0gMykgewoJCWZwcmludGYoc3RkZXJyLCAi
QmFkIGFyZ3NcbiIpOwoJCXJldHVybiAxOwoJfQoJCglpbnQgZmQgPSBvcGVuKGFyZ3ZbMV0sIE9f
UkRPTkxZKTsKCXN0cnVjdCBzdGF0IHM9ezB9OwoJZnN0YXQoZmQsICZzKTsKCWNoYXIqcDsKCWlm
IChhcmd2WzJdWzBdID09ICcxJykKCQlwID0gKGNoYXIqKW1tYXAoMCwgcy5zdF9zaXplLCBQUk9U
X1JFQUQgLCBNQVBfUFJJVkFURSwgZmQsIDApOwoJZWxzZSB7CgkJcCA9IChjaGFyKiltYWxsb2Mo
cy5zdF9zaXplKTsKCQlyZWFkKGZkLCBwLCBzLnN0X3NpemUpOwoJfQoJd3JpdGUoMiwgIlNsZWVw
aW5nXG4iLCA5KTsKCXdyaXRlKDEsICJTbGVlcGluZ1xuIiwgOSk7IC8vVHJpZ2dlcnMgdGhlIG90
aGVyIGFwcCB0byB3cml0ZQoJc2xlZXAoMSk7Cgl3cml0ZSgyLCAiV2FraW5nXG4iLCA3KTsKCgkv
L3JlYWQgZmlyc3QgYnl0ZSBvZiBldmVyeSA0ayBwYWdlCglpbnQgc3VtID0gMDsKCWZvciAobG9u
ZyBpPTA7IGk8cy5zdF9zaXplOyBpKz00MDk2KSB7CgkJaWYgKHBbaV0gIT0gMCkgewoJCQlpbnQg
ej0wOwoJCX0KCQlzdW0gKz0gcFtpXTsKCX0KCWZwcmludGYoc3RkZXJyLCAiUmVzdWx0IHdhcyAl
ZFxuIiwgc3VtKTsKCXJldHVybiAwOwp9Cgo=
--1804289383-1699474915=:261119
Content-Type: application/octet-stream; name="app2.c"
Content-Disposition: attachment; filename="app2.c"
Content-Transfer-Encoding: base64
Content-ID: <20231108202155.261119.2@bolin>

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+
CmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWlmIChhcmdjICE9IDIpIHsKCQlm
cHJpbnRmKHN0ZGVyciwgIkJhZCBhcmdzXG4iKTsKCQlyZXR1cm4gMTsKCX0KCWNoYXIgYnVmWzQw
OTZdOwoJcmVhZCgwLCBidWYsIDQwOTYpOwoJaW50IGZkID0gb3Blbihhcmd2WzFdLCBPX1dST05M
WXxPX0NSRUFUKTsKCS8vaW50IGZkID0gb3Blbihhcmd2WzFdLCBPX1dST05MWXxPX0NSRUFUfE9f
VFJVTkN8T19DTE9FWEVDKTsgLy88LS0gVGhpcyBvbmUgY2F1c2VzIGEgYnVzIGVycm9yCgl3cml0
ZShmZCwgIkhlbGxvIiwgNSk7CglmcHJpbnRmKHN0ZGVyciwgIldyaXR0ZW4gJWRcbiIsIGZkKTsK
fQo=
--1804289383-1699474915=:261119--

