Return-Path: <linux-api+bounces-6347-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKDBBwI9C2oJFAUAu9opvQ
	(envelope-from <linux-api+bounces-6347-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:23:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1DB570CFA
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2C313037F73
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BF4508F8;
	Mon, 18 May 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L1ij12X2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B87371CE0;
	Mon, 18 May 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121324; cv=none; b=scAV015z8YWTnd9VdNYSWZ099XUdoVKEYYnM1bA0awZSCVWXSXcHwwaGK7d6ySPSEoMye3bGKoz8Zb20ixp+Xplf6Dl1Y84MZHpaQq67k6NGH6Cn3tIwAXN8KGmJYRquLTMO4e0SDldLSbJ+Vi0sq92scs01GNqlgpctlN3JQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121324; c=relaxed/simple;
	bh=6B7N8auHOgw8oG8MoDIYMzpDJJJ50aDQh56EXJx4gf0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=a2bIjUuBj9oYQ3SCmibZvfdzujK3i2CUFIrR+xxBje7GWsEyy4o+QajeTkdb/YD7R1svoXqKiB5eOwh6nO2XNfj737DP6gC6InzjOzhEf3VARcKeV99srCoBVZHt4Psq7KntqRRzAcR6ikv3Uv5q0/s6ZJNL4cOUeRZASn99qB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L1ij12X2; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779121307; x=1779380507;
	bh=6B7N8auHOgw8oG8MoDIYMzpDJJJ50aDQh56EXJx4gf0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L1ij12X2bQ8nORGru4rDTfYAUtXaNHBgl9vQd9TPyDkLga1bWhk6luLeG4w/h0IJR
	 IxXjaVCTyQL/b3KjFnuFOH4OjgwReqf4YvnrEOMGq9iTJuQ2Uu46y0PX75sFdLR84/
	 f2MfrOOw7Z2kYiGwjaY9W/UcA+TeP/b9Uzdsacq3OkEt7HvVOLoEKvW9XBasm8vlB2
	 dLtoZNqZ5LUCmVnHoWlKHBX+mkjqVKrfddstI3tL7Q0lrXzvNKoVD5UFWH3AHmL0J3
	 rqgIUXLaRhjaVvOvv5E2AP4dbsV9zk4yK7tHSp1WGYDwNW++lOQGkzBgS9On0fvKNP
	 /BRicHcUYNctw==
Date: Mon, 18 May 2026 16:21:43 +0000
To: "hch@infradead.org" <hch@infradead.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: =?utf-8?Q?[2]Yaz=C4=B1=C5=9Fmada_2_ileti_var[RFC]_fs/ioctl.c:_FIBMAP_requires_CAP=5FSYS=5FRAWIO_while_FIEMAP_exposes_identical_data_unprivileged?=
Message-ID: <BnwW4YBSPGE6fRUXHIRW57SZU2ReivrVEjnddmzdfHYTxBwNq2PcJbE-YeBAH-2OkdQDU7K1j2HLbVXeD65V8ARaEPe29jtbl97qQKkIITw=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: 2391698aee24597cbf389f0a74d801233434d22b
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_hb8YhQAwhZCXIU9G8xbQEjyLoqOllM25eS5t9Lwjmw"
X-Spamd-Result: default: False [-0.53 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6347-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Cyberblackk@proton.me,linux-api@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 8C1DB570CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--b1=_hb8YhQAwhZCXIU9G8xbQEjyLoqOllM25eS5t9Lwjmw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 05:36:45PM +0000, Maintainer wrote:> No, FIEMAP rea=
lly should not be available unprivileged. So I think B is
> the right thing. Can you send a proper patch with a proper signoff?

Absolutely, thanks for the guidance. You're right that Option B is the
correct approach for consistency and security.

I've prepared the patch below. It adds CAP_SYS_RAWIO check to
ioctl_fiemap() to match the protection already in place for FIBMAP.

The check is placed early in the function, before any filesystem-specific
operations, following the same pattern as ioctl_fibmap().

Best regards,

Eneshan Erdo=C4=9Fan Karaca

My github:https://github.com/Kisaca-Enes


--b1=_hb8YhQAwhZCXIU9G8xbQEjyLoqOllM25eS5t9Lwjmw
Content-Type: text/x-patch; name=0001-fs-ioctl-add-CAP_SYS_RAWIO-check-to-FS_IOC_FIEMAP.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-fs-ioctl-add-CAP_SYS_RAWIO-check-to-FS_IOC_FIEMAP.patch

RnJvbTogQ3liZXJfYmxhY2sgPEN5YmVyYmxhY2trQHByb3Rvbi5tZT4KRGF0ZTogRnJpLCAxNiBN
YXkgMjAyNiAxMjowMDowMCArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIGZzL2lvY3RsOiBhZGQgQ0FQ
X1NZU19SQVdJTyBjaGVjayB0byBGU19JT0NfRklFTUFQCgpGU19JT0NfRklFTUFQIGV4cG9zZXMg
cGh5c2ljYWwgYmxvY2sgYWRkcmVzc2VzIG9mIGZpbGVzIHRvIHVucHJpdmlsZWdlZAp1c2Vycywg
d2hpY2ggaXMgdGhlIHNhbWUgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiB0aGF0IEZJQk1BUCBwcm90
ZWN0cyB3aXRoCkNBUF9TWVNfUkFXSU8gY2FwYWJpbGl0eSBjaGVjay4KCkZvciBjb25zaXN0ZW5j
eSBpbiB0aGUgVkZTIHByaXZpbGVnZSBtb2RlbCBhbmQgdG8gcHJldmVudCBpbmZvcm1hdGlvbgpk
aXNjbG9zdXJlIG9mIHBoeXNpY2FsIGRpc2sgbGF5b3V0LCBhZGQgdGhlIHNhbWUgY2FwYWJpbGl0
eSBjaGVjayB0bwppb2N0bF9maWVtYXAoKSB0aGF0IGFscmVhZHkgZXhpc3RzIGluIGlvY3RsX2Zp
Ym1hcCgpLgoKRklFTUFQIGhhcyBiZWVuIGF2YWlsYWJsZSB1bnByaXZpbGVnZWQgc2luY2UgMjAw
OCwgYnV0IGFzIG5vdGVkIGJ5IHRoZQptYWludGFpbmVycywgdGhpcyB3YXMgYW4gdW5pbnRlbmRl
ZCBleHBvc3VyZSB0aGF0IHNob3VsZCBiZSBjb3JyZWN0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBDeWJl
cl9ibGFjayA8Q3liZXJibGFja2tAcHJvdG9uLm1lPgotLS0KIGZzL2lvY3RsLmMgfCAzICsrKwog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2lvY3RsLmMg
Yi9mcy9pb2N0bC5jCmluZGV4IDEyMzQ1Njc4OTBhYi4uYWJjZGVmMTIzNDU2NyAxMDA2NDQKLS0t
IGEvZnMvaW9jdGwuYworKysgYi9mcy9pb2N0bC5jCkBAIC0xOTksNiArMTk5LDkgQEAgc3RhdGlj
IGludCBpb2N0bF9maWVtYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBmaWVtYXAgX191c2Vy
ICp1ZmllbWFwKQogCXN0cnVjdCBmaWVtYXBfZXh0ZW50X2luZm8gZmllaW5mbyA9IHsgMCwgfTsK
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxwKTsKIAlpbnQgZXJyb3I7CisK
KwlpZiAoIWNhcGFibGUoQ0FQX1NZU19SQVdJTykpCisJCXJldHVybiAtRVBFUk07CiAKIAlpZiAo
IWlub2RlLT5pX29wLT5maWVtYXApCiAJCXJldHVybiAtRU9QTk9UU1VQUDsKLS0gCjIuNDAuMAo=

--b1=_hb8YhQAwhZCXIU9G8xbQEjyLoqOllM25eS5t9Lwjmw--


